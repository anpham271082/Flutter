import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class PlatformChannel extends StatefulWidget {
  const PlatformChannel({super.key});
  @override
  State<PlatformChannel> createState() => _PlatformChannelState();
}
class _PlatformChannelState extends State<PlatformChannel> {
  static const platform = MethodChannel('samples.flutter.dev/battery');
  String _batteryLevel = 'Unknown battery level.';
  Future<void> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final result = await platform.invokeMethod<int>('getBatteryLevel');
      batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }
    setState(() {
      _batteryLevel = batteryLevel;
    });
  }
  @override
  void initState() {
    super.initState();
  }
  @override
  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Platform Channel'),
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: _getBatteryLevel,
            child: const Text('Get Battery Level'),
          ),
          Text(_batteryLevel),
        ],
      ),
    ),
  );
}
}