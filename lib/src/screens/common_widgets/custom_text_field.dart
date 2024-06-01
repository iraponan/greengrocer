import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    this.initialValue,
    required this.labelText,
    required this.prefixIcon,
    this.isSecret = false,
    this.isReadOnly = false,
    this.textInputFormatter,
    this.textInputType,
    this.textCapitalization = TextCapitalization.none,
  });

  final String labelText;
  final IconData prefixIcon;
  final bool isSecret;
  final bool isReadOnly;
  final TextInputFormatter? textInputFormatter;
  final TextInputType? textInputType;
  final TextCapitalization textCapitalization;
  final String? initialValue;

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
        initialValue: widget.initialValue,
        readOnly: widget.isReadOnly,
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
          labelStyle: const TextStyle(
            color: Colors.grey,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.grey,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(18),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          isDense: true,
        ),
        inputFormatters: widget.textInputFormatter == null
            ? null
            : [
                FilteringTextInputFormatter.digitsOnly,
                widget.textInputFormatter!,
              ],
        keyboardType: widget.textInputType,
        textCapitalization: widget.textCapitalization,
      ),
    );
  }
}
