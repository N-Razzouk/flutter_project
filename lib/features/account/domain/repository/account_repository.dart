abstract class AccountRepository {
  Future<bool> getAccountStatus();

  Future<double> getAccountBalance();
}
