part of 'locator.dart';

class BlocsLocator {
  static void register() {
    _registerAppBlocSingleton();
  }

  static void _registerAppBlocSingleton() {
    GetIt.I.registerLazySingleton<AppBloc>(
      () => AppBloc(
        remoteConfigRepository: Locator.get<RemoteConfigRepository>(),
        configurationRepository: Locator.get<ConfigurationRepository>(),
        appOpenCountRepository: Locator.get<AppOpenCountRepository>(),
      ),
    );
  }
}
