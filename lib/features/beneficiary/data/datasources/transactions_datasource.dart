import 'package:ed/features/beneficiary/domain/entities/transaction.dart';

abstract class TransactionsDatasource {
  Future<void> addTransaction({
    required Transaction transaction,
  });

  Future<Map<String, int>> getMonthlyTransactions();
}
