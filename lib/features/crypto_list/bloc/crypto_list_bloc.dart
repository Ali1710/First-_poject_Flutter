import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/repositories/crypto_coin/crypto_coin.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'crypto_list_event.dart';
part 'crypto_list_state.dart';

class CryptoListBloc extends Bloc<CryptoListEvent, CryptoListState> {
  CryptoListBloc(this.coinRepository) : super(CryptoListInitial()) {
on<LoadCryptoList>((event, emit) async {
  try {
    if (state is! CryptoListLoaded) {
      emit(CryptoListLoading());
    }
    final coinsList = await coinRepository.getCoinList();
    emit(CryptoListLoaded(coinsList: coinsList));
  } catch (e) {
    emit(CryptoListLoadingFailure(exception: e));
  }
  finally {
    event.completer?.complete();
  }
});
  }

  final AbstractCoinRepository coinRepository;
}