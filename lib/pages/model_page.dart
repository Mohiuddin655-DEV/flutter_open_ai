import 'package:flutter/material.dart';

import '../responses/model_response.dart';
import '../service.dart';

class ModelWidget extends StatefulWidget {
  const ModelWidget({super.key});

  @override
  State<ModelWidget> createState() => _ModelWidgetState();
}

class _ModelWidgetState extends State<ModelWidget> {
  List<Model> models = [];

  @override
  void initState() {
    super.initState();
    OpenAi.i.models().then((value) {
      setState(() => models = value?.data ?? []);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: models.length,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      itemBuilder: (context, index) {
        final item = models[index];
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.white,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 24,
          ),
          alignment: Alignment.center,
          child: Text(
            item.id?.toUpperCase() ?? "",
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.grey,
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: 12);
      },
    );
  }
}
