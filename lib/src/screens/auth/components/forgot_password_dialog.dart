import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocer/src/controllers/auth.dart';
import 'package:greengrocer/src/screens/common_widgets/custom_text_field.dart';
import 'package:greengrocer/src/services/validators.dart';

class ForgotPasswordDialog extends StatelessWidget {
  ForgotPasswordDialog({super.key, required String email}) {
    emailController.text = email;
  }

  final emailController = TextEditingController();
  final authController = Get.find<AuthController>();

  final _formFieldKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'Recuperação de Senha',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 20),
                  child: Text(
                    'Digite seu email para recuperar sua senha.',
                    textAlign: TextAlign.center,
                    style: TextStyle(),
                  ),
                ),
                CustomTextField(
                  formFieldKey: _formFieldKey,
                  controller: emailController,
                  labelText: 'E-mail',
                  prefixIcon: Icons.email,
                  validator: Validators.emailValidator,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formFieldKey.currentState!.validate()) {
                      authController.resetPassword(emailController.text);
                      Get.back(result: true);
                    }
                  },
                  child: const Text(
                    'Recuperar',
                    style: TextStyle(fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.close,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
