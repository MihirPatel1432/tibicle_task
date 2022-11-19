import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference extends SharedPreferenceRepository {
  SharedPreferences? _pref;

  @override
  Future<bool?> clearData() async {
    return _pref?.clear();
  }

  initPreference() async {
    _pref = await SharedPreferences.getInstance();
  }
}

abstract class SharedPreferenceRepository {
  Future<bool?> clearData();
}
