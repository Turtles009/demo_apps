import 'package:equatable/equatable.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

class ToggleTheme extends ThemeEvent {
  final bool isDarkMode;

  const ToggleTheme({required this.isDarkMode});

  @override
  List<Object> get props => [isDarkMode];
}
