import 'package:myfin/App/domain/models/incomes_model.dart';
import 'package:myfin/App/domain/remote_data_sources/incomes_data_source.dart';

class IncomesRepository {
  IncomesRepository({
    required this.firebaseIncomeDataSource,
  });
  final FirebaseIncomeDataSource firebaseIncomeDataSource;

  Stream<List<IncomesModel>> getIncomesStream() {
    return firebaseIncomeDataSource.getIncomesStream();
  }

  Future<void> remove({required String id}) async {
    return firebaseIncomeDataSource.remove(id: id);
  }

  Future<void> addIncome(
    String name,
    String value,
    DateTime selectedDate,
    var incomeIcon,
  ) async {
    return firebaseIncomeDataSource.addIncome(
      name,
      value,
      selectedDate,
      incomeIcon,
    );
  }
}
