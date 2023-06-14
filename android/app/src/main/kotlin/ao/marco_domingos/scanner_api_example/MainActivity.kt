package ao.marco_domingos.scanner_api_example

import androidx.annotation.NonNull
import com.google.mlkit.vision.codescanner.GmsBarcodeScanning
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {

    private val CHANNEL = "com.example.com/Scanner"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->
            if (call.method == "getBarCode") {
                val scanner = GmsBarcodeScanning.getClient(this)
                object : Thread() {
                    override fun run() {
                        scanner.startScan()
                            .addOnSuccessListener { barcode ->
                                result.success(barcode.rawValue)
                            }
                            .addOnCanceledListener { ->
                                result.success("")
                            }
                            .addOnFailureListener { e ->
                                result.error("Exception", "Found Exception", e)
                            };
                    }
                }.start()
            }
        }
    }
}
