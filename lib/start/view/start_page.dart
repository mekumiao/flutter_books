import 'package:booksapp/gen/assets.gen.dart';
import 'package:booksapp/login/login.dart';
import 'package:booksapp/start/cubit/start_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:general_data/general_data.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const StartPage());
  }

  static Page<void> page() {
    return const MaterialPage<void>(child: StartPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StartCubit(configurationRepository: context.read()),
      child: const StartView(),
    );
  }
}

class StartView extends StatelessWidget {
  const StartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFF6D93FF),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 19,
          vertical: 50,
        ),
        child: Center(
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
              Gaps.vGap50,
              Assets.images.splashCover.image(
                width: 168,
                height: 112,
              ),
              Gaps.vGap15,
              const Text(
                'Lorem ipsum dolor sit amet, consectetur adipis- cing elit. '
                'Morbi ac suscipit nibh, vel dignissim dui. '
                'Cras pulvinar velit ut rutrum vulputate. '
                'Cras posuere vitae purus sit amet feugiat.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gaps.vGap24,
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                width: double.infinity,
                height: 32,
                child: ElevatedButton(
                  onPressed: () {
                    context.read<StartCubit>().started();
                    Navigator.of(context).pushAndRemoveUntil(
                      LoginPage.route(),
                      (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF6D93FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Get Started',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
