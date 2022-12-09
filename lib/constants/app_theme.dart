import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MapTapTheme {
  MapTapTheme._();

  // Colors
  static const Color notWhite = Color(0xFFFAFAFA);
  static const Color yellow = Color(0xFFEFB300);
  static const Color lightYellow = Color(0xFFFBF0D1);
  static const Color darkGrey = Color(0xFF262626);
  static const Color grey = Color(0xFF909090);
  static const Color lightGrey = Color(0xFFF0F0F0);
  static const Color bgBlack = Color(0xFF141414);

  // Typography
  static TextStyle heading = const TextStyle(fontSize: 20, letterSpacing: .27, fontWeight: FontWeight.w600, color: MapTapTheme.darkGrey);

  static TextStyle paragraph = const TextStyle(fontSize: 12, letterSpacing: .27, color: MapTapTheme.grey);

  static TextStyle btnText = GoogleFonts.poppins(
    textStyle: const TextStyle(color: Colors.white, fontSize: 14, letterSpacing: .5),
  );

  static TextStyle whiteInfoText = GoogleFonts.poppins(
    textStyle: const TextStyle(color: Colors.white, fontSize: 13, letterSpacing: .5),
  );

  static TextStyle greyInfoText = GoogleFonts.poppins(
    textStyle: const TextStyle(color: MapTapTheme.grey, fontSize: 13, letterSpacing: .5),
  );

  // Widget Decorations
  static ButtonStyle darkBtnStyle = ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ), backgroundColor: MapTapTheme.darkGrey,
    shadowColor: MapTapTheme.darkGrey.withOpacity(0.5),
    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
  );
}

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> mapTapSnackBar(
    BuildContext context, String text, bool isError) {
  return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text), backgroundColor: isError ? Colors.red : Colors.green));
}
