import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/crypto_coin/view/crypto_coin_screen.dart';
import 'package:flutter_application_1/features/crypto_list/crypto_list.dart';
import 'package:flutter_application_1/repositories/crypto_coin/models/crypto_coin.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter  {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: CryptoListRoute.page, path: '/'),
    AutoRoute(page: CryptoCoinRoute.page),
  ];
  }