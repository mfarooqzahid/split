// ignore_for_file: public_member_api_docs, sort_constructors_first
class BillDetailsModel {
  final String billName;
  final double amount;
  final List<String> members;
  final String whosPaying;

  BillDetailsModel({
    required this.billName,
    required this.amount,
    required this.members,
    required this.whosPaying,
  });

  @override
  String toString() {
    return 'BillDetailsModel(billName: $billName, amount: $amount, members: $members, whosPaying: $whosPaying)';
  }
}
