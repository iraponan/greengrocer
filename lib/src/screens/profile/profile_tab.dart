import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocer/src/controllers/auth.dart';
import 'package:greengrocer/src/helpers/utils/consts.dart';
import 'package:greengrocer/src/screens/common_widgets/custom_text_field.dart';
import 'package:greengrocer/src/services/validators.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              authController.signOut();
            },
            icon: const Icon(
              Icons.logout,
            ),
          ),
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
        children: [
          CustomTextField(
            initialValue: authController.user.email,
            isReadOnly: true,
            prefixIcon: Icons.email,
            labelText: 'E-mail',
            textInputType: TextInputType.emailAddress,
            textCapitalization: TextCapitalization.none,
          ),
          CustomTextField(
            initialValue: authController.user.name,
            isReadOnly: true,
            prefixIcon: Icons.person,
            labelText: 'Nome',
            textCapitalization: TextCapitalization.words,
          ),
          CustomTextField(
            initialValue: authController.user.phone,
            isReadOnly: true,
            prefixIcon: Icons.phone,
            labelText: 'Celular',
            textInputType: TextInputType.number,
            textInputFormatter: TelefoneInputFormatter(),
          ),
          CustomTextField(
            initialValue: authController.user.cpfCnpj,
            isSecret: true,
            isReadOnly: true,
            prefixIcon: Icons.person_pin,
            labelText: 'CPF',
            textInputType: TextInputType.number,
            textInputFormatter: CpfInputFormatter(),
          ),
          SizedBox(
            height: VariablesUtils.heightButton,
            child: OutlinedButton(
              onPressed: () => updatePassword(),
              child: const Text('Atualizar Senha'),
            ),
          ),
        ],
      ),
    );
  }

  Future<bool?> updatePassword() {
    final newPasswordController = TextEditingController();
    final currentPasswordController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return showDialog(
      context: context,
      builder: (c) => Dialog(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        'Atualização de Senha',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    CustomTextField(
                      controller: currentPasswordController,
                      labelText: 'Senha Atual',
                      prefixIcon: Icons.lock,
                      isSecret: true,
                      validator: Validators.passwordValidator,
                    ),
                    CustomTextField(
                      controller: newPasswordController,
                      labelText: 'Nova Senha',
                      prefixIcon: Icons.lock_outlined,
                      isSecret: true,
                      validator: Validators.passwordValidator,
                    ),
                    CustomTextField(
                      labelText: 'Confirmar Nova Senha',
                      prefixIcon: Icons.lock_outline,
                      isSecret: true,
                      validator: (password) {
                        final validator =
                            Validators.passwordValidator(password);
                        if (validator != null) {
                          return validator;
                        }
                        if (password != newPasswordController.text) {
                          return 'As senhas não são equivalentes';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: VariablesUtils.heightButton,
                      child: Obx(() => ElevatedButton(
                            onPressed: authController.isLoading.value
                                ? null
                                : () {
                                    if (formKey.currentState!.validate()) {
                                      FocusScope.of(context).unfocus();
                                      authController.changePassword(
                                        currentPassword:
                                            currentPasswordController.text,
                                        newPassword: newPasswordController.text,
                                      );
                                    }
                                  },
                            child: authController.isLoading.value
                                ? const CircularProgressIndicator()
                                : const Text('Atualizar'),
                          )),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 5,
              right: 5,
              child: IconButton(
                onPressed: () => Navigator.of(c).pop(),
                icon: const Icon(
                  Icons.close,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
