// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../data/repos/feed_back_repo.dart' as _i258;
import '../../data/repos/feed_back_repo_imp.dart' as _i554;
import '../../presentation/cubits/feed_back_cubit.dart' as _i828;
import 'data_base_service.dart' as _i437;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i437.DataBaseService>(() => _i437.DataBaseService());
    gh.factory<_i258.FeedBackRepo>(
      () => _i554.FeedBackRepoImp(baseService: gh<_i437.DataBaseService>()),
    );
    gh.factory<_i828.FeedBackCubit>(
      () => _i828.FeedBackCubit(gh<_i258.FeedBackRepo>()),
    );
    return this;
  }
}
