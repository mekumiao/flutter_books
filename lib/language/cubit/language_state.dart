part of 'language_cubit.dart';

class LanguageState extends Equatable {
  const LanguageState({required this.languageCode});

  final String languageCode;

  LanguageState copyWith({String? languageCode}) {
    return LanguageState(languageCode: languageCode ?? this.languageCode);
  }

  @override
  List<Object> get props => [languageCode];
}
