import 'package:flutter/services.dart';

class SumInputFormatter extends TextInputFormatter{
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final StringBuffer newText = StringBuffer();
    newText.write(newValue.text.substring(newValue.text.startsWith('0') ? 1 : 0, newValue.text.length)+' руб');

    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: newText.toString().length-4),
    );
  }
}