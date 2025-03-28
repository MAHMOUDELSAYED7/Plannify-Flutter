package com.example.plannify
import android.os.Bundle
import android.view.Gravity
import android.view.LayoutInflater
import android.widget.TextView
import android.widget.Toast
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val channelName = "toast_channel"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channelName).setMethodCallHandler { call, result ->
            when (call.method) {
                "showCustomToast" -> {
                    val message = call.argument<String>("message")
                    showCustomToast(message ?: "")
                    result.success(null)
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun showCustomToast(message: String) {
        runOnUiThread {
            val inflater = LayoutInflater.from(this)
            val layout = inflater.inflate(R.layout.custom_toast, null)

            val tvMessage = layout.findViewById<TextView>(R.id.tv_message)
            tvMessage.text = message

            val toast = Toast(this).apply {
                duration = Toast.LENGTH_LONG
                setGravity(Gravity.BOTTOM or Gravity.CENTER_HORIZONTAL, 0, 200)
                view = layout
            }
            toast.show()
        }
    }
}