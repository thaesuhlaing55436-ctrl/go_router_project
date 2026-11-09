import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router_project/presentation/blocs/authentication/authentication_cubit.dart';
import 'package:go_router_project/presentation/blocs/global/global_cubit.dart';
import 'package:go_router_project/presentation/navigation/router.dart';
import 'package:go_router_project/theme/app_theme.dart';


import 'core/di/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await configureDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: inject<AuthenticationCubit>(),
        ),

        BlocProvider.value(
          value: inject<GlobalCubit>(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        routerConfig: inject<NavigationRouter>().router,
      ),
    );
  }
}