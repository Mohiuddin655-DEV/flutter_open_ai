part of 'message.dart';

class UserMessage extends Message {
  final Content content;
  final String role;
  final String? name;

  const UserMessage({
    required this.content,
    this.role = "user",
    this.name,
  });

  @override
  Map<String, dynamic> get source {
    final content = this.content;
    return {
      "content": content is TextContent
          ? content.value
          : content is ArrayContent
              ? content.value
              : null,
      "role": role,
      if (name != null) "name": name,
    };
  }
}

abstract class Content {
  const Content();

  factory Content.array(List<SubContent> value) {
    return ArrayContent(content: value);
  }

  factory Content.text(String value) {
    return TextContent(text: value);
  }
}

abstract class SubContent extends Content {
  const SubContent();

  factory SubContent.text(String value) {
    return TextContent(text: value);
  }

  factory SubContent.image(ImageUrlContent value) {
    return ImageContent(content: value);
  }

  Map<String, dynamic> get source;
}

class TextContent extends SubContent {
  final String text;

  const TextContent({
    required this.text,
  });

  String get value => text;

  @override
  Map<String, dynamic> get source {
    return {
      "type": "text",
      "text": text,
    };
  }
}

class ImageUrlContent {
  final String url;
  final String? detail;

  const ImageUrlContent({
    required this.url,
    this.detail,
  });

  Map<String, dynamic> get source {
    return {
      "url": url,
      if (detail != null) "detail": detail,
    };
  }
}

class ImageContent extends SubContent {
  final ImageUrlContent content;

  const ImageContent({
    required this.content,
  });

  @override
  Map<String, dynamic> get source {
    return {
      "type": "image_url",
      "image_url": content.source,
    };
  }
}

class ArrayContent extends Content {
  final List<SubContent> content;

  const ArrayContent({
    required this.content,
  });

  List get value {
    return content.map((e) => e.source).toList();
  }
}
