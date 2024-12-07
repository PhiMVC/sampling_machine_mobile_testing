package com.mvc.sampling_machine_mobile_testing;

import android.content.Context;

import io.flutter.Log;
import io.flutter.plugin.common.EventChannel;

public class RS232Handler implements EventChannel.StreamHandler{
    public RS232Handler(Runnable startRS232Thread, Runnable stopRS232Thread){
      start = startRS232Thread;
      stop = stopRS232Thread;
    }
    Runnable start, stop;
    EventChannel.EventSink eventSink;

    @Override
    public void onListen(Object o, EventChannel.EventSink eventSinkParam) {
        eventSink = eventSinkParam;
        start.run();
        Log.d("Phi_Debugger","RS232Handler is listening");
    }

    @Override
    public void onCancel(Object o) {
        eventSink = null;
        stop.run();
    }

    public void sendDataToUI(String data) {
        if(eventSink!=null){
            eventSink.success(data);
        }else{
            Log.d("Phi_Debugger","RS232Handler eventSink null");
        }

    }
}
