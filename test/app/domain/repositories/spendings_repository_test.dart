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
    test('Should call firebaseSpendingsDataSource.getSpendingsStream() method',
        () async {
      // arrange
      when(() => dataSource.getSpendingsStream())
          .thenAnswer((_) => Stream.value([]));
      // act
      sut.getSpendingsStream();
      // assert
      verify(() => dataSource.getSpendingsStream());
    });

    test('Should emit list of all spendings', () async {
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
                  spendingDate: DateTime(2022, 5, 2, 12, 30, 0, 0),
                  selectedSpendingIcon: 2,
                ),
                SpendingsModel(
                  id: '3',
                  spendingName: 'spendingName3',
                  spendingValue: 3,
                  spendingDate: DateTime(2023, 6, 3, 12, 30, 0, 0),
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
                spendingDate: DateTime(2022, 5, 2, 12, 30, 0, 0),
                selectedSpendingIcon: 2,
              ),
              SpendingsModel(
                id: '3',
                spendingName: 'spendingName3',
                spendingValue: 3,
                spendingDate: DateTime(2023, 6, 3, 12, 30, 0, 0),
                selectedSpendingIcon: 3,
              ),
            ]
          ]));
    });
    test('Should emit list of spendings in given year', () async {
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
                  spendingDate: DateTime(2022, 5, 2, 12, 30, 0, 0),
                  selectedSpendingIcon: 2,
                ),
                SpendingsModel(
                  id: '3',
                  spendingName: 'spendingName3',
                  spendingValue: 3,
                  spendingDate: DateTime(2023, 6, 3, 12, 30, 0, 0),
                  selectedSpendingIcon: 3,
                ),
              ]));
      //act
      final results = sut.getYearlySpendingsStream(year: 2023);
      //assert
      await expectLater(
          results,
          emitsInOrder([
            [
              SpendingsModel(
                id: '3',
                spendingName: 'spendingName3',
                spendingValue: 3,
                spendingDate: DateTime(2023, 6, 3, 12, 30, 0, 0),
                selectedSpendingIcon: 3,
              ),
            ]
          ]));
    });
    test('Should emit list of spendings in given month', () async {
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
                  spendingDate: DateTime(2022, 5, 2, 12, 30, 0, 0),
                  selectedSpendingIcon: 2,
                ),
                SpendingsModel(
                  id: '3',
                  spendingName: 'spendingName3',
                  spendingValue: 3,
                  spendingDate: DateTime(2023, 6, 3, 12, 30, 0, 0),
                  selectedSpendingIcon: 3,
                ),
              ]));
      //act
      final results = sut.getMontlySpendingsStream(month: 5, year: 2022);
      //assert
      await expectLater(
          results,
          emitsInOrder([
            [
              SpendingsModel(
                id: '2',
                spendingName: 'spendingName2',
                spendingValue: 2,
                spendingDate: DateTime(2022, 5, 2, 12, 30, 0, 0),
                selectedSpendingIcon: 2,
              ),
            ]
          ]));
    });
    test('Should emit list of spendings in given day in month', () async {
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
                  spendingDate: DateTime(2022, 5, 2, 12, 30, 0, 0),
                  selectedSpendingIcon: 2,
                ),
                SpendingsModel(
                  id: '3',
                  spendingName: 'spendingName3',
                  spendingValue: 3,
                  spendingDate: DateTime(2023, 6, 3, 12, 30, 0, 0),
                  selectedSpendingIcon: 3,
                ),
                SpendingsModel(
                  id: '4',
                  spendingName: 'spendingName4',
                  spendingValue: 3,
                  spendingDate: DateTime(2023, 6, 3, 11, 30, 0, 0),
                  selectedSpendingIcon: 3,
                ),
              ]));
      //act
      final results =
          sut.getDailySpendingStream(selectedDay: DateTime(2023, 6, 3));
      //assert
      await expectLater(
          results,
          emitsInOrder([
            [
              SpendingsModel(
                id: '3',
                spendingName: 'spendingName3',
                spendingValue: 3,
                spendingDate: DateTime(2023, 6, 3, 12, 30, 0, 0),
                selectedSpendingIcon: 3,
              ),
              SpendingsModel(
                id: '4',
                spendingName: 'spendingName4',
                spendingValue: 3,
                spendingDate: DateTime(2023, 6, 3, 11, 30, 0, 0),
                selectedSpendingIcon: 3,
              ),
            ]
          ]));
    });
    test('remove calls remove method of FirebaseSpendingsDataSource', () async {
      //arrange
      const id = '1';

      //act
      await sut.remove(id: id);

      //assert
      verifyNever(() => dataSource.remove(id: id));
    });
  });
}
