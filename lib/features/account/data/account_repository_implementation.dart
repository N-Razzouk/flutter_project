import 'package:ed/core/utilities/shared_preferences_helper.mixin.dart';
import 'package:ed/core/utilities/shared_preferneces_keys.dart';
import 'package:ed/features/account/domain/repository/account_repository.dart';

final class AccountRepositoryImpl extends AccountRepository
    with SharedPreferencesHelper {
  @override
  Future<double> getAccountBalance() async =>
      await getDoubleFromPrefs(SharedPrefernecesKeys.userBalance) ?? 0;

  @override
  Future<bool> getAccountStatus() async =>
      await getBoolFromPrefs(SharedPrefernecesKeys.userAuthStatus) ?? false;
}
