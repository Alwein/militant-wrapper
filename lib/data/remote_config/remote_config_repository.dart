import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:militant_wrapper/data/crashlytics/crashlytics_repository.dart';
import 'package:militant_wrapper/domain/remote_config/remote_config.dart';

class RemoteConfigRepository {
  RemoteConfigRepository({
    FirebaseRemoteConfig? remoteConfig,
    required CrashlyticsRepository crashlyticsRepository,
  })  : _remoteConfig = remoteConfig ?? FirebaseRemoteConfig.instance,
        _crashlyticsRepository = crashlyticsRepository;
  final FirebaseRemoteConfig _remoteConfig;
  final CrashlyticsRepository _crashlyticsRepository;

  AppRemoteConfig? _appRemoteConfig;

  Future<AppRemoteConfig?> getRemoteConfig() async {
    if (_appRemoteConfig == null) {
      try {
        await _remoteConfig.setConfigSettings(
          RemoteConfigSettings(
            fetchTimeout: const Duration(seconds: 5),
            minimumFetchInterval: const Duration(minutes: 5),
          ),
        );

        await _remoteConfig.fetchAndActivate();

        final minAppVersionKey = switch (defaultTargetPlatform) {
          TargetPlatform.iOS => "min_app_version_ios",
          TargetPlatform.android => "min_app_version_android",
          _ => "",
        };

        final minAppVersion = _remoteConfig.getString(minAppVersionKey);

        final remoteUrl = _remoteConfig.getString("remote_url");

        _appRemoteConfig = AppRemoteConfig(
          minAppVersion: minAppVersion,
          remoteUrl: remoteUrl,
        );

        return _appRemoteConfig;
      } catch (error, stackTrace) {
        _crashlyticsRepository.recordError(error, stackTrace, reason: "getRemoteConfig");
        return _appRemoteConfig;
      }
    }
    return _appRemoteConfig;
  }
}
