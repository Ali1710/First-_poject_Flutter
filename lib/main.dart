import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/crypto_coin_list_app.dart';
import 'package:flutter_application_1/repositories/crypto_coin/crypto_coin.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_observer.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_settings.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';
import 'package:talker_flutter/talker_flutter.dart';

void main() {

  final talker = TalkerFlutter.init();
  GetIt.I.registerSingleton(talker);
  GetIt.I<Talker>().debug('Talker started...');

  final dio = Dio();
  dio.interceptors.add(
      TalkerDioLogger(
        talker: talker, 
        settings: const TalkerDioLoggerSettings(
          printResponseData: false,
        )),
  );

  Bloc.observer = TalkerBlocObserver(
     talker: talker, 
     settings: const TalkerBlocLoggerSettings(
          printStateFullData: false,
          printEventFullData: false,
        )
     
  );


  GetIt.I.registerLazySingleton<AbstractCoinsRepository>(
    () => CryptoCoinsRepository(dio: Dio()),
  );

  FlutterError.onError = (FlutterErrorDetails details) {
    GetIt.I<Talker>().handle(details.exception, details.stack);
  };

  runZonedGuarded(() => runApp(const Crypto()), (e, st) {
    GetIt.I<Talker>().handle(e, st);
  });
}