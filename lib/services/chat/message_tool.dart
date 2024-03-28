part of 'message.dart';

class ToolMessage extends Message {
  final String content;
  final String role;
  final String toolCallId;

  const ToolMessage({
    this.role = "tool",
    required this.content,
    required this.toolCallId,
  });

  @override
  Map<String, dynamic> get source {
    return {
      "role": role,
      "content": content,
      "tool_call_id": toolCallId,
    };
  }
}
