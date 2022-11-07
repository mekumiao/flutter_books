import 'package:formz/formz.dart';

enum EmailValidationError {
  empty,
  invalid,
  lengthInvalid,
}

class Email extends FormzInput<String, EmailValidationError> {
  const Email.pure() : super.pure('');
  const Email.dirty([super.value = '']) : super.dirty();

  factory Email.fromJson(Map<String, dynamic> json) {
    final v = json['value'] as String?;
    return v?.isEmpty ?? true ? const Email.pure() : Email.dirty(v!);
  }
  Map<String, dynamic> toJson() => {'value': value};

  static const min = 5;
  static const max = 30;
  static final RegExp _regExp = RegExp(
    r'^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$',
  );

  @override
  EmailValidationError? validator(String value) {
    if (value.isEmpty) {
      return EmailValidationError.empty;
    } else if (value.length > max || value.length < min) {
      return EmailValidationError.lengthInvalid;
    } else if (!_regExp.hasMatch(value)) {
      return EmailValidationError.invalid;
    } else {
      return null;
    }
  }
}
