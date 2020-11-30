import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/services.dart';

const _inactivityTimeout = Duration(hours: 1);
Timer _keepAliveTimer;
Function function;
bool once;

void _keepAlive(
  bool visible,
) {
  _keepAliveTimer?.cancel();
  if (visible) {
    once = true;
    _keepAliveTimer = null;
  } else if (once == true) {
    _keepAliveTimer = Timer(
        _inactivityTimeout,
        function != null
            ? () {
                function?.call();
                once = false;
              }
            : () => (Platform.isIOS) ? exit(0) : SystemNavigator.pop());
  }
}

class _KeepAliveObserver extends WidgetsBindingObserver {
  @override
  didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        _keepAlive(true);
        break;
      case AppLifecycleState.inactive:
        _keepAlive(true);
        break;
      case AppLifecycleState.paused:
        _keepAlive(false);
        break;
      case AppLifecycleState.detached:
        _keepAlive(true); // Conservatively set a timer on all three
        break;
    }
  }
}

/// Must be called only when app is visible, and exactly once
void startKeepAlive([Function onTimerEnd]) {
  if (_keepAliveTimer == null) {
    function = onTimerEnd;
    _keepAlive(true);
    WidgetsBinding.instance.addObserver(_KeepAliveObserver());
  }
}
