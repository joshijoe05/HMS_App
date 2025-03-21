import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class NetworkProvider extends ChangeNotifier {
  bool isOnline = false;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription connectivityStreamController;
  NetworkProvider() {
    connectivityStreamController = _connectivity.onConnectivityChanged.listen(
      (List<ConnectivityResult> result) {
        isOnline = !result.contains(ConnectivityResult.none);
        notifyListeners();
      },
    );
  }
}
