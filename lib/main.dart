import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:since/costants/app_colors.dart';
import 'package:since/moduels/since/v_since_list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle defaultTextStyle = GoogleFonts.poppins(color: AppColors.white, fontSize: 16, fontWeight: FontWeight.w600);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Since',
      theme: ThemeData(
        primarySwatch: MaterialColor(Colors.white.value, const {
          050: Color.fromRGBO(29, 44, 77, .1),
          100: Color.fromRGBO(29, 44, 77, .2),
          200: Color.fromRGBO(29, 44, 77, .3),
          300: Color.fromRGBO(29, 44, 77, .4),
          400: Color.fromRGBO(29, 44, 77, .5),
          500: Color.fromRGBO(29, 44, 77, .6),
          600: Color.fromRGBO(29, 44, 77, .7),
          700: Color.fromRGBO(29, 44, 77, .8),
          800: Color.fromRGBO(29, 44, 77, .9),
          900: Color.fromRGBO(29, 44, 77, 1),
        }),
        useMaterial3: true,
        textTheme: TextTheme(
          bodyMedium: defaultTextStyle,
          titleMedium: defaultTextStyle,
          labelLarge: defaultTextStyle,
          bodyLarge: defaultTextStyle,
          bodySmall: defaultTextStyle,
          titleLarge: defaultTextStyle,
          titleSmall: defaultTextStyle,
        ),
      ),
      home: const SinceListPage()
    );
  }
}
