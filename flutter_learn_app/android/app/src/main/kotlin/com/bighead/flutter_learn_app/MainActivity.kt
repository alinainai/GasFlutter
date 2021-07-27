package com.bighead.flutter_learn_app

import android.os.Bundle
import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant


class MainActivity : FlutterActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
//        GeneratedPluginRegistrant.registerWith(flutterEngine!!)
//        MethodChannel(
//            flutterEngine!!.dartExecutor.binaryMessenger,
//            "samples.chenhang/navigation"
//        ).setMethodCallHandler { call, result -> // Note: this method is invoked on the main thread.
//            try {
//                if (call.method == "logNativeInfo") {
//                    Log.e("main", "android log info")
//                    result.success("Android 打印成功了")
//                } else {
//                    result.notImplemented()
//                }
//            } catch (e: Exception) {
//                result.error("UNAVAILABLE", "native logNativeInfo error", null)
//            }
//
//        }

    }

}
