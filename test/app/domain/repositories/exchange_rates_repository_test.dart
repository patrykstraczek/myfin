import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:myfin/App/domain/models/api_model.dart';
import 'package:myfin/App/domain/models/exchange_rates_model.dart';
import 'package:myfin/App/domain/remote_data_sources/exchange_rates_data_source.dart';
import 'package:myfin/App/domain/repositories/exchange_rates_repository.dart';

class MockExchangeRatesDataSource extends Mock implements ExchangeRatesDTO {}

void main() {
  late ExchangeRatesRepository sut;
  late MockExchangeRatesDataSource dataSource;

  setUp(() {
    dataSource = MockExchangeRatesDataSource();
    sut = ExchangeRatesRepository(remoteDataSource: dataSource);
  });

  group('getExchangeRatesModel', () {
    test('should call remoteDataSource.getExchangeRates() method', () async {
      // arrange
      when(() => dataSource.getDataFromApi()).thenAnswer(
        (_) => Future.value([ApiModel('', '', '', [])]),
      );

      // act
      await sut.getExchangeRatesModel();

      // assert
      verify(() => dataSource.getDataFromApi()).called(1);
    });

    test('should return list of ExchangeRatesModel', () async {
      // arrange
      when(() => dataSource.getDataFromApi()).thenAnswer(
        (_) async => [
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
        ],
      );

      // act
      final result = await sut.getExchangeRatesModel();

      // assert
      expect(result.length, 3);
      expect(
        result,
        [
          ExchangeRatesModel('USD', 3.8),
          ExchangeRatesModel('EUR', 4.5),
          ExchangeRatesModel('GBP', 5.2),
        ],
      );
    });
  });
}
