import 'package:chat_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.label,
    required this.prefixIcon,
    required this.controller,
    required this.obscureText,
    required this.isPassword, this.onChanged,

  });
  final String label;
  final IconData prefixIcon;
  final TextEditingController controller;
  final bool obscureText;
  final bool isPassword;
  final void Function(String)? onChanged;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged:widget.onChanged ,
      validator: (value) => value!.isEmpty ? 'Field cannot be empty' : null,
      controller: widget.controller,
      obscureText: widget.obscureText? !showPassword : false,
      decoration: InputDecoration(
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(!showPassword? Iconsax.eye: Iconsax.eye_slash, color: kPrimaryColor),
                  onPressed: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
              )
              : null,
          contentPadding: const EdgeInsets.all(16),
          hintText: widget.label,
          prefixIcon: Icon(
            widget.prefixIcon,
            color: kPrimaryColor,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(color: kPrimaryColor),
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          )),
    );
  }
}
