import 'dart:convert';

import 'package:ed/core/utilities/shared_preferences_helper.mixin.dart';
import 'package:ed/core/utilities/shared_preferneces_keys.dart';
import 'package:ed/features/beneficiary/data/datasources/transactions_datasource.dart';
import 'package:ed/features/beneficiary/domain/entities/transaction.dart';

class TransactionsDatasourceImpl extends TransactionsDatasource
    with SharedPreferencesHelper {
  @override
  Future<void> addTransaction({required Transaction transaction}) async {
    final String savedEncodedTransactions =
        await getStringFromPrefs(SharedPrefernecesKeys.transactionHistory) ??
            "";

    if (savedEncodedTransactions.isEmpty) {
      final List transactions = [transaction.toJson()];
      final String encodedTransactions = jsonEncode(transactions);
      await saveStringToPrefs(
          SharedPrefernecesKeys.transactionHistory, encodedTransactions);
      await saveIntToPrefs(
        SharedPrefernecesKeys.monthlyTransactionAmount,
        transaction.amount,
      );
      return;
    } else {
      final List<Transaction> transactions = List<Transaction>.from(
          jsonDecode(savedEncodedTransactions)
              .map((e) => Transaction.fromJson(e))
              .toList());
      transactions.add(transaction);
      final int currentMonth = DateTime.now().month;
      final int totalMonthlyTransactionsAmount = transactions
          .where((transaction) => transaction.month == currentMonth)
          .map((e) => e.amount)
          .reduce((value, element) => value + element)
          .toInt();
      final String encodedTransactions =
          jsonEncode(transactions.map((e) => e.toJson()).toList());
      await saveStringToPrefs(
        SharedPrefernecesKeys.transactionHistory,
        encodedTransactions,
      );
      await saveIntToPrefs(SharedPrefernecesKeys.monthlyTransactionAmount,
          totalMonthlyTransactionsAmount);
      return;
    }
  }

  @override
  Future<Map<String, int>> getMonthlyTransactions() async {
    final String savedEncodedTransactions =
        await getStringFromPrefs(SharedPrefernecesKeys.transactionHistory) ??
            "";
    if (savedEncodedTransactions.isEmpty) {
      return {};
    } else {
      final List<Transaction> transactions = List<Transaction>.from(
          jsonDecode(savedEncodedTransactions)
              .map((e) => Transaction.fromJson(e))
              .toList());
      // jsonDecode(savedEncodedTransactions).map((Map<String, dynamic> e) {
      //   return Transaction.fromJson(e);
      // }).toList();

      final int currentMonth = DateTime.now().month;
      final Map<String, int> monthlyTransactions = {};
      transactions
          .where((transaction) => transaction.month == currentMonth)
          .forEach((transaction) {
        if (monthlyTransactions.containsKey(transaction.beneficiaryId)) {
          monthlyTransactions[transaction.beneficiaryId] =
              monthlyTransactions[transaction.beneficiaryId]! +
                  transaction.amount;
        } else {
          monthlyTransactions[transaction.beneficiaryId] = transaction.amount;
        }
      });
      return monthlyTransactions;
    }
  }
}
