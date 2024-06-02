import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:greengrocer/src/config/helpers.dart';
import 'package:greengrocer/src/data/user.dart' as user_data;
import 'package:greengrocer/src/screens/common_widgets/custom_text_field.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
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
            initialValue: user_data.user.email,
            isReadOnly: true,
            prefixIcon: Icons.email,
            labelText: 'E-mail',
            textInputType: TextInputType.emailAddress,
            textCapitalization: TextCapitalization.none,
          ),
          CustomTextField(
            initialValue: user_data.user.name,
            isReadOnly: true,
            prefixIcon: Icons.person,
            labelText: 'Nome',
            textCapitalization: TextCapitalization.words,
          ),
          CustomTextField(
            initialValue: user_data.user.phone,
            isReadOnly: true,
            prefixIcon: Icons.phone,
            labelText: 'Celular',
            textInputType: TextInputType.number,
            textInputFormatter: TelefoneInputFormatter(),
          ),
          CustomTextField(
            initialValue: user_data.user.cpf,
            isSecret: true,
            isReadOnly: true,
            prefixIcon: Icons.person_pin,
            labelText: 'CPF',
            textInputType: TextInputType.number,
            textInputFormatter: CpfInputFormatter(),
          ),
          SizedBox(
            height: Helpers.heightButton,
            child: OutlinedButton(
              onPressed: () => updatePassword(),
              child: const Text('Atualizar Senha'),
            ),
          ),
        ],
      ),
    );
  }

  Future<bool?> updatePassword() => showDialog(
        context: context,
        builder: (c) => Dialog(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
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
                    const CustomTextField(
                      labelText: 'Senha Atual',
                      prefixIcon: Icons.lock,
                      isSecret: true,
                    ),
                    const CustomTextField(
                      labelText: 'Nova Senha',
                      prefixIcon: Icons.lock_outlined,
                      isSecret: true,
                    ),
                    const CustomTextField(
                      labelText: 'Confirmar Nova Senha',
                      prefixIcon: Icons.lock_outline,
                      isSecret: true,
                    ),
                    SizedBox(
                      height: Helpers.heightButton,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text('Atualizar'),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 5,
                right: 5,
                child: IconButton(
                  onPressed: () => Navigator.of(c).pop(),
                  icon: const Icon(
                    Icons.close,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
