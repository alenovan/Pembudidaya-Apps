import 'package:flutter/material.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart' as AppColor;
import 'package:lelenesia_pembudidaya/src/typography.dart' as AppTypo;

enum InputType { text, password, search, field, phone }

class EditTextx extends StatefulWidget {
  final String hintText;
  final InputType inputType;
  final TextEditingController controller;
  final Function onChanged;
  final TextInputType keyboardType;
  final String prefixText;
  final TextAlign textAlign;

  const EditTextx(
      {Key key,
        @required this.hintText,
        this.inputType = InputType.text,
        this.controller,
        this.onChanged,
        this.keyboardType,
        this.prefixText,
        this.textAlign})
      : super(key: key);

  @override
  _EditTextState createState() => _EditTextState();
}

class _EditTextState extends State<EditTextx> {
  bool _obscureText;
  FocusNode _focus = new FocusNode();

  @override
  void initState() {
    super.initState();
    _obscureText = widget.inputType == InputType.password ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: _focus,
      textAlign: widget.textAlign ?? TextAlign.start,
      maxLines: widget.inputType == InputType.field ? 5 : 1,
      keyboardType: widget.keyboardType,
      onChanged: widget.onChanged,
      controller: widget.controller,
      style: AppTypo.body2,
      obscureText: _obscureText,
      decoration: InputDecoration(
          prefixIcon: widget.inputType == InputType.phone
              ? _focus.hasFocus || widget.controller.text.isNotEmpty
              ? Padding(
              padding: EdgeInsets.fromLTRB(20, 14, 5, 14),
              child: Text(
                '+62',
                style: AppTypo.body2.copyWith(color: Colors.grey),
              ))
              : null
              : widget.inputType == InputType.search
              ? Icon(Icons.search)
              : null,
          // prefixIcon: ,
          contentPadding: EdgeInsets.fromLTRB(
              20, 14, widget.inputType == InputType.password ? 4 : 20, 14),
          hintText: widget.inputType == InputType.phone && _focus.hasFocus
              ? null
              : widget.hintText,
          filled: true,
          fillColor: widget.inputType == InputType.field
              ? AppColor.editTextField
              : AppColor.editText,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: AppColor.editText, width: 0.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: AppColor.editText, width: 0.0),
          ),
          suffixIcon: widget.inputType == InputType.password
              ? Container(
            margin: EdgeInsets.only(right: 15),
            child: new GestureDetector(
              onTap: () => setState(() => _obscureText = !_obscureText),
              child: new Icon(
                _obscureText ? Icons.visibility : Icons.visibility_off,
                color: AppColor.editTextIcon,
              ),
            ),
          )
              : null),
    );
  }
}