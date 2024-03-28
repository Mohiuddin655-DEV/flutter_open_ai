import 'package:flutter_open_ai/enums/role.dart';

import '../enums/models.dart';

class CompletionRequest {
  final String? model;
  final List<CompletionMessage>? messages;
  final double? temperature;

  const CompletionRequest({
    this.model,
    this.messages,
    this.temperature,
  });

  Map<String, dynamic> get source {
    return {
      "model": model,
      "messages": messages?.map((e) => e.source).toList(),
      "temperature": temperature,
    };
  }
}

class CompletionMessage {
  final String? role;
  final String? content;

  const CompletionMessage({
    this.role,
    this.content,
  });

  Map<String, dynamic> get source {
    return {
      "role": role,
      "content": content,
    };
  }
}
