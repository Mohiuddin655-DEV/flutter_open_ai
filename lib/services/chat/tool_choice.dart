abstract class ToolChoice {
  const ToolChoice();
}

class TextToolChoice extends ToolChoice {
  final String text;

  const TextToolChoice(this.text);
}

class FunctionToolChoice extends ToolChoice {}
