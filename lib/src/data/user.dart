import 'package:brasil_fields/brasil_fields.dart';
import 'package:greengrocer/src/models/user.dart';

User user = User(
  id: 'qwert',
  name: 'Iraponan Marinho',
  email: 'contato@inovareti.eti.br',
  phone: '(84) 9 9617-1209',
  cpf: UtilBrasilFields.gerarCPF(useFormat: true),
  password: '',
);
