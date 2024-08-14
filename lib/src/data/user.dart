import 'package:brasil_fields/brasil_fields.dart';
import 'package:greengrocer/src/models/user.dart';

User user = User(
  id: 'qwert',
  token: '123456',
  name: 'Iraponan Marinho',
  email: 'contato@inovareti.eti.br',
  phone: '(84) 9 9617-1209',
  cpfCnpj: UtilBrasilFields.gerarCPF(useFormat: true),
  password: '',
);
