import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myfin/App/core/enums.dart';
import 'package:myfin/App/domain/models/exchange_rates_model.dart';
import 'package:myfin/App/domain/remote_data_sources/exchange_rates_data_source.dart';
import 'package:myfin/App/domain/repositories/exchange_rates_repository.dart';
import 'package:myfin/App/features/pages/exchange/cubit/exchange_rates_cubit.dart';
import 'dart:math' as math;

class ExchangeRatesPage extends StatelessWidget {
  const ExchangeRatesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kursy walut'),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => ExchangeRatesCubit(
          exchangeRatesRepository: ExchangeRatesRepository(
            remoteDataSource: ExchangeRatesDioDataSource(),
          ),
        )..getExchangeRatesModel(),
        child: BlocBuilder<ExchangeRatesCubit, ExchangeRatesState>(
          builder: (context, state) {
            switch (state.status) {
              case Status.initial:
                return const Center(
                  child: Text('Initial state'),
                );
              case Status.loading:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case Status.success:
                return ListView(
                  children: [
                    for (final exchangeRate in state.results)
                      _ExchangeRateBody(exchangeRatesModel: exchangeRate),
                  ],
                );
              case Status.error:
                return Center(
                  child: Text(
                    state.errorMessage ?? 'Unknown error',
                    style: TextStyle(
                      color: Theme.of(context).errorColor,
                    ),
                  ),
                );
            }
          },
        ),
      ),
    );
  }
}

class _ExchangeRateBody extends StatelessWidget {
  const _ExchangeRateBody({
    Key? key,
    required this.exchangeRatesModel,
  }) : super(key: key);

  final ExchangeRatesModel exchangeRatesModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                .withOpacity(.8),
            borderRadius: const BorderRadius.all(Radius.circular(16)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    exchangeRatesModel.code,
                    style: const TextStyle(fontSize: 36),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('Kupno:    ${exchangeRatesModel.purchaseRate}'),
                  const SizedBox(height: 15),
                  Text('Sprzedaż:   ${exchangeRatesModel.sellingRate}'),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
