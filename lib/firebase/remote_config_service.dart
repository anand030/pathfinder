import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';

const String _appUpdate = 'appUpdate';

class RemoteConfigService {
  final FirebaseRemoteConfig _firebaseRemoteConfig;

  RemoteConfigService({required FirebaseRemoteConfig firebaseRemoteConfig})
      : _firebaseRemoteConfig = firebaseRemoteConfig;

  static late RemoteConfigService _instance;

  static Future<RemoteConfigService> getInstance() async {
    _instance = RemoteConfigService(
        firebaseRemoteConfig: FirebaseRemoteConfig.instance);
    return _instance;
  }

  String get appUpdate => _firebaseRemoteConfig.getString(_appUpdate);

  Future initialize() async {
    try {
      await _fetchAndActivate();
    } catch (e) {
      debugPrint('Unable to fetch remote config value');
    }
  }

  Future _fetchAndActivate() async {
    await _firebaseRemoteConfig.fetchAndActivate();
    debugPrint('value,${jsonDecode(appUpdate)}');
  }
}
