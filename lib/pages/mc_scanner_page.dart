import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MCScannerPage extends StatefulWidget {
  const MCScannerPage({super.key, required this.title});

  final String title;

  @override
  State<MCScannerPage> createState() => _MCScannerPageState();
}

class _MCScannerPageState extends State<MCScannerPage> {
  static const platform = MethodChannel('com.example.com/Scanner');
  String result = "";

  void _getScanner() async {
    String? scanned;
    try {
      scanned = await platform.invokeMethod('getBarCode');
    } on PlatformException catch (e) {
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
              "ScanResult: ",
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
          _getScanner();
        },
        tooltip: 'Scan',
        child: const Icon(Icons.qr_code_scanner),
      ),
    );
  }
}
