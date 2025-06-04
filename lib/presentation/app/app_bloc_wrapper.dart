import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:militant_wrapper/core/dependency_injection/locator.dart';
import 'package:militant_wrapper/presentation/app/bloc/app_bloc.dart';

class AppBlocProvidersWrapper extends StatelessWidget {
  const AppBlocProvidersWrapper({super.key, required this.builder});
  final Widget Function(BuildContext context) builder;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: Locator.get<AppBloc>()..add(const AppEvent.initialize()),
        ),
      ],
      child: builder(context),
    );
  }
}
