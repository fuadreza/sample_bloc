import 'package:flutter/material.dart';
import 'package:sample_bloc/feature/main/presentation/modules/login/login_screen.dart';

import 'core/config/environment.dart';
import 'core/services/hive_service.dart';
import 'feature/main/injection/injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  environment.initConfig(Env.DEV);
  await hive.init();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(title: 'Flutter Demo Home Page'),
    );
  }
}
