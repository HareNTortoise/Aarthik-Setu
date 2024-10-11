import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/lenders.dart';
import '../../models/scheme_suggestion.dart';
import '../../repository/scheme_suggestions.dart';

part 'scheme_suggestions_event.dart';
part 'scheme_suggestions_state.dart';

class SchemeSuggestionsBloc extends Bloc<SchemeSuggestionsEvent, SchemeSuggestionsState> {
  final SchemeSuggestionsRepository schemeSuggestionsRepository;

  SchemeSuggestionsBloc({required this.schemeSuggestionsRepository})
      : super(SchemeSuggestionsInitial()) {
    on<FetchSchemeSuggestions>((event, emit) async {
      emit(SchemeSuggestionsLoading());
      try {
        final SchemeSuggestions suggestions = await schemeSuggestionsRepository.getSchemeSuggestions();
        if (suggestions.schemes.isNotEmpty) {
          emit(SchemeSuggestionsLoaded(schemeSuggestions: suggestions));
        } else {
          emit(SchemeSuggestionsError(error: 'No suggestions found.'));
        }
      } catch (e) {
        emit(SchemeSuggestionsError(error: e.toString()));
      }
    });
  }
}
