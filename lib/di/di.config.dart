// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../data/data_sources/firebase_remote_data_source.dart' as _i1005;
import '../data/data_sources/firebase_remote_data_source_impl.dart' as _i425;
import '../data/repositories/Firebase_repository_impl.dart' as _i987;
import '../domain/repositories/firebase_repository.dart' as _i974;
import '../domain/use_cases/add_user_use_case.dart' as _i62;
import '../presentation/manager/providers/register_view_model.dart' as _i933;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i1005.FirebaseRemoteDataSource>(
        () => _i425.FirebaseRemoteDataSourceImpl());
    gh.factory<_i974.FirebaseRepository>(() => _i987.FirebaseRepositoryImpl(
        firebaseRemoteDataSource: gh<_i1005.FirebaseRemoteDataSource>()));
    gh.factory<_i62.AddUserUseCase>(() => _i62.AddUserUseCase(
        firebaseRepository: gh<_i974.FirebaseRepository>()));
    gh.factory<_i933.RegisterViewModel>(() =>
        _i933.RegisterViewModel(addUserUseCase: gh<_i62.AddUserUseCase>()));
    return this;
  }
}
