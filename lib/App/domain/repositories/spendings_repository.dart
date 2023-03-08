import 'package:myfin/App/domain/models/spendings_model.dart';
import 'package:myfin/App/domain/remote_data_sources/spending_data_source.dart';

class SpendingsRepository {
  SpendingsRepository({
    required this.firebaseSpendingsDataSource,
  });
  final FirebaseSpendingsDataSource firebaseSpendingsDataSource;

  Stream<List<SpendingsModel>> getSpendingsStream() {
    return firebaseSpendingsDataSource.getSpendingsStream();
  }

  Future<void> remove({required String id}) async {
    return firebaseSpendingsDataSource.remove(id: id);
  }

  Future<void> addSpending(
    String name,
    String value,
    DateTime selectedDate,
    var spendingIcon,
  ) async {
    return firebaseSpendingsDataSource.addSpending(
      name,
      value,
      selectedDate,
      spendingIcon,
    );
  }
}
