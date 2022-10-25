import 'package:e_commerce_app/themes/app_colors.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      required this.labelText,
      required this.hintText,
      this.controller,
      this.obscureText = false,
      this.errorText,
      this.autovalidateMode,
      this.focusNode,
      this.initialValue,
      this.keyboardType,
      this.onChanged,
      this.onEditingComplete,
      this.onFieldSubmitted,
      this.onSaved,
      this.onTap,
      this.validator,
      this.textInputAction});

  final TextEditingController? controller;
  final String labelText;
  final String hintText;
  final String? errorText;
  final AutovalidateMode? autovalidateMode;
  final FocusNode? focusNode;
  final String? initialValue;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Function(String)? onChanged;
  final Function()? onEditingComplete;
  final Function(String)? onFieldSubmitted;
  final Function(String?)? onSaved;
  final Function()? onTap;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autovalidateMode: autovalidateMode,
      focusNode: focusNode,
      initialValue: initialValue,
      keyboardType: keyboardType,
      obscureText: obscureText,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      onFieldSubmitted: onFieldSubmitted,
      onSaved: onSaved,
      onTap: onTap,
      validator: validator,
      textInputAction: textInputAction,
      decoration: InputDecoration(
          label: Text(
            labelText,
            style: const TextStyle(color: AppColors.secondaryColor),
          ),
          errorText: errorText,
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.black38),
          contentPadding: const EdgeInsets.all(16),
          border: _outlineInputBorder(AppColors.secondaryColor),
          focusedBorder: _outlineInputBorder(AppColors.secondaryColor),
          enabledBorder: _outlineInputBorder(AppColors.secondaryColor),
          errorBorder: _outlineInputBorder(Colors.redAccent)),
    );
  }

  _outlineInputBorder(Color color) => OutlineInputBorder(
      borderRadius: const BorderRadius.all(
        Radius.circular(15),
      ),
      borderSide: BorderSide(color: color));
}
