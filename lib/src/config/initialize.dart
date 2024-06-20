import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

mixin AppInitialize {
  static Future<void> initializeEnv() async {
    await dotenv.load(fileName: 'lib/src/config/.env');
  }

  static Future<void> initializeParseServer() async {
    await Parse().initialize(
      dotenv.env['APPLICATION_ID'] ?? '',
      dotenv.env['SERVER_URL'] ?? '',
      appName: dotenv.env['APP_NAME'] ?? '',
      masterKey: dotenv.env['MASTER_KEY'] ?? '',
      clientKey: dotenv.env['CLIENT_KEY'] ?? '',
      autoSendSessionId: true,
      debug: true,
    );
    await Parse().healthCheck(debug: true);
  }
}
