package ao.marco_domingos.scanner_api_example

import android.content.Context
import com.google.android.gms.tasks.Task
import com.google.mlkit.vision.codescanner.GmsBarcodeScanning
import kotlinx.coroutines.suspendCancellableCoroutine
import kotlin.coroutines.resume
import kotlin.coroutines.resumeWithException
import kotlin.coroutines.suspendCoroutine

class Scanner {
    suspend fun <T> Task<T>.await(): T {
        return suspendCancellableCoroutine { continuation ->
            addOnSuccessListener { result ->
                continuation.resume(result)
            }

            addOnFailureListener { exception ->
                continuation.resumeWithException(exception)
            }
        }
    }
}