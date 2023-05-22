import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:myfin/App/domain/remote_data_sources/exchange_rates_data_source.dart';
import 'package:myfin/App/domain/remote_data_sources/incomes_data_source.dart';
import 'package:myfin/App/domain/remote_data_sources/spending_data_source.dart';
import 'package:myfin/App/domain/repositories/exchange_rates_repository.dart';
import 'package:myfin/App/domain/repositories/incomes_repository.dart';
import 'package:myfin/App/domain/repositories/spendings_repository.dart';
import 'package:myfin/App/features/pages/add/cubit/add_page_cubit.dart';
import 'package:myfin/App/features/pages/all_items/cubit/incomes/incomes_cubit.dart';
import 'package:myfin/App/features/pages/all_items/cubit/spendings/spendings_cubit.dart';
import 'package:myfin/App/features/pages/exchange/cubit/exchange_rates_cubit.dart';
import 'package:myfin/app/features/pages/all_items/cubit/all_items/all_items_cubit.dart';

import 'package:myfin/app/features/pages/daily/cubit/daily_reports_cubit.dart';
import 'package:myfin/app/features/pages/details/cubit/details_cubit.dart';

final getIt = GetIt.instance;

void configureDependencies() {
  
  //Bloc
  getIt.registerFactory(() => DailyReportsCubit(
      spendingsRepository: getIt(), incomesRepository: getIt()));
  getIt.registerFactory(() =>
      AddPageCubit(spendingsRepository: getIt(), incomesRepository: getIt()));
  getIt.registerFactory(() => AllItemsCubit(getIt(), getIt()));
  getIt.registerFactory(() => SpendingsCubit(spendingsRepository: getIt()));
  getIt.registerFactory(() => IncomesCubit(incomesRepository: getIt()));
  getIt.registerFactory(
      () => ExchangeRatesCubit(exchangeRatesRepository: getIt()));
  getIt.registerFactory(() => DetailsCubit(getIt(), getIt()));

  //Repositories
  getIt.registerFactory(
      () => ExchangeRatesRepository(remoteDataSource: getIt()));
  getIt.registerFactory(
      () => IncomesRepository(firebaseIncomeDataSource: getIt()));
  getIt.registerFactory(
      () => SpendingsRepository(firebaseSpendingsDataSource: getIt()));

  //DataSources
  getIt.registerFactory(() => ExchangeRatesDTO(Dio()));
  getIt.registerFactory(() => FirebaseIncomeDataSource());
  getIt.registerFactory(() => FirebaseSpendingsDataSource());
}
