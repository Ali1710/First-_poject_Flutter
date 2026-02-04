import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/repositories/crypto_coin/models/crypto_coin_details.dart';
import 'package:hive_ce/hive_ce.dart';

part 'crypto_coin.g.dart';

@HiveType(typeId: 2)  

class CryptoCoin extends Equatable {
  const CryptoCoin({
    required this.name,
    required this.details,
    required this.priceInUSD,
  });
  @HiveField(0)
  final String name;
  @HiveField(1)
  final CryptoCoinDetail details;
  @HiveField(2)
  final double? priceInUSD; 
  @override
  List<Object?> get props => [name, details, priceInUSD];
}