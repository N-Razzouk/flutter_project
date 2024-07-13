final class Transaction {
  final int amount;
  final int month;
  final String beneficiaryId;

  Transaction({
    required this.amount,
    required this.month,
    required this.beneficiaryId,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      amount: json['amount'],
      month: json['month'],
      beneficiaryId: json['beneficiaryId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'month': month,
      'beneficiaryId': beneficiaryId,
    };
  }
}
