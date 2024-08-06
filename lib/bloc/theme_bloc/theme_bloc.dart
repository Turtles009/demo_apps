import 'package:demo_app/bloc/theme_bloc/theme_event.dart';
import 'package:demo_app/bloc/theme_bloc/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(const ThemeState.empty()) {
    on<ToggleTheme>(
      (event, emit) {
        if (event.isDarkMode) {
          emit(
            const ThemeState(ThemeMode.dark),
          );
        } else {
          emit(
            const ThemeState(ThemeMode.light),
          );
        }
      },
    );
  }
}
