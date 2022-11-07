import 'dart:io';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:booksapp/l10n/localization.dart';
import 'package:booksapp/login/login.dart';
import 'package:browser/browser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';
import 'package:general_data/general_data.dart';
import 'package:helper/helper.dart';
import 'package:url_launcher/url_launcher.dart';

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
                Text(
                  context.apptr.loginForm_emailInput_title,
                  style: TextStyles.textBold18,
                ),
                Gaps.vGap16,
                _EmailInput(
                  focusNode: focusNode,
                  controller: emailController,
                ),
                Gaps.vGap24,
                Text(
                  context.apptr.loginForm_passwordInput_title,
                  style: TextStyles.textBold18,
                ),
                Gaps.vGap16,
                _PasswordInput(
                  focusNode: focusNode,
                  controller: passwordController,
                ),
                Gaps.vGap24,
                _LoginButton(focusNode: focusNode),
                Gaps.vGap24,
                Row(
                  children: [
                    if (Platform.isAndroid || Platform.isWindows)
                      _OtherLoginButton(focusNode: focusNode),
                    _RegisterButton(focusNode: focusNode),
                  ],
                ),
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
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_emailInput_textField'),
          maxLength: Email.max,
          onChanged: (text) {
            context.read<LoginCubit>().emailChanged(text);
          },
          controller: controller,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 16),
            hintText: context.apptr.loginForm_emailInput_pleaseEnterEmail,
            errorText: state.invalid
                ? context.apptr.loginForm_emailInput_invalidEmail
                : null,
            errorStyle: TextStyles.textSize10,
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
                width: 0.8,
              ),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).dividerTheme.color!,
                width: 0.8,
              ),
            ),
          ),
        );
      },
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
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_passwordInput_textField'),
          maxLength: Password.max,
          obscureText: true,
          controller: controller,
          onChanged: (text) {
            context.read<LoginCubit>().passwordChanged(text);
          },
          keyboardType: TextInputType.visiblePassword,
          textInputAction: TextInputAction.go,
          onSubmitted: (value) {
            context.read<LoginCubit>().logInWithCredentials();
            focusNode.unfocus();
          },
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 16),
            hintText: context.apptr.loginForm_passwordInput_pleaseEnterPassword,
            errorText: state.invalid
                ? context.apptr.loginForm_passwordInput_invalidPassword
                : null,
            errorStyle: TextStyles.textSize10,
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
                width: 0.8,
              ),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).dividerTheme.color!,
                width: 0.8,
              ),
            ),
          ),
        );
      },
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
          : ElevatedButton(
              key: const Key('loginForm_loginButton_myButton'),
              // style: ElevatedButton.styleFrom(
              //   shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(30),
              //   ),
              // ),
              onPressed: state.isValidated
                  ? () {
                      context.read<LoginCubit>().logInWithCredentials();
                      focusNode.unfocus();
                    }
                  : null,
              child: Text(context.apptr.loginForm_loginButton_text),
            ),
    );
  }
}

class _OtherLoginButton extends StatelessWidget {
  const _OtherLoginButton({required this.focusNode});

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<LoginCubit, LoginState, FormzStatus>(
      selector: (state) {
        return state.status;
      },
      builder: (context, state) {
        return TextButton(
          key: const Key('loginForm_otherLoginButton_textButton'),
          onPressed: state == FormzStatus.submissionInProgress
              ? null
              : () {
                  context.read<LoginCubit>().logInWithOther();
                  focusNode.unfocus();
                },
          child: Text(context.apptr.loginForm_otherLoginButton_text),
        );
      },
    );
  }
}

class _RegisterButton extends StatelessWidget {
  const _RegisterButton({required this.focusNode});

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      key: const Key('loginForm_registerButton_textButton'),
      onPressed: () async {
        focusNode.unfocus();
        if (Device.isMobile) {
          await Browser.open(
            context: context,
            title: context.apptr.loginForm_registerButton_text,
            url: accountRegister,
          );
        } else {
          if (await canLaunchUrl(accountRegister)) {
            await launchUrl(accountRegister);
          }
        }
      },
      child: Text(context.apptr.loginForm_registerButton_text),
    );
  }
}
