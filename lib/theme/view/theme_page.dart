import 'package:booksapp/l10n/localization.dart';
import 'package:booksapp/theme/cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:general_data/general_data.dart';
import 'package:general_widgets/general_widgets.dart';

class ThemePage extends StatelessWidget {
  const ThemePage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const ThemePage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeCubit(configurationRepository: context.read()),
      child: const ThemeView(),
    );
  }
}

class ThemeView extends StatelessWidget {
  const ThemeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: context.apptr.theme),
      body: ListView(
        children: const [
          Gaps.vGap16,
          _LightThemeButton(),
          Gaps.line,
          _DarkThemeButton(),
          Gaps.line,
          _SystemThemeButton(),
        ],
      ),
    );
  }
}

class _LightThemeButton extends StatelessWidget {
  const _LightThemeButton();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ThemeCubit, ThemeState, ThemeMode>(
      selector: (state) {
        return state.themeMode;
      },
      builder: (context, state) {
        return InkWell(
          key: const Key('themePage_lightThemeButton'),
          onTap: () {
            context.read<ThemeCubit>().themeModeChanged(ThemeMode.light);
          },
          child: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            height: 50,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(context.apptr.light),
                ),
                Opacity(
                  opacity: state == ThemeMode.light ? 1 : 0,
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

class _DarkThemeButton extends StatelessWidget {
  const _DarkThemeButton();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ThemeCubit, ThemeState, ThemeMode>(
      selector: (state) {
        return state.themeMode;
      },
      builder: (context, state) {
        return InkWell(
          key: const Key('themePage_darkThemeButton'),
          onTap: () {
            context.read<ThemeCubit>().themeModeChanged(ThemeMode.dark);
          },
          child: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            height: 50,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(context.apptr.dark),
                ),
                Opacity(
                  opacity: state == ThemeMode.dark ? 1 : 0,
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

class _SystemThemeButton extends StatelessWidget {
  const _SystemThemeButton();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ThemeCubit, ThemeState, ThemeMode>(
      selector: (state) {
        return state.themeMode;
      },
      builder: (context, state) {
        return InkWell(
          key: const Key('themePage_systemThemeButton'),
          onTap: () {
            context.read<ThemeCubit>().themeModeChanged(ThemeMode.system);
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
                  opacity: state == ThemeMode.system ? 1 : 0,
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
