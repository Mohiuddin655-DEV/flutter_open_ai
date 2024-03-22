import 'package:flutter/material.dart';
import 'package:flutter_open_ai/pages/audio_transcription_page.dart';
import 'package:flutter_open_ai/pages/text_to_audio_page.dart';

import 'pages/completion_page.dart';
import 'pages/model_page.dart';
import 'service.dart';

void main() {
  OpenAi.init(
    apiKey: "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",
    organizationKey: "org-LyamYliNXiW6NAF6Y9wSfGkl",
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'OpenAi',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          title: const Text(
            "OPEN AI",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Theme.of(context).primaryColor,
          centerTitle: true,
          bottom: const TabBar(
            isScrollable: true,
            indicatorColor: Colors.white,
            labelPadding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            labelStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white,
            ),
            unselectedLabelStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white54,
            ),
            tabs: [
              Text("Models"),
              Text("Completion"),
              Text("Text to Audio"),
              Text("Transcription"),
              Text("Text to Image"),
              Text("Translation"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            ModelWidget(),
            CompletionWidget(),
            TextToAudioPage(),
            AudioTranscriptionPage(),
            CompletionWidget(),
            CompletionWidget(),
          ],
        ),
      ),
    );
  }
}
