import 'dart:io';

import 'package:api/api.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:booksapp/app/bloc/app_bloc.dart';
import 'package:booksapp/gen/fonts.gen.dart';
import 'package:booksapp/home/home.dart';
import 'package:booksapp/l10n/localization.dart';
import 'package:booksapp/login/login.dart';
import 'package:booksapp/splash/splash.dart';
import 'package:configuration_repository/configuration_repository.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:general_data/general_data.dart';
import 'package:general_widgets/general_widgets.dart';
import 'package:helper/helper.dart';
import 'package:oktoast/oktoast.dart';
import 'package:window_size/window_size.dart';

class App extends StatelessWidget {
  const App({
    super.key,
    this.child,
    required this.versionApi,
    required this.authenticationRepository,
    required this.configurationRepository,
    required this.adaptResultCallback,
  });

  final Widget? child;
  final VersionApi versionApi;
  final AuthenticationRepository authenticationRepository;
  final ConfigurationRepository configurationRepository;
  final AdaptResultCallback adaptResultCallback;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: versionApi),
        RepositoryProvider.value(value: authenticationRepository),
        RepositoryProvider.value(value: configurationRepository),
        RepositoryProvider.value(value: adaptResultCallback),
      ],
      child: BlocProvider(
        create: (context) => AppBloc(
          authenticationRepository: context.read(),
          configurationRepository: context.read(),
        )..add(AppLoaded()),
        child: child ?? const AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({super.key, this.child});

  final Widget? child;

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return _includeOKToast(
      child: BlocSelector<AppBloc, AppState, Tuple2<ThemeMode, Locale?>>(
        selector: (state) {
          return Tuple2(
            item1: state.themeMode,
            item2: state.language,
          );
        },
        builder: (context, state) => MaterialApp(
          home: widget.child,
          navigatorKey: _navigatorKey,
          debugShowCheckedModeBanner: false,
          theme: ThemeDatas.lightThemeData(FontFamily.pingfang),
          darkTheme: ThemeDatas.darkThemeData(FontFamily.pingfang),
          themeMode: state.item1,
          scrollBehavior: const MaterialScrollBehavior().copyWith(
            scrollbars: true,
            dragDevices: {
              PointerDeviceKind.touch,
              PointerDeviceKind.stylus,
              PointerDeviceKind.invertedStylus,
              PointerDeviceKind.unknown,
              PointerDeviceKind.mouse,
            },
          ),
          onGenerateTitle: (context) {
            if (Device.isDesktop) setWindowTitle(context.apptr.title);
            return context.apptr.title;
          },
          onGenerateRoute: (_) => SplashPage.route(),
          localizationsDelegates: const [
            ...AppLocalizations.localizationsDelegates,
            GeneralLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          locale: state.item2,
          builder: (BuildContext context, Widget? child) {
            if (Platform.isAndroid) {
              ThemeHelper.setSystemNavigationBar(state.item1);
            }
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
              child: _buildBlocListener(child),
            );
          },
          onUnknownRoute: (options) => NotFoundPage.route(title: options.name),
        ),
      ),
    );
  }

  Widget _includeOKToast({required Widget child}) {
    return OKToast(
      backgroundColor: Colors.black54,
      textPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      radius: 20,
      position: ToastPosition.bottom,
      duration: const Duration(seconds: 3),
      dismissOtherOnShow: true,
      child: child,
    );
  }

  Widget _buildBlocListener(Widget? child) {
    return BlocListener<AppBloc, AppState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        switch (state.status) {
          case AppStatus.authenticated:
            _navigator.pushAndRemoveUntil<void>(
              HomePage.route(),
              (route) => false,
            );
            break;
          case AppStatus.unauthenticated:
            _navigator.pushAndRemoveUntil<void>(
              LoginPage.route(),
              (route) => false,
            );
            break;
          case AppStatus.initial:
            break;
        }
      },
      child: child,
    );
  }
}
