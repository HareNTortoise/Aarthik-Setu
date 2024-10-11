// scheme_suggestions_event.dart
part of 'scheme_suggestions_bloc.dart';

@immutable
abstract class SchemeSuggestionsEvent {}

class FetchSchemeSuggestions extends SchemeSuggestionsEvent {}
