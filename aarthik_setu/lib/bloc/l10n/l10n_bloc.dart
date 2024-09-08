import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'l10n_event.dart';
part 'l10n_state.dart';

class L10nBloc extends Bloc<L10nEvent, L10nState> {
  L10nBloc() : super(L10n()) {
    on<ChangeLocale>((event, emit) {
      emit(L10n(locale: event.locale));
    });
  }
}
