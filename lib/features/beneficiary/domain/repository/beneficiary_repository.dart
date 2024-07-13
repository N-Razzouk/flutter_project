import 'package:ed/features/beneficiary/domain/entities/beneficiary.dart';

abstract class BeneficiaryRepository {
  Future<List<Beneficiary>> getBeneficiaries();

  Future<void> addBeneficiary({
    required Beneficiary beneficiary,
  });

  Future<void> removeBeneficiary({
    required Beneficiary beneficiary,
  });

  Future<void> rechargeToBeneficiary({
    required int amount,
    required String beneficiaryId,
  });
}
