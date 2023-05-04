import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:myfin/App/domain/models/incomes_model.dart';
import 'package:myfin/App/domain/remote_data_sources/incomes_data_source.dart';
import 'package:myfin/App/domain/repositories/incomes_repository.dart';

class MockFirebaseIncomeDataSource extends Mock
    implements FirebaseIncomeDataSource {}

void main() {
  late IncomesRepository sut;
  late MockFirebaseIncomeDataSource dataSource;

  setUp(() {
    dataSource = MockFirebaseIncomeDataSource();
    sut = IncomesRepository(firebaseIncomeDataSource: dataSource);
  });

  group('getIncomesModel', () {
    test('Should call firebaseIncomeDataSource.getIncomesStream() method',
        () async {
      //arrange
      when(() => dataSource.getIncomesStream())
          .thenAnswer((_) => Stream.value([]));
      //act
      sut.getIncomesStream();
      //assert
      verify(() => dataSource.getIncomesStream());
    });

    test('Should emit list of all incomes', () async {
      //arrange
      when(() => dataSource.getIncomesStream()).thenAnswer((_) => Stream.value([
            IncomesModel(
              id: '1',
              incomeDate: DateTime(2022, 4, 1, 12, 30, 0, 0),
              incomeName: 'incomeName1',
              incomeValue: 1,
              selectedIncomesIcon: 1,
            ),
            IncomesModel(
              id: '2',
              incomeDate: DateTime(2022, 5, 2, 12, 30, 0, 0),
              incomeName: 'incomeName2',
              incomeValue: 2,
              selectedIncomesIcon: 2,
            ),
            IncomesModel(
              id: '3',
              incomeDate: DateTime(2023, 6, 3, 12, 30, 0, 0),
              incomeName: 'incomeName3',
              incomeValue: 3,
              selectedIncomesIcon: 3,
            ),
          ]));
      //act
      final results = sut.getIncomesStream();
      //assert
      await expectLater(
          results,
          emitsInOrder([
            [
              IncomesModel(
                id: '1',
                incomeDate: DateTime(2022, 4, 1, 12, 30, 0, 0),
                incomeName: 'incomeName1',
                incomeValue: 1,
                selectedIncomesIcon: 1,
              ),
              IncomesModel(
                id: '2',
                incomeDate: DateTime(2022, 5, 2, 12, 30, 0, 0),
                incomeName: 'incomeName2',
                incomeValue: 2,
                selectedIncomesIcon: 2,
              ),
              IncomesModel(
                id: '3',
                incomeDate: DateTime(2023, 6, 3, 12, 30, 0, 0),
                incomeName: 'incomeName3',
                incomeValue: 3,
                selectedIncomesIcon: 3,
              )
            ]
          ]));
    });

    test('Should emit list of incomes in given year', () async {
      //arrange
      when(() => dataSource.getIncomesStream()).thenAnswer((_) => Stream.value([
            IncomesModel(
              id: '1',
              incomeDate: DateTime(2022, 4, 1, 12, 30, 0, 0),
              incomeName: 'incomeName1',
              incomeValue: 1,
              selectedIncomesIcon: 1,
            ),
            IncomesModel(
              id: '2',
              incomeDate: DateTime(2022, 5, 2, 12, 30, 0, 0),
              incomeName: 'incomeName2',
              incomeValue: 2,
              selectedIncomesIcon: 2,
            ),
            IncomesModel(
              id: '3',
              incomeDate: DateTime(2023, 6, 3, 12, 30, 0, 0),
              incomeName: 'incomeName3',
              incomeValue: 3,
              selectedIncomesIcon: 3,
            ),
          ]));
      //act
      final results = sut.getYearlyIncomeStream(year: 2023);
      //assert
      await expectLater(
          results,
          emitsInOrder([
            [
              IncomesModel(
                id: '3',
                incomeDate: DateTime(2023, 6, 3, 12, 30, 0, 0),
                incomeName: 'incomeName3',
                incomeValue: 3,
                selectedIncomesIcon: 3,
              )
            ]
          ]));
    });
    test('Should emit list of incomes in given month', () async {
      //arrange
      when(() => dataSource.getIncomesStream()).thenAnswer((_) => Stream.value([
            IncomesModel(
              id: '1',
              incomeDate: DateTime(2022, 4, 1, 12, 30, 0, 0),
              incomeName: 'incomeName1',
              incomeValue: 1,
              selectedIncomesIcon: 1,
            ),
            IncomesModel(
              id: '2',
              incomeDate: DateTime(2022, 5, 2, 12, 30, 0, 0),
              incomeName: 'incomeName2',
              incomeValue: 2,
              selectedIncomesIcon: 2,
            ),
            IncomesModel(
              id: '3',
              incomeDate: DateTime(2023, 6, 3, 12, 30, 0, 0),
              incomeName: 'incomeName3',
              incomeValue: 3,
              selectedIncomesIcon: 3,
            ),
          ]));
      //act
      final results = sut.getMontlyIncomeStream(year: 2022, month: 5);
      //assert
      await expectLater(
          results,
          emitsInOrder([
            [
              IncomesModel(
                id: '2',
                incomeDate: DateTime(2022, 5, 2, 12, 30, 0, 0),
                incomeName: 'incomeName2',
                incomeValue: 2,
                selectedIncomesIcon: 2,
              ),
            ]
          ]));
    });
    test('Should emit list of incomes in given day in month', () async {
      //arrange
      when(() => dataSource.getIncomesStream()).thenAnswer((_) => Stream.value([
            IncomesModel(
              id: '1',
              incomeDate: DateTime(2022, 4, 1, 12, 30, 0, 0),
              incomeName: 'incomeName1',
              incomeValue: 1,
              selectedIncomesIcon: 1,
            ),
            IncomesModel(
              id: '2',
              incomeDate: DateTime(2022, 5, 2, 12, 30, 0, 0),
              incomeName: 'incomeName2',
              incomeValue: 2,
              selectedIncomesIcon: 2,
            ),
            IncomesModel(
              id: '3',
              incomeDate: DateTime(2023, 6, 3, 12, 30, 0, 0),
              incomeName: 'incomeName3',
              incomeValue: 3,
              selectedIncomesIcon: 3,
            ),
            IncomesModel(
              id: '4',
              incomeDate: DateTime(2023, 6, 3, 12, 30, 0, 0),
              incomeName: 'incomeName4',
              incomeValue: 4,
              selectedIncomesIcon: 4,
            ),
          ]));
      //act
      final results = sut.getMontlyIncomeStream(year: 2023, month: 6);
      //assert
      await expectLater(
          results,
          emitsInOrder([
            [
              IncomesModel(
                id: '3',
                incomeDate: DateTime(2023, 6, 3, 12, 30, 0, 0),
                incomeName: 'incomeName3',
                incomeValue: 3,
                selectedIncomesIcon: 3,
              ),
              IncomesModel(
                id: '4',
                incomeDate: DateTime(2023, 6, 3, 12, 30, 0, 0),
                incomeName: 'incomeName4',
                incomeValue: 4,
                selectedIncomesIcon: 4,
              ),
            ]
          ]));
    });
  });
}
