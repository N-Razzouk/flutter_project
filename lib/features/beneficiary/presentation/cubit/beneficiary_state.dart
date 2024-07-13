part of 'beneficiary_cubit.dart';

@immutable
sealed class BeneficiaryState {}

final class BeneficiaryInitial extends BeneficiaryState {}

final class BeneficiaryLoading extends BeneficiaryState {}

final class BeneficiaryLoaded extends BeneficiaryState {
  final List<Beneficiary> beneficiaries;

  BeneficiaryLoaded({
    required this.beneficiaries,
  });
}

final class BeneficiaryError extends BeneficiaryState {
  final String message;

  BeneficiaryError({
    required this.message,
  });
}
