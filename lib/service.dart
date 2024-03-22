import 'dart:io';

import 'package:dio/dio.dart';

import 'requests/completion_request.dart';
import 'responses/completion_response.dart';
import 'responses/model_response.dart';
import 'responses/transcription_response.dart';

enum TTSModels {
  tts1("tts-1"),
  tts1Hd("tts-1-hd");

  final String name;

  const TTSModels(this.name);
}

enum TTSVoices {
  alloy,
  echo,
  fable,
  onyx,
  nova,
  shimmer;
}

enum AudioFormats {
  mp3,
  opus,
  aac,
  flac,
  wav,
  pcm;
}

enum TranscriptionModels {
  whisper1("whisper-1");

  final String name;

  const TranscriptionModels(this.name);
}

enum TranscriptionTimestamps {
  word("word"),
  segment("segment");

  final String name;

  const TranscriptionTimestamps(this.name);
}

enum TranscriptionAudioSupports {
  flac,
  mp3,
  mp4,
  mpeg,
  mpga,
  m4a,
  ogg,
  wav,
  webm;
}

enum TranscriptionResponseFormats {
  json("json"),
  text("text"),
  srt("srt"),
  verboseJson("verbose_json"),
  vtt("vtt");

  final String name;

  const TranscriptionResponseFormats(this.name);
}

enum AudioSpeeds {
  x0P25(0.25),
  x4P0(4.0),
  x1P0(1.0);

  final double name;

  const AudioSpeeds(this.name);
}

class OpenAi {
  final String baseUrl;
  final String version;
  final String apiKey;
  final String? organizationKey;

  late final Dio _dio = Dio(BaseOptions(
    baseUrl: "$baseUrl/$version/",
    headers: {
      "Authorization": "Bearer $apiKey",
      "OpenAI-Organization": organizationKey,
      "Content-Type": "application/json",
    },
  ));

  late final Dio _dioSender = Dio(BaseOptions(
    baseUrl: "$baseUrl/$version/",
    headers: {
      "Authorization": "Bearer $apiKey",
      "OpenAI-Organization": organizationKey,
      "Content-Type": "multipart/form-data",
    },
  ));

  OpenAi._({
    required this.baseUrl,
    required this.version,
    required this.apiKey,
    this.organizationKey,
  });

  static OpenAi? _i;

  static OpenAi get i => _i!;

  static OpenAi init({
    required String apiKey,
    String? organizationKey,
    String baseUrl = "https://api.openai.com",
    String version = "v1",
  }) {
    return _i ??= OpenAi._(
      baseUrl: baseUrl,
      version: version,
      apiKey: apiKey,
      organizationKey: organizationKey,
    );
  }

  Future<ModelResponse?> models() async {
    try {
      final response = await _dio.get("models");
      final code = response.statusCode;
      if (code == 200) {
        final data = response.data;
        if (data is Map<String, dynamic>) {
          return ModelResponse.from(data);
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (_) {
      return null;
    }
  }

  Future<CompletionResponse?> completion(CompletionRequest request) async {
    try {
      final response = await _dio.post(
        "chat/completions",
        data: request.source,
      );

      final code = response.statusCode;
      if (code == 200) {
        final data = response.data;
        if (data is Map<String, dynamic>) {
          return CompletionResponse.from(data);
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (_) {
      return null;
    }
  }

  Future<dynamic> speech({
    required String text,
    TTSModels model = TTSModels.tts1,
    TTSVoices voice = TTSVoices.alloy,
    AudioFormats? audioFormat = AudioFormats.mp3,
    AudioSpeeds? speed = AudioSpeeds.x1P0,
  }) async {
    try {
      final response = await _dio.post(
        "audio/speech",
        data: {
          "input": text,
          "model": model.name,
          "voice": voice.name,
          "response_format": audioFormat?.name,
          "speed": speed?.name,
        },
      );

      final code = response.statusCode;
      if (code == 200) {
        final data = response.data;
        return data;
      } else {
        return null;
      }
    } catch (_) {
      return null;
    }
  }

  Future<TranscriptionData?> transcriptions({
    required File file,
    String? language,
    String? prompt,
    double? temperature,
    TranscriptionTimestamps? granularities,
    TranscriptionResponseFormats? format,
    TranscriptionModels model = TranscriptionModels.whisper1,
  }) async {
    final data = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        file.path,
        filename: file.path.split('/').last,
      ),
      "model": model.name,
      if (language != null) "language": language,
      if (prompt != null) "prompt": prompt,
      if (format != null) "response_format": format.name,
      if (temperature != null) "temperature": temperature,
      if (granularities != null) "timestamp_granularities": granularities.name,
    });
    try {
      final response = await _dioSender.post(
        "audio/transcriptions",
        data: data,
      );

      final code = response.statusCode;
      if (code == 200) {
        final data = response.data;
        if (data is Map<String, dynamic>) {
          if (granularities == TranscriptionTimestamps.segment) {
            return SegmentTranscriptionData.from(data);
          } else if (granularities == TranscriptionTimestamps.word) {
            return WordTranscriptionData.from(data);
          } else {
            return TextTranscriptionData.from(data);
          }
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (_) {
      return null;
    }
  }

  Future<String?> translations({
    required File file,
    String? prompt,
    double? temperature,
    TranscriptionResponseFormats? format,
    TranscriptionModels model = TranscriptionModels.whisper1,
  }) async {
    final data = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        file.path,
        filename: file.path.split('/').last,
      ),
      "model": model.name,
      if (prompt != null) "prompt": prompt,
      if (format != null) "response_format": format.name,
      if (temperature != null) "temperature": temperature,
    });
    try {
      final response = await _dioSender.post(
        "audio/translations",
        data: data,
      );

      final code = response.statusCode;
      if (code == 200) {
        final data = response.data;
        if (data is Map<String, dynamic>) {
          return data["text"];
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (_) {
      return null;
    }
  }
}
