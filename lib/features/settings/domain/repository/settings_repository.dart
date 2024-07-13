abstract class UserSettingsRepository {
  /// Get user authorization status
  Future<bool> getAuthorizationStatus();

  /// Authorize user
  Future<void> authorizeUser();

  /// Deauthorize user
  Future<void> deauthorizeUser();

  /// Get user balance
  Future<double> getUserBalance();

  /// Deposit money to user balance
  Future<void> depositMoney(double amount);
}
