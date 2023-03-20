import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:myfin/App/domain/models/spendings_model.dart';
import 'package:myfin/App/domain/remote_data_sources/spending_data_source.dart';
import 'package:myfin/App/domain/repositories/spendings_repository.dart';

class MockFirebaseSpendingsDataSource extends Mock
    implements FirebaseSpendingsDataSource {}

void main() {
  late SpendingsRepository sut;
  late MockFirebaseSpendingsDataSource dataSource;

  setUp(() {
    dataSource = MockFirebaseSpendingsDataSource();
    sut = SpendingsRepository(firebaseSpendingsDataSource: dataSource);
  });

  group('getSpendingsModel', () {
    test('should call firebaseSpendingsDataSource.getSpendingsStream() method',
        () async {
      // arrange
      when(() => dataSource.getSpendingsStream())
          .thenAnswer((_) => Stream.value([]));
      // act
      sut.getSpendingsStream();
      // assert
      verify(() => dataSource.getSpendingsStream());
    });

    test('should emit list of spendings', () async {
      //arrange
      when(() => dataSource.getSpendingsStream())
          .thenAnswer((_) => Stream.value([
                SpendingsModel(
                  id: '1',
                  spendingName: 'spendingName1',
                  spendingValue: 1,
                  spendingDate: DateTime(2022, 4, 1, 12, 30, 0, 0),
                  selectedSpendingIcon: 1,
                ),
                SpendingsModel(
                  id: '2',
                  spendingName: 'spendingName2',
                  spendingValue: 2,
                  spendingDate: DateTime(2022, 4, 2, 12, 30, 0, 0),
                  selectedSpendingIcon: 2,
                ),
                SpendingsModel(
                  id: '3',
                  spendingName: 'spendingName3',
                  spendingValue: 3,
                  spendingDate: DateTime(2022, 4, 3, 12, 30, 0, 0),
                  selectedSpendingIcon: 3,
                ),
              ]));
      //act
      final results = sut.getSpendingsStream();
      //assert
      await expectLater(
          results,
          emitsInOrder([
            [
              SpendingsModel(
                id: '1',
                spendingName: 'spendingName1',
                spendingValue: 1,
                spendingDate: DateTime(2022, 4, 1, 12, 30, 0, 0),
                selectedSpendingIcon: 1,
              ),
              SpendingsModel(
                id: '2',
                spendingName: 'spendingName2',
                spendingValue: 2,
                spendingDate: DateTime(2022, 4, 2, 12, 30, 0, 0),
                selectedSpendingIcon: 2,
              ),
              SpendingsModel(
                id: '3',
                spendingName: 'spendingName3',
                spendingValue: 3,
                spendingDate: DateTime(2022, 4, 3, 12, 30, 0, 0),
                selectedSpendingIcon: 3,
              ),
            ]
          ]));
    });
  });
}
