import 'package:authentication_repository/authentication_repository.dart';
import 'package:booksapp/app/app.dart';
import 'package:booksapp/gen/assets.gen.dart';
import 'package:booksapp/l10n/localization.dart';
import 'package:booksapp/login/login.dart';
import 'package:browser/browser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:general_data/general_data.dart';
import 'package:helper/helper.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const LoginPage());
  }

  static Page<void> page() {
    return const MaterialPage<void>(child: LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        context.read<AppBloc>().add(AutoAuthorized());
        return LoginCubit(authenticationRepository: context.read());
      },
      child: const LoginView(),
    );
  }
}

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Material(
        color: const Color(0xFF6D93FF),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: _buildBody(),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Center(
      child: Column(
        children: [
          const SizedBox(
            width: 52,
            height: 18,
            child: Text(
              'Readify',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
          ),
          Gaps.vGap32,
          Assets.images.loginCover.image(
            width: 203,
            height: 146,
          ),
          const LoginForm(),
          Gaps.vGap10,
          Row(
            children: const [
              _GoogleLoginButton(),
              Gaps.hGap8,
              _FacebookLoginButton(),
            ],
          ),
          Gaps.vGap10,
          const _SignUpTextButton(),
        ],
      ),
    );
  }
}

class _GoogleLoginButton extends StatelessWidget {
  const _GoogleLoginButton();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<LoginCubit, LoginState, FormzStatus>(
      selector: (state) {
        return state.status;
      },
      builder: (context, state) {
        return Material(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: InkWell(
            key: const Key('loginPage_googleLoginButton_textButton'),
            onTap: state == FormzStatus.submissionInProgress
                ? null
                : () {
                    context.read<LoginCubit>().logInWithGoogle();
                  },
            borderRadius: BorderRadius.circular(8),
            child: Assets.images.icGoogle.image(height: 45, width: 45),
          ),
        );
      },
    );
  }
}

class _FacebookLoginButton extends StatelessWidget {
  const _FacebookLoginButton();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<LoginCubit, LoginState, FormzStatus>(
      selector: (state) {
        return state.status;
      },
      builder: (context, state) {
        return Material(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: InkWell(
            key: const Key('loginPage_facebookLoginButton_textButton'),
            onTap: state == FormzStatus.submissionInProgress
                ? null
                : () {
                    context.read<LoginCubit>().logInWithGoogle();
                  },
            borderRadius: BorderRadius.circular(8),
            child: Assets.images.icFacebook.image(height: 45, width: 45),
          ),
        );
      },
    );
  }
}

class _SignUpTextButton extends StatelessWidget {
  const _SignUpTextButton();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: const Key('loginPage_registerButton_textButton'),
      onTap: () async {
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
      child: const Text(
        '已经有账号了？前往注册',
        style: TextStyle(
          color: Colors.white,
          fontSize: Dimens.font_sp8,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
