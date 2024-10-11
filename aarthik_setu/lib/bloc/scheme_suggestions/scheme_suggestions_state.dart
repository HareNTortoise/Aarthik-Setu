// scheme_suggestions_state.dart
part of 'scheme_suggestions_bloc.dart';

@immutable
abstract class SchemeSuggestionsState {}

class SchemeSuggestionsInitial extends SchemeSuggestionsState {}

class SchemeSuggestionsLoading extends SchemeSuggestionsState {}

class SchemeSuggestionsLoaded extends SchemeSuggestionsState {
  final SchemeSuggestions schemeSuggestions;

  SchemeSuggestionsLoaded({required this.schemeSuggestions});
}

class SchemeSuggestionsError extends SchemeSuggestionsState {
  final String error;

  SchemeSuggestionsError({required this.error});
}
