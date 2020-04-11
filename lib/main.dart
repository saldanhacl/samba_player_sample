import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(SambaSample());

class SambaSample extends StatelessWidget {
  static const platform = const MethodChannel('samba.flutter.channel/player');

  Future<void> _openSambaPlayer() async {
    try {
      final int result = await platform.invokeMethod('openPlayer');
      print(result);
    } on PlatformException catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FlatButton(
                  child: Text('Play'),
                  onPressed: _openSambaPlayer,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
