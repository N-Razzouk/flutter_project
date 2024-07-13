import 'package:ed/core/utilities/shared_preferences_helper.mixin.dart';
import 'package:ed/core/utilities/shared_preferneces_keys.dart';
import 'package:ed/features/settings/domain/repository/settings_repository.dart';

class UserSettingsRepositoryImpl extends UserSettingsRepository
    with SharedPreferencesHelper {
  @override
  Future<void> deauthorizeUser() async =>
      await saveBoolToPrefs(SharedPrefernecesKeys.userAuthStatus, false);

  @override
  Future<void> depositMoney(double amount) async {
    final double oldBalance =
        await getDoubleFromPrefs(SharedPrefernecesKeys.userBalance) ?? 0;

    await saveDoubleToPrefs(
      SharedPrefernecesKeys.userBalance,
      oldBalance + amount,
    );
  }

  @override
  Future<bool> getAuthorizationStatus() async =>
      await getBoolFromPrefs(SharedPrefernecesKeys.userAuthStatus) ?? false;

  @override
  Future<double> getUserBalance() async =>
      await getDoubleFromPrefs(SharedPrefernecesKeys.userBalance) ?? 0;

  @override
  Future<void> authorizeUser() async => await saveBoolToPrefs(
        SharedPrefernecesKeys.userAuthStatus,
        true,
      );
}
