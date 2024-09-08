part of 'l10n_bloc.dart';

@immutable
sealed class L10nEvent {}

final class ChangeLocale extends L10nEvent {
  final Locale locale;

  ChangeLocale(this.locale);
}