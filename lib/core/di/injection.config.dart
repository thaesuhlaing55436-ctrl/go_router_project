// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:get_it/get_it.dart' as _i174;
import 'package:go_router_project/core/di/injection.dart' as _i924;
import 'package:go_router_project/data/repositories/auth_repository.dart'
    as _i32;
import 'package:go_router_project/data/services/auth_service.dart' as _i207;
import 'package:go_router_project/data/services/storage_service.dart' as _i645;
import 'package:go_router_project/presentation/blocs/authentication/authentication_cubit.dart'
    as _i940;
import 'package:go_router_project/presentation/blocs/global/global_cubit.dart'
    as _i706;
import 'package:go_router_project/presentation/navigation/router.dart' as _i906;
import 'package:go_router_project/presentation/pages/login/login_cubit/login_cubit.dart'
    as _i890;
import 'package:go_router_project/presentation/pages/register/register_cubit/register_cubit.dart'
    as _i1036;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => registerModule.sharedPreferences,
      preResolve: true,
    );
    gh.singleton<_i706.GlobalCubit>(() => _i706.GlobalCubit());
    gh.lazySingleton<_i59.FirebaseAuth>(() => registerModule.firebaseAuth);
    gh.lazySingleton<_i906.NavigationRouter>(() => _i906.NavigationRouter());
    gh.lazySingleton<_i645.StorageService>(
      () => _i645.StorageService(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i207.AuthService>(
      () => _i207.AuthService(gh<_i59.FirebaseAuth>()),
    );
    gh.lazySingleton<_i32.AuthRepository>(
      () => _i32.AuthRepository(
        gh<_i207.AuthService>(),
        gh<_i645.StorageService>(),
      ),
    );
    gh.singleton<_i940.AuthenticationCubit>(
      () => _i940.AuthenticationCubit(gh<_i32.AuthRepository>()),
    );
    gh.factory<_i890.LoginCubit>(
      () => _i890.LoginCubit(
        gh<_i32.AuthRepository>(),
        gh<_i940.AuthenticationCubit>(),
      ),
    );
    gh.factory<_i1036.RegisterCubit>(
      () => _i1036.RegisterCubit(
        gh<_i32.AuthRepository>(),
        gh<_i940.AuthenticationCubit>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i924.RegisterModule {}
