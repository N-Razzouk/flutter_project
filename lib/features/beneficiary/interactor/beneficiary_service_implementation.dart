import 'package:ed/features/beneficiary/domain/entities/beneficiary.dart';
import 'package:ed/features/beneficiary/domain/repository/beneficiary_repository.dart';
import 'package:ed/features/beneficiary/domain/services/beneficiary_service.dart';

class BeneficiaryServiceImpl extends BeneficiaryService {
  final BeneficiaryRepository beneficiaryRepository;

  BeneficiaryServiceImpl({
    required this.beneficiaryRepository,
  });

  @override
  Future<void> addBeneficiary({required Beneficiary beneficiary}) async =>
      beneficiaryRepository.addBeneficiary(beneficiary: beneficiary);

  @override
  Future<void> rechargeToBeneficiary({
    required int amount,
    required String beneficiaryId,
  }) async =>
      beneficiaryRepository.rechargeToBeneficiary(
        amount: amount,
        beneficiaryId: beneficiaryId,
      );

  @override
  Future<void> removeBeneficiary({required Beneficiary beneficiary}) =>
      beneficiaryRepository.removeBeneficiary(beneficiary: beneficiary);

  @override
  Future<List<Beneficiary>> getBeneficiaries() =>
      beneficiaryRepository.getBeneficiaries();
}
