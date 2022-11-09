part of 'login_cubit.dart';

class LoginState extends Equatable {
  const LoginState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = FormzStatus.pure,
    this.errorMessage,
    this.isKeep = false,
  });

  final Email email;
  final Password password;
  final FormzStatus status;
  final String? errorMessage;
  final bool isKeep;

  LoginState copyWith({
    Email? email,
    Password? password,
    FormzStatus? status,
    String? errorMessage,
    bool? isKeep,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      isKeep: isKeep ?? this.isKeep,
    );
  }

  LoginState copyStatus() => copyWith(status: Formz.validate(inputs));

  @override
  List<Object?> get props => [email, password, status, errorMessage, isKeep];

  // ignore: strict_raw_type
  List<FormzInput> get inputs => [email, password];
}
