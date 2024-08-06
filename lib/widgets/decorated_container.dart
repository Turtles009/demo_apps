import 'package:demo_app/bloc/theme_bloc/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/theme_bloc/theme_bloc.dart';

class DecoratedContainer extends StatelessWidget {
  const DecoratedContainer({
    super.key,
    required this.titleRow,
    required this.child,
  });

  final Row titleRow;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      shadowColor: Colors.black26,
      borderRadius: const BorderRadius.all(
        Radius.circular(24),
      ),
      child: BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(24),
            ),
            color: state.themeMode == ThemeMode.dark
                ? Colors.grey.shade800
                : const Color.fromARGB(255, 248, 248, 248),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 16.0,
                ),
                child: titleRow,
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(24),
                    ),
                    color: state.themeMode == ThemeMode.dark
                        ? Colors.grey.shade900
                        : Colors.white,
                  ),
                  child: child,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
