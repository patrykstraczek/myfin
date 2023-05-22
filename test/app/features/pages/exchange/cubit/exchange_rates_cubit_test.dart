import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:myfin/App/core/enums.dart';
import 'package:myfin/App/domain/repositories/exchange_rates_repository.dart';
import 'package:myfin/App/domain/models/exchange_rates_model.dart';
import 'package:myfin/app/domain/models/api_model.dart';
import 'package:myfin/app/features/pages/exchange/cubit/exchange_rates_cubit.dart';
import 'package:myfin/App/domain/remote_data_sources/exchange_rates_data_source.dart';

class MockExchangeRatesRepository extends Mock
    implements ExchangeRatesRepository {}

class MockExchangeRatesDataSource extends Mock implements ExchangeRatesDTO {}

void main() {
  late ExchangeRatesCubit sut;
  late ExchangeRatesRepository repository;
  late MockExchangeRatesDataSource dataSource;

  setUp(() {
    dataSource = MockExchangeRatesDataSource();
    repository = ExchangeRatesRepository(remoteDataSource: dataSource);
    sut = ExchangeRatesCubit(exchangeRatesRepository: repository);
  });

  group('Get exchange rates', () {
    setUp(() {
      when(() => dataSource.getDataFromApi()).thenAnswer((_) async => [
            ApiModel(
              'A',
              'no',
              'effectiveDate',
              [
                ExchangeRatesModel('USD', 3.8),
                ExchangeRatesModel('EUR', 4.5),
                ExchangeRatesModel('GBP', 5.2),
              ],
            ),
          ]);
    });

    blocTest<ExchangeRatesCubit, ExchangeRatesState>(
      'Emit Status.loading then Status.success with results',
      build: () => sut,
      act: (cubit) => cubit.getExchangeRates(),
      expect: () => [
        ExchangeRatesState(status: Status.loading),
        ExchangeRatesState(
          status: Status.success,
          results: [
            ExchangeRatesModel('USD', 3.8),
            ExchangeRatesModel('EUR', 4.5),
            ExchangeRatesModel('GBP', 5.2),
          ],
        ),
      ],
    );
  });
  group('Error', () {
    setUp(() => when(() => dataSource.getDataFromApi()).thenThrow(
          Exception('test-exception-error'),
        ));
    blocTest<ExchangeRatesCubit, ExchangeRatesState>(
        'Emit Status.loading then Status.error with error message',
        build: () => sut,
        act: (cubit) => cubit.getExchangeRates(),
        expect: () => [
              ExchangeRatesState(
                status: Status.loading,
              ),
              ExchangeRatesState(
                status: Status.error,
                errorMessage: 'Exception: test-exception-error',
              ),
            ]);
  });
}
