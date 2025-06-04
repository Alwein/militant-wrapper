part of 'locator.dart';

class BlocsLocator {
  static void register() {
    _registerAppBlocSingleton();
    _registerOnboardingWrapperBlocFactory();
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

  static void _registerOnboardingWrapperBlocFactory() {
    GetIt.I.registerFactory<OnboardingWrapperBloc>(
      () => OnboardingWrapperBloc(Locator.get<OnboardingRepository>()),
    );
  }
}
