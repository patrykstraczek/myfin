import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myfin/App/domain/models/spendings_model.dart';

class FirebaseSpendingsDataSource {
  final userID = FirebaseAuth.instance.currentUser?.uid;
  Stream<List<SpendingsModel>> getSpendingsStream() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('spendings')
        .orderBy('date', descending: true)
        .snapshots()
        .map((querySnapshots) {
      return querySnapshots.docs.map(
        (doc) {
          return SpendingsModel(
            id: doc.id,
            spendingName: doc['spending_name'],
            spendingValue: doc['spending_value'],
            spendingDate: (doc['date'] as Timestamp).toDate(),
            selectedSpendingIcon: doc['icon'],
          );
        },
      ).toList();
    });
  }

  Future<void> remove({required String id}) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('spendings')
        .doc(id)
        .delete();
  }

  Future<void> addSpending(
    String name,
    String value,
    DateTime selectedDate,
    var spendingIcon,
  ) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('spendings')
        .add(
      {
        'icon': spendingIcon,
        'spending_name': name,
        'spending_value': double.parse(value),
        'date': selectedDate,
      },
    );
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getSpendings(
      DateTime start, DateTime end) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('spendings')
        .where("date", isGreaterThanOrEqualTo: start)
        .where("date", isLessThanOrEqualTo: end)
        .snapshots();
  }
}

