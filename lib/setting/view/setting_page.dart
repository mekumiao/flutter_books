import 'package:booksapp/app/bloc/app_bloc.dart';
import 'package:booksapp/l10n/localization.dart';
import 'package:booksapp/language/language.dart';
import 'package:booksapp/setting/bloc/setting_bloc.dart';
import 'package:booksapp/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:general_data/general_data.dart';
import 'package:general_widgets/general_widgets.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const SettingPage());
  }

  static Page<void> page() {
    return const MaterialPage<void>(child: SettingPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingBloc()..add(VersionLoaded()),
      child: const SettingView(),
    );
  }
}

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: context.apptr.menu_setting),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            _ThemeButton(),
            _LanguageButton(),
            _LogOutButton(),
          ],
        ),
      ),
    );
  }
}

class _ThemeButton extends StatelessWidget {
  const _ThemeButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      buildWhen: (previous, current) => previous.themeMode != current.themeMode,
      builder: (context, state) => NavigationButton(
        key: const Key('settingPage_themeButton'),
        title: context.apptr.theme,
        content: themeText(context, state.themeMode),
        onTap: () {
          Navigator.push(context, ThemePage.route());
        },
      ),
    );
  }

  String themeText(BuildContext context, ThemeMode mode) {
    switch (mode) {
      case ThemeMode.dark:
        return context.apptr.dark;
      case ThemeMode.light:
        return context.apptr.light;
      case ThemeMode.system:
        return context.apptr.follow;
    }
  }
}

class _LanguageButton extends StatelessWidget {
  const _LanguageButton();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AppBloc, AppState, String>(
      selector: (state) {
        return state.languageCode;
      },
      builder: (context, state) {
        return NavigationButton(
          key: const Key('settingPage_languageButton'),
          title: context.apptr.language,
          content: languageText(context, state),
          onTap: () {
            Navigator.push(context, LanguagePage.route());
          },
        );
      },
    );
  }

  String languageText(BuildContext context, String languageCode) {
    switch (languageCode) {
      case 'zh':
        return context.apptr.lang_chinese;
      case 'en':
        return context.apptr.lang_english;
      default:
        return context.apptr.follow;
    }
  }
}

class _LogOutButton extends StatelessWidget {
  const _LogOutButton();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AppBloc, AppState, AppStatus>(
      selector: (state) => state.status,
      builder: (context, state) => state == AppStatus.authenticated
          ? NavigationButton(
              key: const Key('settingPage_logOutButton'),
              title: context.apptr.settingPage_logOutButton_title,
              content: context.apptr.settingPage_logOutButton_text,
              onTap: () async {
                await showDialog<void>(
                  context: context,
                  builder: (_) {
                    return BaseDialog(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: Text(
                          context.apptr.settingPage_logOutButton_dialogText,
                          style: TextStyles.textSize16,
                        ),
                      ),
                      onPressed: () {
                        context.read<AppBloc>().add(LogoutRequested());
                      },
                    );
                  },
                );
              },
            )
          : Gaps.empty,
    );
  }
}
