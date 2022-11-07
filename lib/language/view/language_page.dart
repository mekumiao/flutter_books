import 'package:booksapp/l10n/localization.dart';
import 'package:booksapp/language/cubit/language_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:general_data/general_data.dart';
import 'package:general_widgets/general_widgets.dart';

class LanguagePage extends StatelessWidget {
  const LanguagePage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(
      builder: (_) => const LanguagePage(),
    );
  }

  static Page<void> page() {
    return const MaterialPage<void>(child: LanguagePage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LanguageCubit(
        configurationRepository: context.read(),
      ),
      child: const LanguageView(),
    );
  }
}

class LanguageView extends StatelessWidget {
  const LanguageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: context.apptr.language),
      body: ListView(
        children: const [
          Gaps.vGap16,
          _ChineseLanguageButton(),
          Gaps.line,
          _EnglishLanguageButton(),
          Gaps.line,
          _SystemLanguageButton(),
        ],
      ),
    );
  }
}

class _ChineseLanguageButton extends StatelessWidget {
  const _ChineseLanguageButton();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<LanguageCubit, LanguageState, String>(
      selector: (state) {
        return state.languageCode;
      },
      builder: (context, state) {
        return InkWell(
          key: const Key('languagePage_chineseLanguageButton'),
          onTap: () {
            context.read<LanguageCubit>().languageCodeChanged('zh');
          },
          child: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            height: 50,
            child: Row(
              children: <Widget>[
                Expanded(child: Text(context.apptr.lang_chinese)),
                Opacity(
                  opacity: state == 'zh' ? 1 : 0,
                  child: const Icon(Icons.done, color: Colors.blue),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class _EnglishLanguageButton extends StatelessWidget {
  const _EnglishLanguageButton();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<LanguageCubit, LanguageState, String>(
      selector: (state) {
        return state.languageCode;
      },
      builder: (context, state) {
        return InkWell(
          key: const Key('languagePage_englishLanguageButton'),
          onTap: () {
            context.read<LanguageCubit>().languageCodeChanged('en');
          },
          child: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            height: 50,
            child: Row(
              children: <Widget>[
                Expanded(child: Text(context.apptr.lang_english)),
                Opacity(
                  opacity: state == 'en' ? 1 : 0,
                  child: const Icon(Icons.done, color: Colors.blue),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class _SystemLanguageButton extends StatelessWidget {
  const _SystemLanguageButton();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<LanguageCubit, LanguageState, String>(
      selector: (state) {
        return state.languageCode;
      },
      builder: (context, state) {
        return InkWell(
          key: const Key('languagePage_systemLanguageButton'),
          onTap: () {
            context.read<LanguageCubit>().languageCodeChanged('');
          },
          child: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            height: 50,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(context.apptr.follow),
                ),
                Opacity(
                  opacity: state == '' ? 1 : 0,
                  child: const Icon(Icons.done, color: Colors.blue),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
