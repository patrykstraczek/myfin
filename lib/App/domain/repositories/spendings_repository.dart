import 'package:myfin/App/domain/models/spendings_model.dart';
import 'package:myfin/App/domain/remote_data_sources/spending_data_source.dart';

class SpendingsRepository {
  final FirebaseSpendingsDataSource _firebaseSpendingsDataSource;

  SpendingsRepository(FirebaseSpendingsDataSource dataSource)
      : _firebaseSpendingsDataSource = dataSource;

  Stream<List<SpendingsModel>> getSpendingsStream() {
    return _firebaseSpendingsDataSource.getSpendingsStream();
  }

  Future<void> remove({required String id}) async {
    return _firebaseSpendingsDataSource.remove(id: id);
  }

  Future<void> addSpending(
    String name,
    String value,
    DateTime selectedDate,
    var spendingIcon,
  ) async {
    return _firebaseSpendingsDataSource.addSpending(
      name,
      value,
      selectedDate,
      spendingIcon,
    );
  }
}
