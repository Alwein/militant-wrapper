import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:militant_wrapper/presentation/app/app_bloc_wrapper.dart';
import 'package:militant_wrapper/presentation/app/bloc/app_bloc.dart';
import 'package:militant_wrapper/presentation/force_update/force_update_page.dart';
import 'package:militant_wrapper/presentation/home/home_page.dart';
import 'package:militant_wrapper/presentation/splash/splas_page.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return AppBlocProvidersWrapper(
      builder: (context) {
        return MaterialApp(
          title: 'Militant !',
          themeMode: ThemeMode.system,
          theme: ThemeData(
            brightness: Brightness.light,
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
          ),
          home: Builder(
            builder: (context) {
              return const _AppRouterWrapper(
                child: MyHomePage(),
              );
            },
          ),
        );
      },
    );
  }
}

class _AppRouterWrapper extends StatelessWidget {
  const _AppRouterWrapper({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const SplashPage();
        }

        if (state.shouldForceUpdate) {
          return const ForceUpdatePage();
        }

        return child;
      },
    );
  }
}
