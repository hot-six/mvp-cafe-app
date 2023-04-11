import 'package:flutter/material.dart';
import 'package:nado_client_mvp/app/core/values/colors.dart';

class SquareInputField extends StatelessWidget {
  final TextInputType? keyboardType;
  final String? hintText;
  final Widget? suffix;
  final TextEditingController textEditingController;
  final Function? onChange;
  final bool? isEnable;

  SquareInputField({
    required this.textEditingController,
    this.keyboardType,
    this.hintText,
    this.suffix,
    this.onChange,
    this.isEnable = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: isEnable,
      keyboardType: keyboardType,
      controller: textEditingController,
      style: TextStyle(
        color: isEnable == true ? Colors.black : NadoColor.greyColor,
      ),
      decoration: InputDecoration(
        suffix: suffix,
        fillColor: isEnable == true ? Colors.white : NadoColor.greyColor[100],
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: NadoColor.greyColor,
          ),
          borderRadius: BorderRadius.circular(6.0),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 23.0,
          vertical: 14.0,
        ),
        hintText: hintText ?? null,
        hintStyle: TextStyle(
          fontSize: 16.0,
          color: NadoColor.greyColor,
        ),
      ),
      onChanged: (string) {
        if (onChange != null) onChange!(string);
      },
    );
  }
}

class SquareMultiInputField extends StatelessWidget {
  final String? hintText;
  final TextEditingController textEditingController;

  SquareMultiInputField({
    required this.textEditingController,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: NadoColor.greyColor,
          ),
          borderRadius: BorderRadius.circular(6.0),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 23.0,
          vertical: 14.0,
        ),
        hintText: hintText ?? null,
        hintStyle: TextStyle(
          fontSize: 16.0,
          color: NadoColor.greyColor,
        ),
      ),
      maxLines: 7,
      minLines: 7,
    );
  }
}

class OvalInputField extends StatelessWidget {
  final String? hintText;
  final TextEditingController textEditingController;

  OvalInputField({
    required this.textEditingController,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: NadoColor.greyColor,
          ),
          borderRadius: BorderRadius.circular(100.0),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 23.0,
          vertical: 14.0,
        ),
        hintText: hintText ?? null,
        hintStyle: TextStyle(
          fontSize: 16.0,
          color: NadoColor.greyColor,
        ),
      ),
    );
  }
}
