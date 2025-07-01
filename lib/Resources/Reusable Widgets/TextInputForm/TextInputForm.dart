import 'package:flutter/material.dart';


class TextInputForm extends StatelessWidget {
  final TextEditingController myController;
  final FocusNode  focusNode;
  final FormFieldSetter onFieldSubmittedView;
  final FormFieldValidator onValidator;
  final TextInputType keyBoardType;
  final String hint;
  final bool enable,autoFocus;
  final IconData iconData;
  const TextInputForm({super.key, required this.myController, required this.focusNode, required this.onFieldSubmittedView, required this.keyBoardType, required this.hint,  this.enable = true,  this.autoFocus = false, required this.iconData, required this.onValidator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyBoardType,
      controller: myController,
      enabled: enable,
      focusNode: focusNode,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle:  Theme.of(context).textTheme.bodySmall?.copyWith(
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
        ),
        prefixIcon: Icon(iconData),
      ),
      onFieldSubmitted: onFieldSubmittedView,
      validator: onValidator,
    );
  }
}
