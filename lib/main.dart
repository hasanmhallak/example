import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'model_viewer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const CupertinoApp(
    locale: Locale('ar'),
    localizationsDelegates: [DefaultMaterialLocalizations.delegate],
    home: MyHomePage(),
  ));
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: ModelViewer(),
        ),
      ),
    );
  }
}
