import 'package:bloc/bloc.dart';
import 'package:ed/core/exceptions/exceptions.dart';
import 'package:ed/features/beneficiary/domain/entities/beneficiary.dart';
import 'package:ed/features/beneficiary/domain/entities/transaction.dart';
import 'package:ed/features/beneficiary/domain/services/beneficiary_service.dart';
import 'package:meta/meta.dart';

part 'top_up_state.dart';

class TopUpCubit extends Cubit<TopUpState> {
  TopUpCubit({
    required this.beneficiaryService,
  }) : super(TopUpInitial());

  final BeneficiaryService beneficiaryService;

  void reset() {
    emit(TopUpInitial());
  }

  Future<void> rechargeToBeneficiary({
    required int amount,
    required String beneficiaryId,
  }) async {
    emit(TopUpLoading());
    try {
      await beneficiaryService.rechargeToBeneficiary(
        amount: amount,
        beneficiaryId: beneficiaryId,
      );
      emit(TopUpLoaded(
        beneficiary: await beneficiaryService
            .getBeneficiaries()
            .then((List benefciaries) {
          return benefciaries.firstWhere(
            (beneficiary) => beneficiary.id == beneficiaryId,
          );
        }),
        transaction: Transaction(
          amount: amount.toInt(),
          month: DateTime.now().month,
          beneficiaryId: beneficiaryId,
        ),
      ));
    } on InsufficientBalanceException catch (e) {
      emit(
        TopUpError(
          error: e,
        ),
      );
    }
  }
}
