part of 'login_cubit.dart';

@JsonSerializable()
class LoginState extends Equatable {
  const LoginState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = FormzStatus.pure,
    this.errorMessage,
  });

  final Email email;
  final Password password;
  final FormzStatus status;
  final String? errorMessage;

  LoginState copyWith({
    Email? email,
    Password? password,
    FormzStatus? status,
    String? errorMessage,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  LoginState copyStatus() => copyWith(status: Formz.validate(inputs));

  @override
  List<Object?> get props => [email, password, status, errorMessage];

  // ignore: strict_raw_type
  List<FormzInput> get inputs => [email, password];
}
