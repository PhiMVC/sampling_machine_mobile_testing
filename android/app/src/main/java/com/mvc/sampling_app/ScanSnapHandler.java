package com.mvc.sampling_machine_mobile_testing;

import io.flutter.Log;
import io.flutter.plugin.common.EventChannel;

public class ScanSnapHandler implements EventChannel.StreamHandler {
    ScanSnapHandler(){}
    EventChannel.EventSink eventSink;

    @Override
    public void onListen(Object arguments, EventChannel.EventSink eventSinkParam) {
        eventSink = eventSinkParam;
        Log.d("Phi_Debugger","ScanSnapHandler is listening");
    }

    @Override
    public void onCancel(Object arguments) {
        eventSink = null;
    }

    public void sendDataToUI(byte[] data) {
        if(eventSink!=null){
            eventSink.success(data);
        }else{
            Log.d("Phi_Debugger","ScanSnapHandler eventSink null");
        }

    }

    public void sendMessageToUI(String message){
        if(eventSink!=null){
            eventSink.success(message);
        }else{
            Log.d("Phi_Debugger","ScanSnapHandler eventSink null");
        }
    }
}
