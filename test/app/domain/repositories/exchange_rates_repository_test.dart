import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:myfin/App/domain/models/exchange_rates_model.dart';
import 'package:myfin/App/domain/remote_data_sources/exchange_rates_data_source.dart';
import 'package:myfin/App/domain/repositories/exchange_rates_repository.dart';

class MockExchangeRatesDataSource extends Mock
    implements ExchangeRatesDTO {}

void main() {
  late ExchangeRatesRepository sut;
  late MockExchangeRatesDataSource dataSource;

  setUp(() {
    dataSource = MockExchangeRatesDataSource();
    sut = ExchangeRatesRepository(remoteDataSource: dataSource);
  });
  group('getExchangeRatesModel', () {
    test('should call remoteDataSource.getExchangeRatesModel() method',
        () async {
      //1
      when(() => dataSource.getExchangeRates()).thenAnswer(
        (_) async => [],
      );
      //2
      await sut.getExchangeRatesModel();
      //3
      verify(() => dataSource.getExchangeRates());
    });

    test('should display all exchange rates', () async {
      //1
      when(() => dataSource.getExchangeRates()).thenAnswer(
        (_) async => [
          ExchangeRatesModel('code1', 1),
          ExchangeRatesModel('code2', 2),
          ExchangeRatesModel('code3', 3),
        ],
      );
      //2
      final results = await sut.getExchangeRatesModel();
      //3
      expect(
        results,
        [
          ExchangeRatesModel('code1', 1),
          ExchangeRatesModel('code2', 2),
          ExchangeRatesModel('code3', 3),
        ],
      );
    });
  });
}
