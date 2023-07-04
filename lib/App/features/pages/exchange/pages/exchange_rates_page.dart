import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myfin/App/core/enums.dart';
import 'package:myfin/App/domain/models/exchange_rates_model.dart';
import 'package:myfin/App/domain/remote_data_sources/exchange_rates_data_source.dart';
import 'package:myfin/App/domain/repositories/exchange_rates_repository.dart';
import 'package:myfin/app/features/pages/exchange/cubit/exchange_rates_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:math' as math;

import 'package:myfin/app/domain/theme/theme_data.dart';
import 'package:myfin/app/features/pages/home/pages/home_page.dart';

class ExchangeRatesPage extends StatelessWidget {
  const ExchangeRatesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).exchangeRates),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => ExchangeRatesCubit(
          exchangeRatesRepository: ExchangeRatesRepository(
            remoteDataSource: ExchangeRatesDTO(Dio()),
          ),
        )..getExchangeRates(),
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
                return SafeArea(
                  child: ListView(
                    children: [
                      for (final exchangeRate in state.results)
                        _ExchangeRateBody(exchangeRatesModel: exchangeRate),
                      const SizedBox(height: 16)
                    ],
                  ),
                );
              case Status.error:
                if (state.errorMessage?.contains('Failed host lookup') ==
                    true) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(context).connectionFailed,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Center(
                    child: Text(
                      state.errorMessage ?? 'Unknown error',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  );
                }
            }
          },
        ),
      ),
    );
  }
}

class _ExchangeRateBody extends StatelessWidget {
  _ExchangeRateBody({
    Key? key,
    required this.exchangeRatesModel,
  }) : super(key: key);

  final ExchangeRatesModel exchangeRatesModel;
  final exchangeController = TextEditingController();

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
          child: InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => Theme(
                  data: dialogTheme(isDarkMode),
                  child: AlertDialog(
                    title: Text(AppLocalizations.of(context).convert),
                    content: TextField(
                      keyboardType: TextInputType.number,
                      controller: exchangeController,
                      decoration: InputDecoration(
                          hintText: AppLocalizations.of(context).specifyAmount),
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            double value =
                                double.parse(exchangeController.text) *
                                    exchangeRatesModel.averageRate;
                            value = double.parse(value.toStringAsFixed(2));
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: Text('$value PLN'),
                                    ));
                          },
                          child: Text('${exchangeRatesModel.currency} -> PLN')),
                      TextButton(
                          onPressed: () {
                            double value =
                                double.parse(exchangeController.text) /
                                    exchangeRatesModel.averageRate;
                            value = double.parse(value.toStringAsFixed(2));
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: Text(
                                          '$value ${exchangeRatesModel.currency}'),
                                    ));
                          },
                          child: Text('PLN -> ${exchangeRatesModel.currency}')),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(AppLocalizations.of(context).cancel))
                    ],
                  ),
                ),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      exchangeRatesModel.currency,
                      style: const TextStyle(fontSize: 26),
                    ),
                    Text(
                      exchangeRatesModel.code,
                      style: const TextStyle(fontSize: 10),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${exchangeRatesModel.averageRate}  PLN',
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
