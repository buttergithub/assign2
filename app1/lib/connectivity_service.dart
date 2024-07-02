import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ConnectivityService {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  void initialize(BuildContext context) {
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      String message;
      if (result == ConnectivityResult.mobile) {
        message = 'Connected to mobile network';
      } else if (result == ConnectivityResult.wifi) {
        message = 'Connected to WiFi';
      } else {
        message = 'No internet connection';
      }
      
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0
      );
    });
  }

  void dispose() {
    _connectivitySubscription.cancel();
  }
}