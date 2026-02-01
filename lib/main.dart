import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/crypto_coin_list_app.dart';
import 'package:flutter_application_1/repositories/crypto_coin/crypto_coin.dart';
import 'package:get_it/get_it.dart';

void main() {
  GetIt.I.registerLazySingleton<AbstractCoinsRepository>(
    () => CryptoCoinsRepository(dio: Dio()),
  );

  runApp(const Crypto());
}
