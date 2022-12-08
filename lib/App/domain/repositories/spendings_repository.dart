import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myfin/App/domain/models/spendings_model.dart';

class SpendingsRepository {
  Stream<List<SpendingsModel>> getSpendingsStream() {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('spendings')
        .snapshots()
        .map((querySnapshoit) {
      return querySnapshoit.docs.map(
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

  Future<void> delete({required String id}) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
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
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
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
}
