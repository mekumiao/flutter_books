import 'package:booksapp/app/app.dart';
import 'package:booksapp/home/bloc/home_bloc.dart';
import 'package:booksapp/home/home.dart';
import 'package:booksapp/l10n/localization.dart';
import 'package:booksapp/setting/setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:general_data/general_data.dart';
import 'package:general_widgets/general_widgets.dart';
import 'package:helper/helper.dart';
import 'package:oktoast/oktoast.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const HomePage());
  }

  static Page<void> page() {
    return const MaterialPage<void>(child: HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        context.read<AppBloc>().add(AutoAuthorized());
        return HomeBloc(authenticationRepository: context.read());
      },
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return DoubleTapBackExitApp(
      onFirst: () {
        showToast(
          context.apptr.exitApp,
          duration: const Duration(milliseconds: 2500),
        );
      },
      onSecond: dismissAllToast,
      child: const Scaffold(
        body: _HomeIndexedStack(),
        bottomNavigationBar: _BottomNavigationBar(),
      ),
    );
  }
}

class _HomeIndexedStack extends StatelessWidget {
  const _HomeIndexedStack();

  static const _list = <Widget>[
    Gaps.empty,
    SettingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocSelector<HomeBloc, HomeState, int>(
      selector: (state) {
        return state.index;
      },
      builder: (context, index) {
        return IndexedStack(
          index: index < _list.length ? index : 0,
          children: _list,
        );
      },
    );
  }
}

class _BottomNavigationBar extends StatelessWidget {
  const _BottomNavigationBar();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<HomeBloc, HomeState, int>(
      selector: (state) => state.index,
      builder: (context, index) {
        final list = [
          BottomNavigationBarItem(
            label: context.apptr.menu_me,
            icon: const Icon(Icons.ten_k),
            activeIcon: const Icon(Icons.ten_k),
          ),
          BottomNavigationBarItem(
            label: context.apptr.menu_setting,
            icon: const Icon(Icons.ten_k),
            activeIcon: const Icon(Icons.ten_k),
          ),
        ];
        return BottomNavigationBar(
          backgroundColor: context.backgroundColor,
          items: list,
          type: BottomNavigationBarType.fixed,
          currentIndex: index < list.length ? index : 0,
          elevation: 5,
          iconSize: 21,
          selectedFontSize: Dimens.font_sp10,
          unselectedFontSize: Dimens.font_sp10,
          onTap: (index) {
            context.read<HomeBloc>().add(TabChanged(index));
          },
        );
      },
    );
  }
}
