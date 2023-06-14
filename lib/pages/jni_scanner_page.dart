import 'package:flutter/material.dart';
import 'package:jni/jni.dart';
import 'package:scanner_api_example/scanner.dart';

class JniScannerPage extends StatefulWidget {
  const JniScannerPage({super.key, required this.title});

  final String title;

  @override
  State<JniScannerPage> createState() => _JniScannerPageState();
}

class _JniScannerPageState extends State<JniScannerPage> {
  String result = "";

  void _getScanner() async {
    String? scanned;
    try {
      final scanner = await Scanner().getCode(JObject.fromRef(Jni.getCachedApplicationContext()));
      scanned = scanner.toDartString();
    } catch (e) {
      scanned = "";
    }

    setState(() {
      result = scanned ?? "";
    });
  }

  void _getScanner2() async {
    String? scanned;
    try {
      final scanner = GmsBarcodeScanning.getClient(JObject.fromRef(Jni.getCachedApplicationContext()));
      final result = await Scanner().await0(scanner.startScan());
      scanned = result.getRawValue().toDartString();
    } catch (e) {
      scanned = "";
    }

    setState(() {
      result = scanned ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "JNIResult: ",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              result,
              style: const TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _getScanner2();
        },
        tooltip: 'Scan',
        child: const Icon(Icons.qr_code_scanner),
      ),
    );
  }
}
