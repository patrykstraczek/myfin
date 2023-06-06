import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:myfin/App/core/enums.dart';
import 'package:myfin/App/domain/models/incomes_model.dart';
import 'package:myfin/App/domain/models/spendings_model.dart';
import 'package:myfin/App/domain/repositories/incomes_repository.dart';
import 'package:myfin/App/domain/repositories/spendings_repository.dart';
import 'package:myfin/app/features/pages/all_items/cubit/all_items/all_items_cubit.dart';


class MockSpendingsRepository extends Mock implements SpendingsRepository {}

class MockIncomesRepository extends Mock implements IncomesRepository {}

void main() {
  late AllItemsCubit sut;
  late MockSpendingsRepository spendingsRepository;
  late MockIncomesRepository incomesRepository;

  setUp(() {
    incomesRepository = MockIncomesRepository();
    spendingsRepository = MockSpendingsRepository();
    sut = AllItemsCubit(incomesRepository, spendingsRepository);
  });

  group('Get spendings and incomes stream', () {
    setUp(() {
      when(() =>
          spendingsRepository
              .getDailySpendingStream(
                  selectedDay: DateTime(2023, 6, 3, 11, 30, 0, 0))
              .first).thenAnswer((_) async => [
            SpendingsModel(
              id: '1',
              spendingName: 'spendingName1',
              spendingValue: 1,
              spendingDate: DateTime(2023, 6, 3, 11, 30, 0, 0),
              selectedSpendingIcon: 1,
            ),
            SpendingsModel(
              id: '2',
              spendingName: 'spendingName2',
              spendingValue: 1,
              spendingDate: DateTime(2023, 6, 4, 11, 30, 0, 0),
              selectedSpendingIcon: 1,
            ),
            SpendingsModel(
              id: '3',
              spendingName: 'spendingName3',
              spendingValue: 1,
              spendingDate: DateTime(2023, 6, 5, 11, 30, 0, 0),
              selectedSpendingIcon: 1,
            ),
          ]);
    });

    setUp(() {
      when(() =>
          incomesRepository
              .getDailyIncomeStream(
                  selectedDay: DateTime(2023, 6, 3, 11, 30, 0, 0))
              .first).thenAnswer((_) async => [
            IncomesModel(
              id: '1',
              incomeName: 'incomeName1',
              incomeValue: 1,
              incomeDate: DateTime(2023, 6, 3, 11, 30, 0, 0),
              selectedIncomesIcon: 1,
            ),
            IncomesModel(
              id: '2',
              incomeName: 'incomeName2',
              incomeValue: 1,
              incomeDate: DateTime(2023, 6, 4, 11, 30, 0, 0),
              selectedIncomesIcon: 1,
            ),
            IncomesModel(
              id: '3',
              incomeName: 'incomeName3',
              incomeValue: 1,
              incomeDate: DateTime(2023, 6, 5, 11, 30, 0, 0),
              selectedIncomesIcon: 1,
            ),
          ]);
    });
    blocTest<AllItemsCubit, AllItemsState>(
      'Get DailyStream and emit Status.loading then Status.success with results',
      build: () => sut,
      act: (cubit) =>
          cubit.getDailyStream(selectedDay: DateTime(2023, 6, 3, 11, 30, 0, 0)),
      expect: () => [
        const AllItemsState(
          status: Status.loading,
        ),
        AllItemsState(
          status: Status.success,
          incomesDocs: [
            IncomesModel(
              id: '1',
              incomeName: 'incomeName1',
              incomeValue: 1,
              incomeDate: DateTime(2023, 6, 3, 11, 30, 0, 0),
              selectedIncomesIcon: 1,
            ),
          ],
          spendingDocs: [
            SpendingsModel(
              id: '1',
              spendingName: 'spendingName1',
              spendingValue: 1,
              spendingDate: DateTime(2023, 6, 3, 11, 30, 0, 0),
              selectedSpendingIcon: 1,
            ),
          ],
        )
      ],
    );
  });
}
