class CompletionResponse {
  final String? id;
  final String? object;
  final int? created;
  final String? model;
  final List<CompletionChoice>? choices;
  final CompletionUsage? usage;
  final String? systemFingerprint;

  const CompletionResponse({
    this.id,
    this.object,
    this.created,
    this.model,
    this.choices,
    this.usage,
    this.systemFingerprint,
  });

  CompletionResponse copy({
    String? id,
    String? object,
    int? created,
    String? model,
    List<CompletionChoice>? choices,
    CompletionUsage? usage,
    String? systemFingerprint,
  }) {
    return CompletionResponse(
      id: id ?? this.id,
      object: object ?? this.object,
      created: created ?? this.created,
      model: model ?? this.model,
      choices: choices ?? this.choices,
      usage: usage ?? this.usage,
      systemFingerprint: systemFingerprint ?? this.systemFingerprint,
    );
  }

  factory CompletionResponse.from(Map<String, dynamic> source) {
    final id = source["id"];
    final object = source["object"];
    final created = source["created"];
    final model = source["model"];
    final choices = source["choices"];
    final usage = source["usage"];
    final systemFingerprint = source["system_fingerprint"];
    return CompletionResponse(
      id: id is String ? id : null,
      object: object is String ? object : null,
      created: created is int ? created : null,
      model: model is String ? model : null,
      choices:
          choices is List ? choices.map((i) => CompletionChoice.from(i)).toList() : null,
      usage: usage is Map<String, dynamic> ? CompletionUsage.from(usage) : null,
      systemFingerprint: systemFingerprint is String ? systemFingerprint : null,
    );
  }

  Map<String, dynamic> get source {
    return {
      "id": id,
      "object": object,
      "created": created,
      "model": model,
      "choices": choices?.map((i) => i.source),
      "usage": usage?.source,
      "system_fingerprint": systemFingerprint,
    };
  }

  @override
  String toString() {
    return "Completion(${source.toString().replaceAll("{", "").replaceAll("}", "")})";
  }
}

class CompletionChoice {
  final int? index;
  final CompletionMessage? message;
  final dynamic logprobs;
  final String? finishReason;

  const CompletionChoice({
    this.index,
    this.message,
    this.logprobs,
    this.finishReason,
  });

  CompletionChoice copy({
    int? index,
    CompletionMessage? message,
    dynamic logprobs,
    String? finishReason,
  }) {
    return CompletionChoice(
      index: index ?? this.index,
      message: message ?? this.message,
      logprobs: logprobs ?? this.logprobs,
      finishReason: finishReason ?? this.finishReason,
    );
  }

  factory CompletionChoice.from(Map<String, dynamic> source) {
    final index = source["index"];
    final message = source["message"];
    final logprobs = source["logprobs"];
    final finishReason = source["finish_reason"];
    return CompletionChoice(
      index: index is int ? index : null,
      message: message is Map<String, dynamic> ? CompletionMessage.from(message) : null,
      logprobs: logprobs,
      finishReason: finishReason is String ? finishReason : null,
    );
  }

  Map<String, dynamic> get source {
    return {
      "index": index,
      "message": message?.source,
      "logprobs": logprobs,
      "finish_reason": finishReason,
    };
  }

  @override
  String toString() {
    return "Choice(${source.toString().replaceAll("{", "").replaceAll("}", "")})";
  }
}

class CompletionMessage {
  final String? role;
  final String? content;

  const CompletionMessage({
    this.role,
    this.content,
  });

  CompletionMessage copy({
    String? role,
    String? content,
  }) {
    return CompletionMessage(
      role: role ?? this.role,
      content: content ?? this.content,
    );
  }

  factory CompletionMessage.from(Map<String, dynamic> source) {
    final role = source["role"];
    final content = source["content"];
    return CompletionMessage(
      role: role is String ? role : null,
      content: content is String ? content : null,
    );
  }

  Map<String, dynamic> get source {
    return {
      "role": role,
      "content": content,
    };
  }

  @override
  String toString() {
    return "Message(${source.toString().replaceAll("{", "").replaceAll("}", "")})";
  }
}

class CompletionUsage {
  final int? promptTokens;
  final int? completionTokens;
  final int? totalTokens;

  const CompletionUsage({
    this.promptTokens,
    this.completionTokens,
    this.totalTokens,
  });

  CompletionUsage copy({
    int? promptTokens,
    int? completionTokens,
    int? totalTokens,
  }) {
    return CompletionUsage(
      promptTokens: promptTokens ?? this.promptTokens,
      completionTokens: completionTokens ?? this.completionTokens,
      totalTokens: totalTokens ?? this.totalTokens,
    );
  }

  factory CompletionUsage.from(Map<String, dynamic> source) {
    final promptTokens = source["prompt_tokens"];
    final completionTokens = source["completion_tokens"];
    final totalTokens = source["total_tokens"];
    return CompletionUsage(
      promptTokens: promptTokens is int ? promptTokens : null,
      completionTokens: completionTokens is int ? completionTokens : null,
      totalTokens: totalTokens is int ? totalTokens : null,
    );
  }

  Map<String, dynamic> get source {
    return {
      "prompt_tokens": promptTokens,
      "completion_tokens": completionTokens,
      "total_tokens": totalTokens,
    };
  }

  @override
  String toString() {
    return "Usage(${source.toString().replaceAll("{", "").replaceAll("}", "")})";
  }
}
