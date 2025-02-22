import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

// Holds the state of current theme
class ThemeState extends Equatable {
  final ThemeMode themeMode;

  const ThemeState(this.themeMode);

  const ThemeState.empty() : themeMode = ThemeMode.light;

  @override
  List<Object> get props => [themeMode];
}
