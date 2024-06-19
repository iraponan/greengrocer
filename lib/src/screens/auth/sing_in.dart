import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocer/src/config/custom_colors.dart';
import 'package:greengrocer/src/controllers/auth.dart';
import 'package:greengrocer/src/helpers/utils/consts.dart';
import 'package:greengrocer/src/helpers/utils/variables.dart';
import 'package:greengrocer/src/screens/common_widgets/app_name.dart';
import 'package:greengrocer/src/screens/common_widgets/custom_text_field.dart';

class SingInScreen extends StatefulWidget {
  const SingInScreen({super.key});

  @override
  State<SingInScreen> createState() => _SingInScreenState();
}

class _SingInScreenState extends State<SingInScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: CustomColors.customSwathColor,
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              // # Nome do APP #
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const AppName(
                      greenTitleColor: Colors.white,
                      textSize: 40,
                    ),
                    // # Categoria #
                    SizedBox(
                      height: 30,
                      child: DefaultTextStyle(
                        style: const TextStyle(
                          fontSize: 25,
                        ),
                        child: AnimatedTextKit(
                          repeatForever: true,
                          pause: Duration.zero,
                          animatedTexts: [
                            FadeAnimatedText('Frutas'),
                            FadeAnimatedText('Verduras'),
                            FadeAnimatedText('Legumes'),
                            FadeAnimatedText('Carnes'),
                            FadeAnimatedText('Cereais'),
                            FadeAnimatedText('Laticínios'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // # Formulário #
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 40,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(45),
                  ),
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // # E-mail #
                      CustomTextField(
                        controller: emailController,
                        labelText: 'E-mail',
                        prefixIcon: Icons.email,
                        textInputType: TextInputType.emailAddress,
                        validator: (email) {
                          if (email == null || email.isEmpty) {
                            return 'Digite seu e-mail!';
                          } else if (!email.isEmail) {
                            return 'Digite um e-mail valido!';
                          }
                          return null;
                        },
                      ),
                      // # Senha #
                      CustomTextField(
                        controller: passwordController,
                        labelText: 'Senha',
                        prefixIcon: Icons.lock,
                        isSecret: true,
                        validator: (password) {
                          if (password == null || password.isEmpty) {
                            return 'Digite sua senha!';
                          } else if (password.length < 7) {
                            return 'Digite uma senha com pelo menos 7 caracteres!';
                          }
                          return null;
                        },
                      ),
                      // # Botão de Entrar #
                      SizedBox(
                        height: VariablesUtils.heightButton,
                        child: GetX<AuthController>(
                          builder: (authController) {
                            return ElevatedButton(
                              onPressed: authController.isLoading.value
                                  ? null
                                  : () {
                                      FocusScope.of(context).unfocus();
                                      if (formKey.currentState!.validate()) {
                                        String email = emailController.text;
                                        String password =
                                            passwordController.text;
                                        authController.signIn(
                                            email: email, password: password);
                                      } else {
                                        print('Campos não válidos.');
                                      }
                                      //Get.offNamed(PageRoutes.baseRoute);
                                    },
                              child: authController.isLoading.value
                                  ? const CircularProgressIndicator()
                                  : const Text(
                                      'Entrar',
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                            );
                          },
                        ),
                      ),
                      // # Esqueceu a Senha #
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            'Esqueceu a Senha?',
                            style: TextStyle(
                              color: CustomColors.customContrastColor,
                            ),
                          ),
                        ),
                      ),
                      // Divisor
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: Colors.grey.withAlpha(90),
                                thickness: 2,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Text('Ou'),
                            ),
                            Expanded(
                              child: Divider(
                                color: Colors.grey.withAlpha(90),
                                thickness: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // # Criar Conta #
                      SizedBox(
                        height: 50,
                        child: OutlinedButton(
                          onPressed: () => Get.toNamed(PageRoutes.signUpRoute),
                          child: const Text(
                            'Criar Conta',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
