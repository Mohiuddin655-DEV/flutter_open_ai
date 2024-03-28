part 'message_assistant.dart';

part 'message_system.dart';

part 'message_tool.dart';

part 'message_user.dart';

///
/// [AssistantMessage]
/// [SystemMessage]
/// [ToolMessage]
/// [UserMessage]
///
abstract class Message {
  const Message();

  factory Message.assistant({
    String? content,
    String? name,
    List<ToolCall>? toolCalls,
  }) {
    return AssistantMessage(
      content: content,
      name: name,
      toolCalls: toolCalls,
    );
  }

  factory Message.system({
    required String content,
    String? name,
  }) {
    return SystemMessage(
      content: content,
      name: name,
    );
  }

  factory Message.tool({
    required String content,
    required String toolCallId,
  }) {
    return ToolMessage(
      content: content,
      toolCallId: toolCallId,
    );
  }

  factory Message.user({
    required Content content,
    String? name,
  }) {
    return UserMessage(
      content: content,
      name: name,
    );
  }

  Map<String, dynamic> get source;
}
