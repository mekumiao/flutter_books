import 'package:booksapp/app/app.dart';
import 'package:booksapp/splash/cubit/splash_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:general_data/general_data.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const SplashPage());
  }

  static Page<void> page() {
    return const MaterialPage<void>(child: SplashPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit(
        configurationRepository: context.read(),
      )..startCountdown(),
      child: const SplashView(),
    );
  }
}

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listenWhen: (previous, current) => current is SplashCompleted,
      listener: (context, state) {
        context.read<AppBloc>().add(AutoAuthorized());
      },
      child: _buildMaterial(),
    );
  }

  Widget _buildMaterial() {
    return Material(
      color: Colors.blue.shade300,
      child: Column(
        children: const [
          Align(
            alignment: Alignment.topRight,
            child: _Timer(),
          ),
          Center(
            child: Icon(Icons.category_outlined),
          )
        ],
      ),
    );
  }
}

class _Timer extends StatelessWidget {
  const _Timer();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SplashCubit, SplashState>(
      builder: (context, state) {
        return state is SplashInProcess
            ? Text('${state.seconds} s')
            : Gaps.empty;
      },
    );
  }
}
