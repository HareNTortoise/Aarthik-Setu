part of 'l10n_bloc.dart';

@immutable
sealed class L10nState {}

final class L10n extends L10nState {
  final Locale locale;

  L10n({this.locale = const Locale('en')});
}
