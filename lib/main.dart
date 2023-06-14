import 'package:flutter/material.dart';
import 'package:jni/jni.dart';
import 'package:scanner_api_example/pages/jni_scanner_page.dart';
import 'package:scanner_api_example/pages/mc_scanner_page.dart';

void main() {
  Jni.initDLApi();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const JniScannerPage(title: 'Flutter Demo Home Page'),
    );
  }
}
