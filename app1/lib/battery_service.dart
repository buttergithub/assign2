import 'dart:async';
import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BatteryService {
  final Battery _battery = Battery();
  late StreamSubscription<BatteryState> _batteryStateSubscription;
  int _batteryLevel = 0;
  bool _isCharging = false;

  void initialize(BuildContext context) {
    _batteryStateSubscription = _battery.onBatteryStateChanged.listen((BatteryState state) {
      _isCharging = state == BatteryState.charging;
      _checkBatteryLevel();
    });

    // Check battery level every minute
    Timer.periodic(Duration(minutes: 1), (_) => _checkBatteryLevel());
  }

  Future<void> _checkBatteryLevel() async {
    final int batteryLevel = await _battery.batteryLevel;
    if (batteryLevel != _batteryLevel) {
      _batteryLevel = batteryLevel;
      if (_isCharging && _batteryLevel >= 90) {
        Fluttertoast.showToast(
          msg: 'Battery level reached 90%',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0
        );
        // You can add code here to play a ringtone
      }
    }
  }

  void dispose() {
    _batteryStateSubscription.cancel();
  }
}