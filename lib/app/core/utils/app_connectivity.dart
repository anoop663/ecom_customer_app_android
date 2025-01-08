import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:soulstyle/app/core/values/api_configs.dart';

//Still not used it as it will add in the last
class AppConnectivity {
  AppConnectivity._();

  static final _instance = AppConnectivity._();
  static AppConnectivity get instance => _instance;
  final _connectivity = Connectivity();
  final _controller = StreamController.broadcast();
  Stream get myStream => _controller.stream;

  void initialise() async {
    List<ConnectivityResult> result = await _connectivity.checkConnectivity();
    _checkStatus(result);
    _connectivity.onConnectivityChanged.listen((result) {
      _checkStatus(result);
    });
  }

  void _checkStatus(List<ConnectivityResult> result) async {
    bool isOnline = false;
    try {
      final result = await InternetAddress.lookup(ApiConfig.apiUrl);
      isOnline = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      isOnline = false;
    }
    _controller.sink.add({result: isOnline});
  }

  void disposeStream() => _controller.close();
}
