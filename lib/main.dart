import 'package:flutter/material.dart';
import 'package:map_tap/controllers/map_tap_controller.dart';
import 'package:map_tap/screens/home.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MapTapController>(
          create: (_) => MapTapController(),
        ),
      ],
      child: MaterialApp(
        title: 'Map Tap',
        theme: ThemeData(
          backgroundColor: const Color(0xFF333333),
          primarySwatch: Colors.grey,
          textTheme: GoogleFonts.poppinsTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
