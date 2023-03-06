import 'package:myfin/App/domain/models/incomes_model.dart';
import 'package:myfin/App/domain/remote_data_sources/incomes_data_source.dart';

class IncomesRepository {
  final FirebaseIncomeDataSource _firebaseIncomeDataSource;

  IncomesRepository(FirebaseIncomeDataSource dataSource)
      : _firebaseIncomeDataSource = dataSource;

  Stream<List<IncomesModel>> getIncomesStream() {
    return _firebaseIncomeDataSource.getIncomesStream();
  }

  Future<void> remove({required String id}) async {
    return _firebaseIncomeDataSource.remove(id: id);
  }

  Future<void> addIncome(
    String name,
    String value,
    DateTime selectedDate,
    var incomeIcon,
  ) async {
    return _firebaseIncomeDataSource.addIncome(
      name,
      value,
      selectedDate,
      incomeIcon,
    );
  }
}
