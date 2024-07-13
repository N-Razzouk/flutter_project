import 'package:bloc/bloc.dart';
import 'package:ed/features/beneficiary/domain/entities/beneficiary.dart';
import 'package:ed/features/beneficiary/domain/services/beneficiary_service.dart';
import 'package:meta/meta.dart';

part 'beneficiary_state.dart';

class BeneficiaryCubit extends Cubit<BeneficiaryState> {
  BeneficiaryCubit({
    required this.beneficiaryService,
  }) : super(BeneficiaryInitial());

  final BeneficiaryService beneficiaryService;

  Future<void> loadBeneficiaries() async {
    emit(BeneficiaryLoading());
    final beneficiaries = await beneficiaryService.getBeneficiaries();
    emit(BeneficiaryLoaded(
      beneficiaries: beneficiaries,
    ));
  }

  Future<void> addBeneficiary({
    required String name,
    required String phoneNumber,
  }) async {
    emit(BeneficiaryLoading());

    if (name.length > 20) {
      emit(
        BeneficiaryError(message: "Name should be less than 20 characters"),
      );
      return;
    }
    try {
      await beneficiaryService.addBeneficiary(
          beneficiary: Beneficiary(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name,
        phone: phoneNumber,
      ));
      loadBeneficiaries();
    } catch (e) {
      emit(BeneficiaryError(message: e.toString()));
    }
  }
}
