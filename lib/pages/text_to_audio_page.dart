import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_open_ai/service.dart';

class TextToAudioPage extends StatefulWidget {
  const TextToAudioPage({super.key});

  @override
  State<TextToAudioPage> createState() => _TextToAudioPageState();
}

class _TextToAudioPageState extends State<TextToAudioPage> {
  final etInput = TextEditingController();
  final etOutput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 32,
          vertical: 24,
        ),
        child: Column(
          children: [
            EditField(
              controller: etInput,
              hint: "Input",
            ),
            const SizedBox(height: 24),
            EditField(
              controller: etOutput,
              hint: "Output",
              minLine: 5,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  OpenAi.i.speech(text: etInput.text).then((value) {
                    etOutput.text = value.runtimeType.toString();
                    log("RESPONSE: $value");
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                child: const Text(
                  "SUBMIT",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EditField extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final String? text;
  final int? maxLine;
  final int? minLine;

  const EditField({
    super.key,
    required this.controller,
    required this.hint,
    this.text,
    this.maxLine,
    this.minLine,
  });

  @override
  State<EditField> createState() => _EditFieldState();
}

class _EditFieldState extends State<EditField> {
  @override
  void initState() {
    super.initState();
    widget.controller.text = widget.text ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: widget.maxLine,
      minLines: widget.minLine,
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: widget.hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 16,
        ),
      ),
    );
  }
}
