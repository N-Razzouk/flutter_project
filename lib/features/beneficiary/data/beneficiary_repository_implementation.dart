import 'dart:convert';

import 'package:ed/core/exceptions/exceptions.dart';
import 'package:ed/core/utilities/shared_preferences_helper.mixin.dart';
import 'package:ed/core/utilities/shared_preferneces_keys.dart';
import 'package:ed/features/beneficiary/data/datasources/transactions_datasource.dart';
import 'package:ed/features/beneficiary/domain/entities/beneficiary.dart';
import 'package:ed/features/beneficiary/domain/entities/transaction.dart';
import 'package:ed/features/beneficiary/domain/repository/beneficiary_repository.dart';

class BeneficiaryRepositoryImpl extends BeneficiaryRepository
    with SharedPreferencesHelper {
  final TransactionsDatasource transactionsDatasource;

  BeneficiaryRepositoryImpl({
    required this.transactionsDatasource,
  });

  @override
  Future<void> addBeneficiary({
    required Beneficiary beneficiary,
  }) async {
    final String savedEncodedBeneficiaries =
        await getStringFromPrefs(SharedPrefernecesKeys.beneficiaryList) ?? "";

    if (savedEncodedBeneficiaries.isEmpty) {
      final List<Beneficiary> beneficiaries = [beneficiary];
      final String encodedBeneficiaries = jsonEncode(beneficiaries);
      await saveStringToPrefs(
        SharedPrefernecesKeys.beneficiaryList,
        encodedBeneficiaries,
      );
      return;
    } else {
      final List<Beneficiary> beneficiaries =
          (jsonDecode(savedEncodedBeneficiaries) as List)
              .map((e) => Beneficiary.fromJson(e))
              .toList();
      beneficiaries.add(beneficiary);
      final String encodedBeneficiaries = jsonEncode(beneficiaries);
      await saveStringToPrefs(
        SharedPrefernecesKeys.beneficiaryList,
        encodedBeneficiaries,
      );
    }
  }

  @override
  Future<void> rechargeToBeneficiary({
    required int amount,
    required String beneficiaryId,
  }) async {
    final authorizationStatus = await getBoolFromPrefs(
          SharedPrefernecesKeys.userAuthStatus,
        ) ??
        false;

    final balance =
        await getDoubleFromPrefs(SharedPrefernecesKeys.userBalance) ?? 0;

    if (balance + 1 < amount) {
      throw InsufficientBalanceException();
    }

    if (authorizationStatus == true) {
      final currentMonthlyTransactions =
          await transactionsDatasource.getMonthlyTransactions();

      final totalMonthlyTransactionAmount =
          currentMonthlyTransactions.values.isNotEmpty
              ? currentMonthlyTransactions.values
                  .reduce((value, element) => value + element)
              : 0;

      if (currentMonthlyTransactions.containsKey(beneficiaryId)) {
        final currentAmount = currentMonthlyTransactions[beneficiaryId]!;
        if (currentAmount + amount > 1000) {
          throw Exception("Monthly limit exceeded");
        } else if (totalMonthlyTransactionAmount + amount > 3000) {
          throw Exception("Monthly limit exceeded");
        } else {
          await transactionsDatasource.addTransaction(
              transaction: Transaction(
            amount: amount.floor() + 1,
            month: DateTime.now().month,
            beneficiaryId: beneficiaryId,
          ));
        }
      } else {
        await transactionsDatasource.addTransaction(
            transaction: Transaction(
          amount: amount.floor(),
          month: DateTime.now().month,
          beneficiaryId: beneficiaryId,
        ));
      }
      final newBalance = balance - amount - 1;
      await saveDoubleToPrefs(
        SharedPrefernecesKeys.userBalance,
        newBalance,
      );
    } else {
      final currentMonthlyTransactions =
          await transactionsDatasource.getMonthlyTransactions();

      final totalMonthlyTransactionAmount =
          currentMonthlyTransactions.values.isNotEmpty
              ? currentMonthlyTransactions.values
                  .reduce((value, element) => value + element)
              : 0;

      if (currentMonthlyTransactions.containsKey(beneficiaryId)) {
        final currentAmount = currentMonthlyTransactions[beneficiaryId]!;
        if (currentAmount + amount > 500) {
          throw Exception("Monthly limit exceeded");
        } else if (totalMonthlyTransactionAmount + amount > 3000) {
          throw Exception("Monthly limit exceeded");
        } else {
          await transactionsDatasource.addTransaction(
              transaction: Transaction(
            amount: amount.floor() + 1,
            month: DateTime.now().month,
            beneficiaryId: beneficiaryId,
          ));
        }
      } else {
        await transactionsDatasource.addTransaction(
            transaction: Transaction(
          amount: amount.floor(),
          month: DateTime.now().month,
          beneficiaryId: beneficiaryId,
        ));
      }
      final newBalance = balance - amount - 1;
      await saveDoubleToPrefs(
        SharedPrefernecesKeys.userBalance,
        newBalance,
      );
    }
  }

  @override
  Future<void> removeBeneficiary({required Beneficiary beneficiary}) async {
    final String savedEncodedBeneficiaries =
        await getStringFromPrefs(SharedPrefernecesKeys.beneficiaryList) ?? "";

    if (savedEncodedBeneficiaries.isEmpty) {
      return;
    } else {
      final List<Beneficiary> beneficiaries =
          (jsonDecode(savedEncodedBeneficiaries) as List)
              .map((e) => Beneficiary.fromJson(e))
              .toList();
      beneficiaries.remove(beneficiary);
      final String encodedBeneficiaries = jsonEncode(beneficiaries);
      saveStringToPrefs(
        SharedPrefernecesKeys.beneficiaryList,
        encodedBeneficiaries,
      );
      return;
    }
  }

  @override
  Future<List<Beneficiary>> getBeneficiaries() async {
    final String savedEncodedBeneficiaries =
        await getStringFromPrefs(SharedPrefernecesKeys.beneficiaryList) ?? "";

    if (savedEncodedBeneficiaries.isEmpty) {
      return [];
    } else {
      final List<Beneficiary> beneficiaries =
          (jsonDecode(savedEncodedBeneficiaries) as List)
              .map((e) => Beneficiary.fromJson(e))
              .toList();
      return beneficiaries;
    }
  }
}
