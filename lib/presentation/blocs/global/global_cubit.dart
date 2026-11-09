import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'global_state.dart';

@singleton
class GlobalCubit extends Cubit<GlobalState> {
  GlobalCubit() : super(const GlobalState());

  void showLoading() {
    emit(state.copyWith(isLoading: true));
  }

  void hideLoading() {
    emit(state.copyWith(isLoading: false));
  }
}