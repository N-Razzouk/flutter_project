part of 'account_cubit.dart';

@immutable
sealed class AccountState {}

final class AccountInitial extends AccountState {}

final class AccountLoading extends AccountState {}

final class AccountLoaded extends AccountState {
  final double balance;
  final bool isAuthorized;

  AccountLoaded({
    required this.balance,
    required this.isAuthorized,
  });
}

final class AccountError extends AccountState {
  final String message;

  AccountError({
    required this.message,
  });
}
