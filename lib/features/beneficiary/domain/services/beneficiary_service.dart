import 'package:ed/features/beneficiary/domain/entities/beneficiary.dart';

abstract class BeneficiaryService {
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
