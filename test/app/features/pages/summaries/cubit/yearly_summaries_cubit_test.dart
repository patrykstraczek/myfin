import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:myfin/App/core/enums.dart';
import 'package:myfin/App/domain/models/incomes_model.dart';
import 'package:myfin/App/domain/models/spendings_model.dart';
import 'package:myfin/App/domain/repositories/incomes_repository.dart';
import 'package:myfin/App/domain/repositories/spendings_repository.dart';
import 'package:myfin/app/features/pages/summaries/cubit/yearly_summaries_cubit.dart';

class MockSpendingsRepository extends Mock implements SpendingsRepository {}

class MockIncomesRepository extends Mock implements IncomesRepository {}

void main() {
  late YearlySummariesCubit sut;
  late MockSpendingsRepository spendingsRepository;
  late MockIncomesRepository incomesRepository;
  late List<IncomesModel> incomesList;
  late List<SpendingsModel> spendingsList;

  setUp(() {
    incomesRepository = MockIncomesRepository();
    spendingsRepository = MockSpendingsRepository();
    sut = YearlySummariesCubit(
        incomesRepository: incomesRepository,
        spendingsRepository: spendingsRepository);
    spendingsList = [
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
        spendingDate: DateTime(2023, 7, 4, 11, 30, 0, 0),
        selectedSpendingIcon: 1,
      ),
      SpendingsModel(
        id: '3',
        spendingName: 'spendingName3',
        spendingValue: 1,
        spendingDate: DateTime(2023, 8, 5, 11, 30, 0, 0),
        selectedSpendingIcon: 1,
      ),
    ];
    incomesList = [
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
        incomeDate: DateTime(2023, 7, 4, 11, 30, 0, 0),
        selectedIncomesIcon: 1,
      ),
      IncomesModel(
        id: '3',
        incomeName: 'incomeName3',
        incomeValue: 1,
        incomeDate: DateTime(2023, 8, 5, 11, 30, 0, 0),
        selectedIncomesIcon: 1,
      ),
    ];
  });

  group('Get summ data', () {
    setUp(() {
      when(() => spendingsRepository.getYearlySpendingsStream(year: 2023).first)
          .thenAnswer((_) async => spendingsList);
    });

    setUp(() {
      when(() => incomesRepository.getYearlyIncomeStream(year: 2023).first)
          .thenAnswer((_) async => incomesList);
    });

    blocTest<YearlySummariesCubit, YearlySummariesState>(
      'Get Yearly summaries',
      build: () => sut,
      act: (cubit) => cubit.getYearlyData(year: 2023),
      expect: () => [
        const YearlySummariesState(
          status: Status.loading,
        ),
        YearlySummariesState(
          status: Status.success,
          spendingDocs: spendingsList,
          incomesDocs: incomesList,
        ),
      ],
    );
  });
}
