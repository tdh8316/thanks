package com.donghyeoktak.thanks

import android.os.Bundle
import android.widget.Toast
import com.skydoves.needs.Needs
import com.skydoves.needs.NeedsAnimation
import com.skydoves.needs.NeedsItem
import com.skydoves.needs.OnConfirmListener
import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity() {

    private val needs = Needs.Builder(this)
            .setTitle("Permission instructions for using thanks for Android")
            .addNeedsItem(NeedsItem(null, "· SD Card", "(Required)", "Save your diaries to your device."))
            .setDescription("")
            .setConfirm("Confirm")
            .setBackgroundAlpha(.6f)
            .setNeedsAnimation(NeedsAnimation.ELASTIC)
            .build()
    private val channel = "thanks"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)

        needs.setOnConfirmListener(object : OnConfirmListener {
            override fun onConfirm() {
                Toast.makeText(baseContext, "Confirmed!", Toast.LENGTH_SHORT).show()
                needs.dismiss()
            }
        })

        MethodChannel(flutterView, channel).setMethodCallHandler { methodCall, result ->
            when (methodCall?.toString()) {
                "RequestAndroidPermissions" -> {
                    requestAndroidPermissions()
                    result.success(null)
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun requestAndroidPermissions() {
        needs.show(view = flutterView)
    }

    override fun onBackPressed() {
        if (needs.isShowing) {
            needs.dismiss()
        } else {
            super.onBackPressed()
        }
    }
}
