import 'package:get_it/get_it.dart';
import 'package:militant_wrapper/data/app_open_count/app_open_count_repository.dart';
import 'package:militant_wrapper/data/crashlytics/crashlytics_repository.dart';
import 'package:militant_wrapper/data/device/configuration_repository.dart';
import 'package:militant_wrapper/data/onboarding/onboarding_repository.dart';
import 'package:militant_wrapper/data/remote_config/remote_config_repository.dart';
import 'package:militant_wrapper/presentation/app/bloc/app_bloc.dart';
import 'package:militant_wrapper/presentation/onboarding/wrapper/bloc/onboarding_wrapper_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'blocs_locator.dart';
part 'repositories_locator.dart';

class Locator {
  static final Locator _instance = Locator._internal();

  factory Locator() {
    return _instance;
  }

  Locator._internal();

  static T get<T extends Object>() => GetIt.I.get<T>();

  static void initialize(SharedPreferences sharedPreferences) {
    RepositoriesLocator.register(sharedPreferences);
    BlocsLocator.register();
  }
}
