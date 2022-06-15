import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wechat_redesign/data/models/data_model.dart';
import 'package:wechat_redesign/data/models/data_model_impl.dart';
import 'package:wechat_redesign/pages/main_page.dart';

import 'pages/start_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final DataModel _model = DataModelImpl();
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: _model.isLoggedIn() ? const MainPage() : const StartPage(),
    );
  }
}

/// fvm flutter packages run build_runner build --delete-conflicting-outputs
