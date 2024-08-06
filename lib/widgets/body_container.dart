import 'package:demo_app/bloc/theme_bloc/theme_bloc.dart';
import 'package:demo_app/bloc/theme_bloc/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BodyContainer extends StatelessWidget {
  const BodyContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
      return Column(
        children: [
          const SizedBox(
            height: 24,
          ),
          Expanded(
            child: Container(
              width: MediaQuery.sizeOf(context).width,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
                color: state.themeMode == ThemeMode.dark
                    ? const Color.fromARGB(255, 90, 90, 90)
                    : const Color.fromARGB(255, 243, 241, 241),
              ),
              child: child,
            ),
          ),
        ],
      );
    });
  }
}
