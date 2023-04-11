import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:nado_client_mvp/app/data/provider/storage_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app/app.dart';

Future<void> _initService() async {
  final prefs = await SharedPreferences.getInstance();
  if (prefs.getBool('is_first_run') ?? true) {
    Storage storage = Storage();
    await storage.deleteAll();
    prefs.setBool('is_first_run', false);
  }
}

void main() async {
  await dotenv.load(fileName: 'assets/.local.env');
  WidgetsFlutterBinding.ensureInitialized();
  await _initService();
  runApp(MyApp());
}
