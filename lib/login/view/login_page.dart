import 'package:booksapp/app/app.dart';
import 'package:booksapp/l10n/localization.dart';
import 'package:booksapp/login/login.dart';
import 'package:booksapp/setting/setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            key: const Key('loginPage_loginView_iconButton'),
            tooltip: context.apptr.menu_setting,
            onPressed: () {
              Navigator.push(context, SettingPage.route());
            },
            icon: const Icon(Icons.settings_outlined, size: 24),
          ),
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.only(left: 16, right: 16, top: 20),
        child: LoginForm(),
      ),
    );
  }
}
