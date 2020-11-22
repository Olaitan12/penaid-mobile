import 'package:flutter/material.dart';

class TextInputField extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) onChanged;
  final Widget icon;
  final String label;
  final String initialValue;
  final List<int> lines;
  // final Validation validation;
  // final TextFormBloc bloc;
  final Stream<String> stream;

  TextInputField({
    this.controller,
    // this.validation,
    this.icon,
    this.initialValue = "",
    this.label,
    this.lines = const [],
    this.stream,
    // this.bloc,
    this.onChanged,
  });
  _TextInputField createState() => _TextInputField();
}

class _TextInputField extends State<TextInputField> {
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Container(
        child: StreamBuilder<String>(
          stream: widget.stream,
          builder: (context, snapshot) => TextFormField(
            // controller: widget.controller,
            initialValue:
                widget.initialValue.isEmpty ? null : widget.initialValue,
            enabled: widget.initialValue.isEmpty ? true : false,
            minLines: widget.lines.isNotEmpty ? widget.lines[0] : null,
            maxLines: widget.lines.isNotEmpty ? widget.lines[1] : null,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: widget.label,
              icon: widget.icon,
              errorText: snapshot.error,
            ),
            onChanged: widget.onChanged,
          ),
        ),
      ),
    );
  }
}
