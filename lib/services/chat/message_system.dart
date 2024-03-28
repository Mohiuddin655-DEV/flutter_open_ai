part of 'message.dart';

class SystemMessage extends Message {
  final String content;
  final String role;
  final String? name;

  const SystemMessage({
    required this.content,
    this.role = "system",
    this.name,
  });

  @override
  Map<String, dynamic> get source {
    return {
      "content": content,
      "role": role,
      if (name != null) "name": name,
    };
  }
}
