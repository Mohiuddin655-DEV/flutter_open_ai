part of 'message.dart';

class AssistantMessage extends Message {
  final String? content;
  final String role;
  final String? name;
  final List<ToolCall>? toolCalls;

  const AssistantMessage({
    this.content,
    this.role = "assistant",
    this.name,
    this.toolCalls,
  });

  @override
  Map<String, dynamic> get source {
    return {
      "content": content,
      "role": role,
      if (toolCalls != null) "tool_calls": toolCalls?.map((e) => e.source),
      if (name != null) "name": name,
    };
  }
}

class ToolCall {
  final String id;
  final String type;
  final ToolCallFunction function;

  const ToolCall({
    required this.id,
    this.type = "function",
    required this.function,
  });

  Map<String, dynamic> get source {
    return {
      "id": id,
      "type": type,
      "function": function.source,
    };
  }
}

class ToolCallFunction {
  final String name;
  final String arguments;

  const ToolCallFunction({
    required this.name,
    required this.arguments,
  });

  Map<String, dynamic> get source {
    return {
      "name": name,
      "arguments": arguments,
    };
  }
}
