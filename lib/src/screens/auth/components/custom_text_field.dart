import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.labelText,
    this.prefixIcon,
    this.isSecret = false,
  });

  final String labelText;
  final IconData? prefixIcon;
  final bool isSecret;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool isObscure;

  @override
  void initState() {
    super.initState();
    isObscure = widget.isSecret;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        obscureText: isObscure,
        decoration: InputDecoration(
          prefixIcon: Icon(widget.prefixIcon),
          suffixIcon: widget.isSecret
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      isObscure = !isObscure;
                    });
                  },
                  icon:
                      Icon(isObscure ? Icons.visibility : Icons.visibility_off),
                )
              : null,
          labelText: widget.labelText,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.green,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(18),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          isDense: true,
        ),
      ),
    );
  }
}
