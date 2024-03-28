import '../base_service.dart';
import 'message.dart';
import 'tool.dart';

part 'response.dart';

class ChatAi extends Ai {
  ChatAi({
    required super.baseUrl,
    required super.version,
    required super.apiKey,
    super.organizationKey,
  });

  static ChatAi? _i;

  static ChatAi get i => _i!;

  static ChatAi init({
    required String apiKey,
    String? organizationKey,
    String baseUrl = "https://api.openai.com",
    String version = "v1",
  }) {
    return _i ??= ChatAi(
      baseUrl: baseUrl,
      version: version,
      apiKey: apiKey,
      organizationKey: organizationKey,
    );
  }

  Future<ChatAiResponse?> completions({
    required String model,
    required List<Message> messages,
    int? frequencyPenalty,
    Map? logitBias,
    bool? stream,
    int? maxTokens,
    String? toolChoice,
    List<Tool>? tools,
    bool? logprobs,
    int? topLogprobs,
    String? user,
    int? n,
    double? presencePenalty,
    ChatAiResponseFormats? responseFormat,
    int? seed,
    Object? stop,
    double? temperature,
    double? topP,
  }) async {
    return call(
      path: "chat/completions",
      body: {
        "model": model,
        "messages": messages.map((e) => e.source).toList(),
        if (frequencyPenalty != null) "frequency_penalty": frequencyPenalty,
        if (logitBias != null) "logit_bias": logitBias,
        if (logprobs != null) "logprobs": logprobs,
        if (topLogprobs != null) "top_logprobs": topLogprobs,
        if (maxTokens != null) "max_tokens": maxTokens,
        if (n != null) "n": n,
        if (presencePenalty != null) "presence_penalty": presencePenalty,
        if (responseFormat != null) "response_format": responseFormat.name,
        if (seed != null) "seed": seed,
        if (stop is String || stop is List) "stop": stop,
        if (stream != null) "stream": stream,
        if (temperature != null) "temperature": temperature,
        if (topP != null) "top_p": topP,
        if (toolChoice != null) "tool_choice": toolChoice,
        if (tools != null) "tools": tools.map((e) => e.source).toList(),
        if (user != null) "user": user,
      },
    ).then((value) {
      if (value.isMap) {
        return ChatAiResponse.from(value.map);
      } else {
        return null;
      }
    });
  }
}

enum ChatAiResponseFormats {
  text("text"),
  json("json_object");

  final String name;

  const ChatAiResponseFormats(this.name);
}
