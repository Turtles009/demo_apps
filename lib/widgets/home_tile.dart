import 'package:demo_app/bloc/theme_bloc/theme_bloc.dart';
import 'package:demo_app/bloc/theme_bloc/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeTile extends StatelessWidget {
  const HomeTile({
    super.key,
    required this.title,
    required this.tileColor,
    required this.icon,
  });

  final Color tileColor;
  final String title;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 8,
      shadowColor: Colors.black38,
      borderRadius: BorderRadius.circular(4),
      child: BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 16.0,
          ),
          decoration: BoxDecoration(
            color: state.themeMode == ThemeMode.dark
                ? Colors.grey.shade800
                : Colors.white,
            borderRadius: BorderRadius.circular(4),
            border: Border(
              left: BorderSide(
                width: 4,
                color: tileColor,
              ),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                children: [
                  icon,
                  const SizedBox(width: 12),
                  Text(
                    title,
                    style: const TextStyle().copyWith(fontSize: 16),
                  ),
                ],
              ),
              const Spacer(),
              IconButton(
                visualDensity: const VisualDensity(vertical: -4),
                onPressed: () {},
                icon: const Icon(Icons.arrow_forward_ios_rounded),
              )
            ],
          ),
        );
      }),
    );
  }
}
