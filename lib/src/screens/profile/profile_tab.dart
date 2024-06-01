import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:greengrocer/src/config/helpers.dart';
import 'package:greengrocer/src/data/user.dart' as user_data;
import 'package:greengrocer/src/screens/common_widgets/custom_text_field.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

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
              onPressed: () {},
              child: const Text('Atualizar Senha'),
            ),
          ),
        ],
      ),
    );
  }
}
