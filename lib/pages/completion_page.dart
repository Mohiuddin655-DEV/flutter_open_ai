import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_open_ai/service.dart';

import '../enums/models.dart';
import '../enums/role.dart';
import '../requests/completion_request.dart';

class CompletionWidget extends StatefulWidget {
  const CompletionWidget({super.key});

  @override
  State<CompletionWidget> createState() => _CompletionWidgetState();
}

class _CompletionWidgetState extends State<CompletionWidget> {
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
                  final request = CompletionRequest(
                    model: Models.gpt3P5Turbo.name,
                    messages: [
                      Message(
                        role: Roles.user.name,
                        content: etInput.text,
                      ),
                    ],
                  );
                  OpenAi.i.completion(request).then((value) {
                    etOutput.text =
                        value?.choices?.firstOrNull?.message?.content ?? "";
                    log("COMPLETION RESPONSE: $value");
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
