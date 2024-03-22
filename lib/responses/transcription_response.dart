abstract class TranscriptionData {
  const TranscriptionData();
}

class TextTranscriptionData extends TranscriptionData {
  final String? text;

  const TextTranscriptionData({
    this.text,
  });

  TextTranscriptionData copy({
    String? text,
  }) {
    return TextTranscriptionData(
      text: text ?? this.text,
    );
  }

  factory TextTranscriptionData.from(Map<String, dynamic> source) {
    return TextTranscriptionData(
      text: source["text"],
    );
  }

  Map<String, dynamic> get source {
    return {
      "text": text,
    };
  }
}

class WordTranscriptionData extends TranscriptionData {
  final String? task;
  final String? language;
  final double? duration;
  final String? text;
  final List<WordTranscriptionDatum>? words;

  const WordTranscriptionData({
    this.task,
    this.language,
    this.duration,
    this.text,
    this.words,
  });

  WordTranscriptionData copy({
    String? task,
    String? language,
    double? duration,
    String? text,
    List<WordTranscriptionDatum>? words,
  }) {
    return WordTranscriptionData(
      task: task ?? this.task,
      language: language ?? this.language,
      duration: duration ?? this.duration,
      text: text ?? this.text,
      words: words ?? this.words,
    );
  }

  factory WordTranscriptionData.from(Map<String, dynamic> source) {
    return WordTranscriptionData(
      task: source["task"],
      language: source["language"],
      duration: source["duration"]?.toDouble(),
      text: source["text"],
      words: source["words"] == null
          ? []
          : List<WordTranscriptionDatum>.from(source["words"]!.map((x) => WordTranscriptionDatum.from(x))),
    );
  }

  Map<String, dynamic> get source {
    return {
      "task": task,
      "language": language,
      "duration": duration,
      "text": text,
      "words":
          words == null ? [] : List<dynamic>.from(words!.map((x) => x.source)),
    };
  }
}

class WordTranscriptionDatum {
  final String? word;
  final double? start;
  final double? end;

  const WordTranscriptionDatum({
    this.word,
    this.start,
    this.end,
  });

  WordTranscriptionDatum copy({
    String? word,
    double? start,
    double? end,
  }) {
    return WordTranscriptionDatum(
      word: word ?? this.word,
      start: start ?? this.start,
      end: end ?? this.end,
    );
  }

  factory WordTranscriptionDatum.from(Map<String, dynamic> source) {
    return WordTranscriptionDatum(
      word: source["word"],
      start: source["start"]?.toDouble(),
      end: source["end"]?.toDouble(),
    );
  }

  Map<String, dynamic> get source {
    return {
      "word": word,
      "start": start,
      "end": end,
    };
  }
}

class SegmentTranscriptionData extends TranscriptionData {
  final String? task;
  final String? language;
  final double? duration;
  final String? text;
  final List<SegmentTranscriptionDatum>? segments;

  const SegmentTranscriptionData({
    this.task,
    this.language,
    this.duration,
    this.text,
    this.segments,
  });

  SegmentTranscriptionData copy({
    String? task,
    String? language,
    double? duration,
    String? text,
    List<SegmentTranscriptionDatum>? segments,
  }) {
    return SegmentTranscriptionData(
      task: task ?? this.task,
      language: language ?? this.language,
      duration: duration ?? this.duration,
      text: text ?? this.text,
      segments: segments ?? this.segments,
    );
  }

  factory SegmentTranscriptionData.from(Map<String, dynamic> source) {
    return SegmentTranscriptionData(
      task: source["task"],
      language: source["language"],
      duration: source["duration"]?.toDouble(),
      text: source["text"],
      segments: source["segments"] == null
          ? []
          : List<SegmentTranscriptionDatum>.from(source["segments"]!.map((x) => SegmentTranscriptionDatum.from(x))),
    );
  }

  Map<String, dynamic> get source {
    return {
      "task": task,
      "language": language,
      "duration": duration,
      "text": text,
      "segments": segments == null
          ? []
          : List<dynamic>.from(segments!.map((x) => x.source)),
    };
  }
}

class SegmentTranscriptionDatum {
  final int? id;
  final int? seek;
  final int? start;
  final double? end;
  final String? text;
  final List<int>? tokens;
  final int? temperature;
  final double? avgLogprob;
  final double? compressionRatio;
  final double? noSpeechProb;

  const SegmentTranscriptionDatum({
    this.id,
    this.seek,
    this.start,
    this.end,
    this.text,
    this.tokens,
    this.temperature,
    this.avgLogprob,
    this.compressionRatio,
    this.noSpeechProb,
  });

  SegmentTranscriptionDatum copy({
    int? id,
    int? seek,
    int? start,
    double? end,
    String? text,
    List<int>? tokens,
    int? temperature,
    double? avgLogprob,
    double? compressionRatio,
    double? noSpeechProb,
  }) {
    return SegmentTranscriptionDatum(
      id: id ?? this.id,
      seek: seek ?? this.seek,
      start: start ?? this.start,
      end: end ?? this.end,
      text: text ?? this.text,
      tokens: tokens ?? this.tokens,
      temperature: temperature ?? this.temperature,
      avgLogprob: avgLogprob ?? this.avgLogprob,
      compressionRatio: compressionRatio ?? this.compressionRatio,
      noSpeechProb: noSpeechProb ?? this.noSpeechProb,
    );
  }

  factory SegmentTranscriptionDatum.from(Map<String, dynamic> source) {
    return SegmentTranscriptionDatum(
      id: source["id"],
      seek: source["seek"],
      start: source["start"],
      end: source["end"]?.toDouble(),
      text: source["text"],
      tokens: source["tokens"] == null
          ? []
          : List<int>.from(source["tokens"]!.map((x) => x)),
      temperature: source["temperature"],
      avgLogprob: source["avg_logprob"]?.toDouble(),
      compressionRatio: source["compression_ratio"]?.toDouble(),
      noSpeechProb: source["no_speech_prob"]?.toDouble(),
    );
  }

  Map<String, dynamic> get source {
    return {
      "id": id,
      "seek": seek,
      "start": start,
      "end": end,
      "text": text,
      "tokens": tokens == null ? [] : List<dynamic>.from(tokens!.map((x) => x)),
      "temperature": temperature,
      "avg_logprob": avgLogprob,
      "compression_ratio": compressionRatio,
      "no_speech_prob": noSpeechProb,
    };
  }
}
