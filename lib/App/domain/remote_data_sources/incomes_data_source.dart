import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myfin/App/domain/models/incomes_model.dart';


class FirebaseIncomeDataSource {
  final userID = FirebaseAuth.instance.currentUser?.uid;
  Stream<List<IncomesModel>> getIncomesStream() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('incomes')
        .orderBy('date', descending: true)
        .snapshots()
        .map((querySnapshots) {
      return querySnapshots.docs.map((doc) {
        return IncomesModel(
          id: doc.id,
          incomeName: doc['income_name'],
          incomeValue: doc['income_value'],
          incomeDate: (doc['date'] as Timestamp).toDate(),
          selectedIncomesIcon: doc['icon'],
        );
      }).toList();
    });
  }
  Future<void> remove({required String id}) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('incomes')
        .doc(id)
        .delete();
  }
  Future<void> addIncome(
    String name,
    String value,
    DateTime selectedDate,
    var incomeIcon,
  ) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('incomes')
        .add(
      {
        'icon': incomeIcon,
        'income_name': name,
        'income_value': double.parse(value),
        'date': selectedDate,
      },
    );
  }
  Stream<QuerySnapshot<Map<String, dynamic>>> getIncomes(
      DateTime start, DateTime end) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('incomes')
        .where("date", isGreaterThanOrEqualTo: start)
        .where("date", isLessThanOrEqualTo: end)
        .snapshots();
  }
}