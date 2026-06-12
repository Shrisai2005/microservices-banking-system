
class Transaction {

  final int id;
  final String accountNumber;
  final String transactionType;
  final double amount;
  final String transactionTime;

  Transaction({
    required this.id,
    required this.accountNumber,
    required this.transactionType,
    required this.amount,
    required this.transactionTime,
  });

  factory Transaction.fromJson(
      Map<String, dynamic> json) {

    return Transaction(
      id: json['id'],
      accountNumber:
          json['accountNumber'],
      transactionType:
          json['transactionType'],
      amount:
          json['amount'].toDouble(),
      transactionTime:
          json['transactionTime'],
    );
  }
}