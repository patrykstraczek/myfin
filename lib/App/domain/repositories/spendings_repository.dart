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


  Stream<List<SpendingsModel>> getYearlySpendingsStream({
    
    required int year,
  }) {
    return firebaseSpendingsDataSource.getSpendingsStream().map((spendings) {
      return spendings.where((spending) {
        // Extract the month and year from the spending's created date
        final createdDate = spending.spendingDate;
        
        final createdYear = createdDate.year;

        // Check if the spending was created in the specified month and year
        return createdYear ==  year;
      }).toList();
    });
  }

  Stream<List<SpendingsModel>> getMontlySpendingsStream({
    required int month,
    required int year,
  }) {
    return firebaseSpendingsDataSource.getSpendingsStream().map((spendings) {
      return spendings.where((spending) {
        // Extract the month and year from the spending's created date
        final createdDate = spending.spendingDate;
        final createdMonth = createdDate.month;
        final createdYear = createdDate.year;

        // Check if the spending was created in the specified month and year
        return createdMonth == month && createdYear == year;
      }).toList();
    });
  }

  Stream<List<SpendingsModel>> getDailySpendingStream(
      {required DateTime selectedDay}) {
    return firebaseSpendingsDataSource.getSpendingsStream().map((spendings) {
      return spendings.where((spending) {
        // Extract the month and year from the spending's created date
        final createdDate = spending.spendingDate;

        // Check if the spending was created in the specified month and year

        return createdDate.year == selectedDay.year &&
            createdDate.month == selectedDay.month &&
            createdDate.day == selectedDay.day;
      }).toList();
    });
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
