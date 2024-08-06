import 'package:demo_app/bloc/theme_bloc/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/theme_bloc/theme_bloc.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({
    super.key,
    required this.borderColor,
    required this.title,
    this.onTapHandler,
  });
  final Color borderColor;
  final String title;
  final VoidCallback? onTapHandler;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapHandler,
      child: Material(
        elevation: 12,
        shadowColor: Colors.black38,
        borderRadius: BorderRadius.circular(8),
        child: BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
          return Container(
            decoration: BoxDecoration(
              color: state.themeMode == ThemeMode.dark
                  ? Colors.grey.shade800
                  : Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border(
                left: BorderSide(
                  width: 4,
                  color: borderColor,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    constraints: const BoxConstraints(
                      maxHeight: 60,
                      maxWidth: 60,
                    ),
                    decoration: BoxDecoration(
                      color: borderColor,
                      borderRadius: BorderRadius.circular(12),
                      gradient: LinearGradient(
                        colors: [
                          borderColor,
                          borderColor.withOpacity(0.6),
                        ],
                        begin: const Alignment(1, 1),
                        end: const Alignment(0, -1),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 10,
                    children: [
                      Text(
                        title,
                        style: const TextStyle().copyWith(
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'Management',
                        style: const TextStyle().copyWith(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
