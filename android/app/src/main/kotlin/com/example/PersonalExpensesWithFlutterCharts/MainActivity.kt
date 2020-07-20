//package com.example.PersonalExpensesWithFlutterCharts
//
//import io.flutter.embedding.android.FlutterActivity
//import android.view.WindowManager;
//import android.view.WindowManager.LayoutParams;
//import android.os.Bundle;
//import java.io.InputStreamReader
//
//import java.io.BufferedReader
//
//import java.io.File
//
//import androidx.annotation.NonNull
//import io.flutter.embedding.engine.FlutterEngine
//import io.flutter.plugin.common.MethodChannel
//
//
//
//
//class MainActivity: FlutterActivity() {
////    val isDeviceRooted: Boolean
////        get() = checkRootMethod1() || checkRootMethod2() || checkRootMethod3()
//    private val CHANNEL = "samples.flutter.dev/rootstatus";
//    override fun onCreate(savedInstanceState: Bundle?) {
//        super.onCreate(savedInstanceState)
//        getWindow().setFlags(WindowManager.LayoutParams.FLAG_SECURE, WindowManager.LayoutParams.FLAG_SECURE)
//        MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler {
//            // Note: this method is invoked on the main thread.
//            call, result ->
//            if (call.method == "getRootStatus") {
//                val rootStatus = getRootStatus()
//                if(rootStatus){
//                    result.success("Device is rooted")
//                }else{
//                    result.success("Device is NOT rooted")
//                }
//            } else {
//                result.notImplemented()
//            }
//        }
//    }
//
//    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
//        super.configureFlutterEngine(flutterEngine)
//
//    }
//    private fun getRootStatus(): Boolean {
//        return (checkRootMethod1() || checkRootMethod2() || checkRootMethod3())
//    }
//
//    private fun checkRootMethod1(): Boolean {
//        val buildTags: String = android.os.Build.TAGS
//        return buildTags != null && buildTags.contains("test-keys")
//    }
//
//    private fun checkRootMethod2(): Boolean {
//        val paths = arrayOf("/system/app/Superuser.apk", "/sbin/su", "/system/bin/su", "/system/xbin/su", "/data/local/xbin/su", "/data/local/bin/su", "/system/sd/xbin/su",
//                "/system/bin/failsafe/su", "/data/local/su", "/su/bin/su")
//        for (path in paths) {
//            if (File(path).exists()) return true
//        }
//        return false
//    }
//
//    private fun checkRootMethod3(): Boolean {
//        var process: java.lang.Process? = null
//        return try {
//            process = java.lang.Runtime.getRuntime().exec(arrayOf("/system/xbin/which", "su"))
//            val `in` = BufferedReader(InputStreamReader(process.getInputStream()))
//            if (`in`.readLine() != null) true else false
//        } catch (t: Throwable) {
//            false
//        } finally {
//            if (process != null) process.destroy()
//        }
//    }
//
//
//
//}
