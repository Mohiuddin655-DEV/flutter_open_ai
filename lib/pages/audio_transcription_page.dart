import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_open_ai/responses/transcription_response.dart';
import 'package:flutter_open_ai/service.dart';

class AudioTranscriptionPage extends StatefulWidget {
  const AudioTranscriptionPage({super.key});

  @override
  State<AudioTranscriptionPage> createState() => _AudioTranscriptionPageState();
}

class _AudioTranscriptionPageState extends State<AudioTranscriptionPage> {
  final etOutput = TextEditingController();

  File? selectedFile;

  Future<void> pickFile() async {
    log("PICK FILE");
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result != null) {
      setState(() {
        selectedFile = File(result.files.single.path!);
      });
    }
  }

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
            GestureDetector(
              onTap: pickFile,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(25),
                ),
                alignment: Alignment.center,
                child: Text(
                  selectedFile != null
                      ? 'Selected file: ${selectedFile!.path.split('/').last}'
                      : 'Choose file',
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
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
                  OpenAi.i.transcriptions(file: selectedFile!).then((value) {
                    if (value is TextTranscriptionData) {
                      etOutput.text = value.text ?? "";
                    }
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
