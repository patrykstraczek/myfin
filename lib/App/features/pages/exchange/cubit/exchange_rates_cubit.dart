// ignore_for_file: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myfin/App/core/enums.dart';
import 'package:myfin/App/domain/models/exchange_rates_model.dart';
import 'package:myfin/App/domain/repositories/exchange_rates_repository.dart';

part 'exchange_rates_state.dart';
part 'exchange_rates_cubit.freezed.dart';

class ExchangeRatesCubit extends Cubit<ExchangeRatesState> {
  ExchangeRatesCubit({required this.exchangeRatesRepository})
      : super( ExchangeRatesState());

  final ExchangeRatesRepository exchangeRatesRepository;

  Future<void> getExchangeRatesModel() async {
    emit(
       ExchangeRatesState(
        status: Status.loading,
      ),
    );
    try {
      final results = await exchangeRatesRepository.getExchangeRatesModel();
      emit(
        ExchangeRatesState(
          results: results,
          status: Status.success,
        ),
      );
    } catch (error) {
      emit(
        ExchangeRatesState(
          status: Status.error,
          errorMessage: error.toString(),
        ),
      );
    }
  }
}
