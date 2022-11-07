import 'package:formz/formz.dart';

enum PasswordValidationError {
  empty,
  lengthInvalid,
}

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure() : super.pure('');
  const Password.dirty([super.value = '']) : super.dirty();

  factory Password.fromJson(Map<String, dynamic> json) {
    final v = json['value'] as String?;
    return v?.isEmpty ?? true ? const Password.pure() : Password.dirty(v!);
  }
  Map<String, dynamic> toJson() => {'value': value};

  static const min = 6;
  static const max = 60;

  @override
  PasswordValidationError? validator(String value) {
    if (value.isEmpty) {
      return PasswordValidationError.empty;
    } else if (value.length < min || value.length > max) {
      return PasswordValidationError.lengthInvalid;
    } else {
      return null;
    }
  }
}
