import 'package:booksapp/l10n/localization.dart';
import 'package:booksapp/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';
import 'package:general_data/general_data.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool disposed = false;
  final FocusNode focusNode = FocusNode();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final state = context.read<LoginCubit>().state;
    emailController.text = state.email.value;
    passwordController.text = state.password.value;
  }

  @override
  void dispose() {
    if (disposed) return;
    emailController.dispose();
    passwordController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(
                  state.errorMessage ??
                      context
                          .apptr.loginForm_errorMessage_authenticationFailure,
                ),
              ),
            );
        }
      },
      child: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Focus(
            focusNode: focusNode,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gaps.vGap16,
                _EmailInput(
                  focusNode: focusNode,
                  controller: emailController,
                ),
                Gaps.vGap16,
                _PasswordInput(
                  focusNode: focusNode,
                  controller: passwordController,
                ),
                Gaps.vGap16,
                _LoginButton(focusNode: focusNode),
                Gaps.vGap10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const _KeepLogIn(),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        '忘记密码？',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: Dimens.font_sp8,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput({
    required this.focusNode,
    required this.controller,
  });

  final FocusNode focusNode;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<LoginCubit, LoginState, Email>(
      selector: (state) {
        return state.email;
      },
      builder: (context, email) {
        return SizedBox(
          height: 40,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: ColoredBox(
              color: Colors.white.withOpacity(0.32),
              child: _buildTextField(context, email),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextField(BuildContext context, Email email) {
    return TextField(
      key: const Key('loginForm_emailInput_textField'),
      onChanged: (text) {
        context.read<LoginCubit>().emailChanged(text);
      },
      controller: controller,
      style: TextStyles.textSize12.copyWith(color: Colors.white),
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        hintStyle: TextStyle(
          fontSize: 9,
          color: Colors.white.withOpacity(0.34),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
        hintText: context.apptr.loginForm_emailInput_pleaseEnterEmail,
        fillColor: Colors.white,
        border: const OutlineInputBorder(borderSide: BorderSide.none),
      ),
    );
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput({
    required this.focusNode,
    required this.controller,
  });

  final FocusNode focusNode;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<LoginCubit, LoginState, Password>(
      selector: (state) {
        return state.password;
      },
      builder: (context, password) {
        return SizedBox(
          height: 40,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: ColoredBox(
              color: Colors.white.withOpacity(0.32),
              child: _buildTextField(context, password),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextField(BuildContext context, Password password) {
    return TextField(
      key: const Key('loginForm_passwordInput_textField'),
      obscureText: true,
      controller: controller,
      onChanged: (text) {
        context.read<LoginCubit>().passwordChanged(text);
      },
      style: TextStyles.textSize12.copyWith(color: Colors.white),
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.go,
      onSubmitted: (value) {
        context.read<LoginCubit>().logInWithCredentials();
        focusNode.unfocus();
      },
      decoration: InputDecoration(
        hintStyle: TextStyle(
          fontSize: 9,
          color: Colors.white.withOpacity(0.34),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
        hintText: context.apptr.loginForm_passwordInput_pleaseEnterPassword,
        // errorText: password.invalid
        //     ? context.apptr.loginForm_passwordInput_invalidPassword
        //     : null,
        // errorStyle: TextStyles.textSize10,
        fillColor: Colors.white,
        border: const OutlineInputBorder(borderSide: BorderSide.none),
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({required this.focusNode});

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<LoginCubit, LoginState, FormzStatus>(
      selector: (state) => state.status,
      builder: (context, state) => state == FormzStatus.submissionInProgress
          ? const CircularProgressIndicator()
          : SizedBox(
              width: double.infinity,
              height: 40,
              child: _buildButton(
                context: context,
                onPressed: state.isValidated
                    ? () {
                        focusNode.unfocus();
                        context.read<LoginCubit>().logInWithCredentials();
                        Navigator.of(context).pushAndRemoveUntil(
                          LoginPage.route(),
                          (route) => false,
                        );
                      }
                    : null,
              ),
            ),
    );
  }

  Widget _buildButton({
    required BuildContext context,
    VoidCallback? onPressed,
  }) {
    return ElevatedButton(
      key: const Key('loginForm_loginButton_myButton'),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        disabledBackgroundColor: Colors.white60,
        foregroundColor: const Color(0xFF6D93FF),
        disabledForegroundColor: const Color(0xFF6D93FF),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
      child: Text(
        context.apptr.loginForm_loginButton_text,
        textAlign: TextAlign.left,
        style: const TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _KeepLogIn extends StatelessWidget {
  const _KeepLogIn();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildCheckbox(),
        const Text(
          'Remember me',
          style: TextStyle(
            color: Colors.white,
            fontSize: Dimens.font_sp8,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildCheckbox() {
    return BlocSelector<LoginCubit, LoginState, bool>(
      selector: (state) {
        return state.isKeep;
      },
      builder: (context, isKeep) {
        return Checkbox(
          value: isKeep,
          activeColor: Colors.white,
          checkColor: const Color(0xFF6D93FF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          side: const BorderSide(color: Colors.white),
          materialTapTargetSize: MaterialTapTargetSize.padded,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          onChanged: (value) {
            context.read<LoginCubit>().isKeepChanged(isKeep: value ?? false);
          },
        );
      },
    );
  }
}
