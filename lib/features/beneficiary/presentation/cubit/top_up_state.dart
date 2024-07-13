part of 'top_up_cubit.dart';

@immutable
sealed class TopUpState {}

final class TopUpInitial extends TopUpState {}

final class TopUpLoading extends TopUpState {}

final class TopUpLoaded extends TopUpState {
  final Beneficiary beneficiary;
  final Transaction transaction;

  TopUpLoaded({
    required this.beneficiary,
    required this.transaction,
  });
}

final class TopUpError extends TopUpState {
  final AppException error;

  TopUpError({
    required this.error,
  });
}
