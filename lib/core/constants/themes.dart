import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData( 
  brightness: Brightness. light, 
  colorScheme: ColorScheme.light( 
    surface: Colors.grey.shade400, 
    primary: Colors.grey.shade300, 
    secondary: Colors.grey.shade200,
  ),
 );
ThemeData darkMode = ThemeData( 
  brightness: Brightness.dark, 
  colorScheme: ColorScheme.dark(
    surface: Colors.grey.shade900, 
    primary: Colors.grey.shade800, 
    secondary: Colors.grey.shade700, 
  ),
); 

extension ThemeExt on BuildContext {
  TextTheme get text => Theme.of(this).textTheme;
  ColorScheme get color => Theme.of(this).colorScheme;
}