import 'package:ed/features/account/domain/repository/account_repository.dart';
import 'package:ed/features/account/domain/services/account_service.dart';

final class AccountServiceImpl extends AccountService {
  final AccountRepository accountRepository;

  AccountServiceImpl({
    required this.accountRepository,
  });

  @override
  Future<double> getAccountBalance() async =>
      await accountRepository.getAccountBalance();

  @override
  Future<bool> getAccountStatus() async =>
      await accountRepository.getAccountStatus();
}
