import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:myfin/app/domain/remote_data_sources/incomes_data_source.dart';
import 'package:myfin/app/domain/repositories/incomes_repository.dart';

class MockFirebaseIncomesDataSource extends Mock
    implements FirebaseIncomeDataSource {}

void main() {
  late IncomesRepository sut;
  late MockFirebaseIncomesDataSource dataSource;

  setUp(() {
    dataSource = MockFirebaseIncomesDataSource();
    sut = IncomesRepository(firebaseIncomeDataSource: dataSource);
  });
}
