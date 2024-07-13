import 'package:bloc/bloc.dart';
import 'package:ed/features/account/domain/services/account_service.dart';
import 'package:meta/meta.dart';

part 'account_state.dart';

class AccountCubit extends Cubit<AccountState> {
  AccountCubit({
    required this.accountService,
  }) : super(AccountInitial());

  final AccountService accountService;

  init() async {
    emit(AccountLoading());

    final balance = await accountService.getAccountBalance();

    final isAuthorized = await accountService.getAccountStatus();

    emit(
      AccountLoaded(
        balance: balance,
        isAuthorized: isAuthorized,
      ),
    );
  }
}
