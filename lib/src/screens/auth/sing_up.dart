import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:greengrocer/src/config/custom_colors.dart';
import 'package:greengrocer/src/helpers/utils/variables.dart';
import 'package:greengrocer/src/screens/common_widgets/custom_text_field.dart';
import 'package:greengrocer/src/services/validators.dart';

class SingUpScreen extends StatefulWidget {
  const SingUpScreen({super.key});

  @override
  State<SingUpScreen> createState() => _SingUpScreenState();
}

class _SingUpScreenState extends State<SingUpScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: CustomColors.customSwathColor,
      body: SingleChildScrollView(
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Stack(
            children: [
              Column(
                children: [
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Cadastro',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                        ),
                      ),
                    ),
                  ),
                  // # Formulário #
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 40),
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
                          const CustomTextField(
                            labelText: 'E-mail',
                            prefixIcon: Icons.email,
                            textInputType: TextInputType.emailAddress,
                            validator: Validators.emailValidator,
                          ),
                          const CustomTextField(
                            labelText: 'Senha',
                            prefixIcon: Icons.lock,
                            isSecret: true,
                            validator: Validators.passwordValidator,
                          ),
                          const CustomTextField(
                            labelText: 'Nome Completo',
                            prefixIcon: Icons.person,
                            textCapitalization: TextCapitalization.words,
                            validator: Validators.nameValidator,
                          ),
                          CustomTextField(
                            labelText: 'Celular',
                            prefixIcon: Icons.phone,
                            textInputFormatter: TelefoneInputFormatter(),
                            textInputType: TextInputType.number,
                            validator: Validators.phoneValidator,
                          ),
                          CustomTextField(
                            labelText: 'CPF',
                            prefixIcon: Icons.person_pin,
                            textInputFormatter: CpfInputFormatter(),
                            textInputType: TextInputType.number,
                            validator: Validators.cpfCnpjValidator,
                          ),
                          SizedBox(
                            height: VariablesUtils.heightButton,
                            child: ElevatedButton(
                              onPressed: () {
                                formKey.currentState!.validate();
                              },
                              child: const Text(
                                'Cadastrar o Usuário',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Positioned(
                top: 10,
                left: 10,
                child: SafeArea(
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.arrow_back),
                    color: Colors.white,
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
