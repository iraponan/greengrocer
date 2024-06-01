import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:greengrocer/src/config/custom_colors.dart';
import 'package:greengrocer/src/screens/auth/components/custom_text_field.dart';

class SingUpScreen extends StatelessWidget {
  const SingUpScreen({super.key});

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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const CustomTextField(
                          labelText: 'E-mail',
                          prefixIcon: Icons.email,
                          textInputType: TextInputType.emailAddress,
                        ),
                        const CustomTextField(
                          labelText: 'Senha',
                          prefixIcon: Icons.lock,
                          isSecret: true,
                        ),
                        const CustomTextField(
                          labelText: 'Nome Completo',
                          prefixIcon: Icons.person,
                          textCapitalization: TextCapitalization.words,
                        ),
                        CustomTextField(
                          labelText: 'Celular',
                          prefixIcon: Icons.phone,
                          textInputFormatter: TelefoneInputFormatter(),
                          textInputType: TextInputType.number,
                        ),
                        CustomTextField(
                          labelText: 'CPF',
                          prefixIcon: Icons.person_pin,
                          textInputFormatter: CpfInputFormatter(),
                          textInputType: TextInputType.number,
                        ),
                        SizedBox(
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {},
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
