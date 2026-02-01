import 'dart:async';
import 'package:flutter_application_1/repositories/crypto_coin/abstract_coin_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/repositories/crypto_coin/models/crypto_coin.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'crypto_list_event.dart';
part 'crypto_list_state.dart';

class CryptoListBloc extends Bloc<CryptoListEvent, CryptoListState> {
  CryptoListBloc(this.coinsRepository) : super(CryptoListInitial()) {
    on<LoadCryptoList>(_load);
  }

  final AbstractCoinsRepository coinsRepository;

  Future<void> _load(
    LoadCryptoList event,
    Emitter<CryptoListState> emit,
  ) async {
    try {
      if (state is! CryptoListLoaded) {
        emit(CryptoListLoading());
      }
      final coinsList = await coinsRepository.getCoinsList();
      emit(CryptoListLoaded(coinsList: coinsList));
    } catch (e) {
      emit(CryptoListLoadingFailure(exception: e));
    } finally {
      event.completer?.complete();
    }
  }
}