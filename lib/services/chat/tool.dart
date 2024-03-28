class Tool {
  final String type;
  final ToolFunction function;

  const Tool({
    this.type = "function",
    required this.function,
  });

  Map<String, dynamic> get source {
    return {
      "type": type,
      "function": function.source,
    };
  }
}

class ToolFunction {
  final String name;
  final String? description;
  final ToolParameter? parameters;

  const ToolFunction({
    required this.name,
    this.description,
    this.parameters,
  });

  Map<String, dynamic> get source {
    return {
      "name": name,
      if (description != null) "description": description,
      if (parameters != null) "parameters": parameters?.source,
    };
  }
}

class ToolParameter {
  final String type;
  final List<String>? required;
  final Map<String, ToolParameterProperty>? properties;

  const ToolParameter({
    this.type = "object",
    this.properties,
    this.required,
  });

  Map<String, dynamic> get source {
    return {
      "type": type,
      if (required != null) "required": required,
      if (properties != null)
        "properties": Map.fromEntries(
          properties!.entries.map((e) => MapEntry(e.key, e.value.source)),
        ),
    };
  }
}

class ToolParameterProperty {
  final String type;
  final String? description;
  final List<ToolParameterPropertyEnum>? enums;

  const ToolParameterProperty({
    this.type = "string",
    this.description,
    this.enums,
  });

  Map<String, dynamic> get source {
    return {
      "type": type,
      if (description != null) "description": description,
      if (enums != null) "enum": enums?.map((e) => e.name),
    };
  }
}

enum ToolParameterPropertyEnum { celsius, fahrenheit }
