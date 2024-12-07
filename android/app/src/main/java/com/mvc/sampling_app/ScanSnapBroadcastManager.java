package com.mvc.sampling_machine_mobile_testing;

//Standard Java Classes

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.Bundle;
import android.os.Environment;
import android.util.Log;

import androidx.localbroadcastmanager.content.LocalBroadcastManager;

//PFU ScanSnap SDK classes
import com.fujitsu.pfu.mobile.device.PFUDevice;
import com.fujitsu.pfu.mobile.device.PFUDeviceConnectStatus;
import com.fujitsu.pfu.mobile.device.PFUDeviceManager;
import com.fujitsu.pfu.mobile.device.PFUNotification;
import com.fujitsu.pfu.mobile.device.PFUSSDevice;
import com.fujitsu.pfu.mobile.device.PFUSSDeviceManager;
import com.fujitsu.pfu.mobile.device.SSDeviceScanSettings;
import com.fujitsu.pfu.mobile.device.SSDeviceScanStatus;
import com.fujitsu.pfu.mobile.device.SSDeviceScanningError;
import com.fujitsu.pfu.mobile.device.SSNotification;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Objects;

public class ScanSnapBroadcastManager {
    private final ScanSnapHandler scanSnapHandler ;
    private IntentFilter filter = new IntentFilter();
    private LocalBroadcastManager localBroadcastManager = null;
    private BroadcastReceiver broadcastReceiver = null;
    private PFUDeviceManager deviceManager;
    private PFUSSDevice device = null;
    private Context app_context = null;
    private ArrayList<PFUDevice> device_list;
    private SSDeviceScanSettings m_scanSetting = new SSDeviceScanSettings();

    class ScanSnapReceiver extends BroadcastReceiver {

        public void onReceive(Context context, Intent intent) {
            if(scanSnapHandler.eventSink!=null){

            if (Objects.equals(intent.getAction(), PFUNotification.ACTION_PFU_LIST_OF_DEVICES_DID_CHANGE)) {
                if(device == null){
                    tryConnectDevice();
                }else {
                    if(device.getConnectionStatus().getStatus() != PFUDeviceConnectStatus.DEVICE_STATUS_CONNECTED){
                        try {
                            device.connect();
                        }catch (Exception e){
                            tryConnectDevice();
                        }
                    }
                }
            }

            if (Objects.equals(intent.getAction(), SSNotification.ACTION_SS_DEVICE_DID_FINISH_SCAN)) {
                if (device != null && device.getConnectionStatus().getStatus() == PFUDeviceConnectStatus.DEVICE_STATUS_CONNECTED) {
                    device.endScanSession();
                }
            }

            if (Objects.equals(intent.getAction(), SSNotification.ACTION_SS_DEVICE_DID_ERROR_DURING_SCAN)) {
                    Bundle bundle = intent.getExtras();
                if(bundle!=null){
                    Object ssDeviceScanningError = bundle.get(SSNotification.EXTRA_DATA_SS_DEVICE_DID_ERROR_DURING_SCAN);
                    if(ssDeviceScanningError!=null && ssDeviceScanningError.getClass() == SSDeviceScanningError.class){
                        if(((SSDeviceScanningError) ssDeviceScanningError).getErrorCode() == SSDeviceScanningError.ERR_DOCUMENT_FEEDER_EMPTY){
                            return;
                        }else {
                            String errorMessage = getErrorMessageByErrorCode(((SSDeviceScanningError) ssDeviceScanningError).getErrorCode());
                            scanSnapHandler.sendMessageToUI(errorMessage);
                        }

                   }
                 }
                }

            if (Objects.equals(intent.getAction(), SSNotification.ACTION_SS_DEVICE_DID_FINISH_MAKE_PDF)) {
                String pdfPath = intent.getStringExtra(SSNotification.EXTRA_DATA_SS_DEVICE_DID_FINISH_MAKE_PDF);
                try {
                    if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.O) {
                        byte[] byteArray = Files.readAllBytes(Paths.get(pdfPath));
                        scanSnapHandler.sendDataToUI(byteArray);
                    }
                } catch (IOException e) {
                    throw new RuntimeException(e);
                }

            }

            if (Objects.equals(intent.getAction(), PFUNotification.ACTION_PFU_DEVICE_FAIL_TO_CONNECT)) {
                /// Comment for debug
                /// scanSnapHandler.sendMessageToUI("Kết nối tới máy Scan thất bại");
            }

            if (Objects.equals(intent.getAction(), PFUNotification.ACTION_PFU_DEVICE_DID_DISCONNECT)) {
                /// Comment for debug
                /// scanSnapHandler.sendMessageToUI("Kết nối tới máy Scan thành công");
            }
        }
    }
    }

    public ScanSnapBroadcastManager(Context context, ScanSnapHandler handler) {
        this.scanSnapHandler = handler;
        app_context = context;
       localBroadcastManager = LocalBroadcastManager.getInstance(app_context);
       filter.addAction(PFUNotification.ACTION_PFU_LIST_OF_DEVICES_DID_CHANGE);
       filter.addAction(PFUNotification.ACTION_PFU_DEVICE_DID_CONNECT);
       filter.addAction(PFUNotification.ACTION_PFU_DEVICE_DID_DISCONNECT);
       filter.addAction(PFUNotification.ACTION_PFU_DEVICE_FAIL_TO_CONNECT);
       filter.addAction(SSNotification.ACTION_SS_DEVICE_DID_FINISH_SCAN);
       filter.addAction(SSNotification.ACTION_SS_DEVICE_DID_SCAN_PAGE);
       filter.addAction(SSNotification.ACTION_SS_DEVICE_DID_FINISH_MAKE_PDF);
       filter.addAction(SSNotification.ACTION_SS_DEVICE_DID_ERROR_DURING_SCAN);
       initializeSetup();
       broadcastReceiver = new ScanSnapReceiver();
       localBroadcastManager.registerReceiver(broadcastReceiver, filter);
    }

    private void initializeSetup(){
        deviceManager = PFUDeviceManager.getDeviceManagerWithType(PFUSSDeviceManager.class, PFUSSDeviceManager.PFUDEVICETYPE_SCANSNAP, app_context);
        String path = Environment.getExternalStorageDirectory() + "/Pictures";
        setOutputPath(path);
        searchForDevices();

    }

    public void searchForDevices() {
        if(device == null || device.getConnectionStatus().getStatus()  != PFUDeviceConnectStatus.DEVICE_STATUS_CONNECTED){
            deviceManager.searchForDevices(PFUDeviceManager.PFUSCANSNAP_ALL);
            tryConnectDevice();
        }
    }

    public void tryConnectDevice(){
        device_list = (ArrayList<PFUDevice>) deviceManager.getDeviceList();
        if(device_list != null &&  !device_list.isEmpty()){
            device = (PFUSSDevice) device_list.get(0);
            device.connect();
            /// Comment for debug
            /// scanSnapHandler.sendMessageToUI("Kết nối với máy Scan thành công");
            /// Log.d("Phi_Debugger", "Device connected is: " + device.toString());
        }else{
            /// Comment for debug
            /// scanSnapHandler.sendMessageToUI("Kết nối với máy Scan thất bại");
        }
    }

    public void disconnectDevice() {
        if(device != null && device.getConnectionStatus().getStatus() != PFUDeviceConnectStatus.DEVICE_STATUS_DISCONNECTED) {
            device.disconnect();
        }
    }

    public void startScanSession() {
        searchForDevices();
        if(device !=null && device.getConnectionStatus().getStatus() == PFUDeviceConnectStatus.DEVICE_STATUS_CONNECTED){
            device.beginScanSession();
            device.scanDocuments(m_scanSetting);
            SSDeviceScanStatus status = device.getScanStatus();
            int statusCode = status.getStatus();
            if(statusCode == SSDeviceScanStatus.DEVICE_STATUS_PAUSED_FOR_ERROR){
                device.endScanSession();
                scanSnapHandler.sendMessageToUI("uncontinuable");
            }
        }
    }

    public boolean isConnected() {
        return device.getConnectionStatus().getStatus() == PFUDeviceConnectStatus.DEVICE_STATUS_CONNECTED;
    }

    String getErrorMessageByErrorCode(int code){
        switch (code)
        {
            case 1:
                return "ERR_PAPER_JAM";
            case 2:
                return "ERR_TOP_COVER_OPEN";
            case 3:
                return "ERR_DOCUMENT_FEEDER_EMPTY";
            case 4:
                return "ERR_INVALID_SAVE_FOLDER";
            case 5:
                return "ERR_NOT_ENOUGH_MEMORY";
            case 6:
                return "ERR_NO_DISK_SPACE";
            case 7:
                return "ERR_FILE_SIZE_LIMIT";
            case 8:
                return "ERR_BAD_NETWORK_CONNECTION";
            case 9:
                return "ERR_A3_CARRIER_SHEET_DETECTED";
            case 10:
                return "ERR_SAVE_IMAGE";
            case 11:
                return "ERR_MULTI_FEED";
            case 12:
                return "ERR_ALL_BLANK_PAPER";
            case 13:
                return "ERR_EMERGENCY_STOP";
            case 14:
                return "ERR_BATTERY_TEMPERATURE";
            case 15:
                return "ERR_PAPER_PROTECTION";
            case 16:
                return "ERR_PAPER_SET";
            case 17:
                return "ERR_LONG_PAGE_SCAN";
            case 18:
                return "ERR_DIRTY_SENSOR";
            case  256:
                return "ERR_UNEXPECTED_SW_ERROR";
            case 257:
                return "ERR_UNEXPECTED_HW_ERROR";
            default:
                return "ERR_UNEXPECTED";

        }
    }

    //////////////////////////
    //  SETTER METHODS      //
    //////////////////////////
    public  void setPassword(String password){
        device.setPassword(password);
    }
    public void setOutputPath(String path){
        m_scanSetting.setSaveFolderPath(path);
    }

    public void setFileFormat(int fileFormatOption) {
        m_scanSetting.setFileFormat(fileFormatOption);
    }
    public void setImageQuality(int imageQuality){
        m_scanSetting.setImageQuality(imageQuality);
    }
    public void setColorMode(int colorMode){
        m_scanSetting.setColorMode(colorMode);
    }
    public void setCompression(int compressionLevel){
        m_scanSetting.setCompression(compressionLevel);
    }
    public void setScanSide(int scanSide){
        m_scanSetting.setScanningSide(scanSide);
    }
    public void setPaperSize(int paperSize){
        m_scanSetting.setPaperSize(paperSize);
    }
    public void setBlankRemove(int blankRemove){
        m_scanSetting.setBlankRemove(blankRemove);
    }
    public void setMultiFeed(int multiFeed){
        m_scanSetting.setMultiFeed(multiFeed);
    }
    public void setBleedThrough(int bleedThrough){
        m_scanSetting.setBleedThrough(bleedThrough);
    }
    public void setEDocMode(int eDocMode){
        m_scanSetting.setEDocMode(eDocMode);
    }
    public void setFeedMode(int feedMode){
        m_scanSetting.setFeedMode(feedMode);
    }
    public void setPaperProtection(int paperProtection){
        m_scanSetting.setPaperProtection(paperProtection);
    }
    public void setBrightness(int brightness){
        m_scanSetting.setBrightness(brightness);
    }


    //////////////////////////
    //  GETTER METHODS      //
    //////////////////////////

    public  String getPassword(){
        return device.getPassword();
    }
    public String getOutputPath(){
      return   m_scanSetting.getSaveFolderPath();
    }
    public int getFileFormat() {
       return m_scanSetting.getFileFormat();
    }
    public int getImageQuality(){
        return m_scanSetting.getImageQuality();
    }
    public int getColorMode(){
        return m_scanSetting.getColorMode();
    }
    public int getCompression(){
       return m_scanSetting.getCompression();
    }
    public int getScanSide(){
        return m_scanSetting.getScanningSide();
    }
    public int getPaperSize(){
       return m_scanSetting.getPaperSize();
    }
    public int getBlankRemove(){
        return m_scanSetting.getBlankRemove();
    }
    public int getMultiFeed(){
        return  m_scanSetting.getMultiFeed();
    }
    public int getBleedThrough(){
        return  m_scanSetting.getBleedThrough();
    }
    public int getEDocMode(){
        return  m_scanSetting.getEDocMode();
    }
    public int getFeedMode(){
        return m_scanSetting.getFeedMode();
    }
    public int getPaperProtection(){
        return  m_scanSetting.getPaperProtection();
    }
    public int getBrightness(){
        return m_scanSetting.getBrightness();
    }
}