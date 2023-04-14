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

  Stream<List<IncomesModel>> getYearlyIncomeStream({
    required int year,
  }) {
    return firebaseIncomeDataSource.getIncomesStream().map((incomes) {
      return incomes.where((income) {
        // Extract the year from the spending's created date
        final createdDate = income.incomeDate;
        final createdYear = createdDate.year;

        // Check if the spending was created in the specified year
        return createdYear == year;
      }).toList();
    });
  }

  Stream<List<IncomesModel>> getMontlyIncomeStream({
    required int month,
    required int year,
  }) {
    return firebaseIncomeDataSource.getIncomesStream().map((incomes) {
      return incomes.where((income) {
        // Extract the month and year from the spending's created date
        final createdDate = income.incomeDate;
        final createdMonth = createdDate.month;
        final createdYear = createdDate.year;

        // Check if the spending was created in the specified month and year
        return createdMonth == month && createdYear == year;
      }).toList();
    });
  }

  Stream<List<IncomesModel>> getDailyIncomeStream(
      {required DateTime selectedDate}) {
    return firebaseIncomeDataSource.getIncomesStream().map((incomes) {
      return incomes.where((income) {
        // Extract the month and year from the spending's created date
        final createdDate = income.incomeDate;

        // Check if the spending was created in the specified month and year
        return createdDate == selectedDate;
      }).toList();
    });
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
