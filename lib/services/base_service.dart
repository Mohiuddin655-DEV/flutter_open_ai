import 'dart:developer';

import 'package:dio/dio.dart';

enum RequestTypes { get, post }

class AiResponse {
  final bool isMap;
  final bool isList;
  final int? code;
  final String? error;
  final Object? data;

  const AiResponse._({
    this.isMap = false,
    this.isList = false,
    this.code,
    this.error,
    this.data,
  });

  bool get hasError => error != null;

  Map<String, dynamic> get map {
    return data is Map<String, dynamic> ? data as Map<String, dynamic> : {};
  }

  List get list => data is List ? data as List : [];

  const AiResponse.code(int? value) : this._(code: value);

  const AiResponse.error(Object? value) : this._(error: "$value");

  const AiResponse.map(Map value) : this._(isMap: true, data: value);

  const AiResponse.list(List value) : this._(isList: true, data: value);
}

class Ai {
  final String baseUrl;
  final String version;
  final String apiKey;
  final String? organizationKey;

  Ai({
    required this.baseUrl,
    required this.version,
    required this.apiKey,
    this.organizationKey,
  });

  late final Dio dio = Dio(BaseOptions(
    baseUrl: "$baseUrl/$version/",
    headers: {
      "Authorization": "Bearer $apiKey",
      "OpenAI-Organization": organizationKey,
      "Content-Type": "application/json",
    },
  ));

  late final Dio dioSender = Dio(BaseOptions(
    baseUrl: "$baseUrl/$version/",
    headers: {
      "Authorization": "Bearer $apiKey",
      "OpenAI-Organization": organizationKey,
      "Content-Type": "multipart/form-data",
    },
  ));

  static Ai? _i;

  static Ai get i => _i!;

  static Ai init({
    required String apiKey,
    String? organizationKey,
    String baseUrl = "https://api.openai.com",
    String version = "v1",
  }) {
    return _i ??= Ai(
      baseUrl: baseUrl,
      version: version,
      apiKey: apiKey,
      organizationKey: organizationKey,
    );
  }

  Future<AiResponse> call({
    required String path,
    RequestTypes requestType = RequestTypes.post,
    Map<String, dynamic>? body,
  }) async {
    log("BODY: $body");
    try {
      final response = await (requestType == RequestTypes.post
          ? dio.post(path, data: body)
          : dio.get(path, data: body));

      final code = response.statusCode;
      if (code == 200) {
        final data = response.data;
        if (data is Map<String, dynamic>) {
          return AiResponse.map(data);
        } else if (data is List) {
          return AiResponse.list(data);
        } else {
          return const AiResponse.error("Data undefined!");
        }
      } else {
        return AiResponse.code(response.statusCode);
      }
    } catch (_) {
      return AiResponse.error(_);
    }
  }
}
