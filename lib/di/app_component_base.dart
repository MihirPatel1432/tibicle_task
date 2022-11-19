import 'dart:async';

import 'package:flutterprojectsetup/di/network_manager.dart';
import 'package:flutterprojectsetup/di/shared_preference.dart';

class AppComponentBase extends AppComponentBaseRepository {
  static AppComponentBase? _instance;
  final NetworkManager _networkManager = NetworkManager();
  final StreamController<bool> _progressDialogStreamController = StreamController.broadcast();
  final SharedPreference _sharedPreference = SharedPreference();
  Stream<bool?> get progressDialogStream => _progressDialogStreamController.stream;


  static AppComponentBase? getInstance() {
    _instance ??= AppComponentBase();
    return _instance;
  }

  init() async {
    await _networkManager.initialiseNetworkManager();
    await _sharedPreference.initPreference();
  }

  shoProgressDialog(bool value){
    _progressDialogStreamController.sink.add(value);
  }


  dispose(){
    _progressDialogStreamController.close();
    _networkManager.disposeStream();
  }

  @override
  SharedPreference getSharedPreference() {
    return _sharedPreference;
  }

  @override
  NetworkManager getNetworkManager() {
    return _networkManager;
  }

}

abstract class AppComponentBaseRepository {

  SharedPreference getSharedPreference();

  NetworkManager getNetworkManager();
}
