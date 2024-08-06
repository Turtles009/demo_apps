import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/theme_bloc/theme_bloc.dart';
import '../bloc/theme_bloc/theme_event.dart';
import '../bloc/theme_bloc/theme_state.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        bool isDarkMode = state.themeMode == ThemeMode.dark;
        return Drawer(
          backgroundColor: state.themeMode == ThemeMode.dark
              ? const Color.fromARGB(255, 90, 90, 90)
              : const Color.fromARGB(255, 243, 241, 241),
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Color(0xff5e7cec),
                ),
                child: Center(
                    child: Text(
                  'Settings',
                  style: TextStyle(color: Colors.white),
                )),
              ),
              ListTile(
                title: Text(
                  'Dark Theme',
                  style: TextStyle(
                    color: state.themeMode == ThemeMode.dark
                        ? Colors.white
                        : const Color.fromARGB(255, 90, 90, 90),
                  ),
                ),
                trailing: Switch(
                  value: isDarkMode,
                  onChanged: (value) {
                    context
                        .read<ThemeBloc>()
                        .add(ToggleTheme(isDarkMode: value));
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
