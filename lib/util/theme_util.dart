import 'package:flutter/material.dart';

class ThemeUtil {
  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static ThemeData getThemeData({bool isDarkMode: false}) {
    return ThemeData(
        buttonTheme:
            ButtonThemeData(buttonColor: isDarkMode ? Colors.white : Colours.dark_bg_color),
        iconTheme: IconThemeData(color: isDarkMode ? Colors.white : Colours.dark_bg_color),
        primaryIconTheme: IconThemeData(color: isDarkMode ? Colours.dark_red : Colours.red),
        errorColor: isDarkMode ? Colours.dark_red : Colours.red,
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
        primaryColor: isDarkMode ? Colours.dark_app_main : Colours.app_main,
        // Tab指示器颜色
        indicatorColor: isDarkMode ? Colours.dark_app_main : Colours.app_main,
        // 页面背景色
        scaffoldBackgroundColor: isDarkMode ? Colours.dark_bg_color : Colors.white,
        // 主要用于Material背景色
        canvasColor: isDarkMode ? Colours.dark_material_bg : Colors.white,
        textTheme: TextTheme(
          displayLarge: isDarkMode ? TextStyles.textDark : TextStyles.text,
          displayMedium: isDarkMode ? TextStyles.textDark : TextStyles.text,
          displaySmall: isDarkMode ? TextStyles.textDark : TextStyles.text,
          headlineMedium: isDarkMode ? TextStyles.textDark : TextStyles.text,
          headlineSmall: isDarkMode ? TextStyles.textDark : TextStyles.text,
          titleLarge: isDarkMode ? TextStyles.textDark : TextStyles.text,
          titleMedium: isDarkMode ? TextStyles.textDark : TextStyles.text,
          titleSmall: isDarkMode ? TextStyles.textDark : TextStyles.text,
          bodyLarge: isDarkMode ? TextStyles.textDark : TextStyles.text,
          bodyMedium: isDarkMode ? TextStyles.textDark : TextStyles.text,
          bodySmall: isDarkMode ? TextStyles.textDark : TextStyles.text,
          labelLarge: isDarkMode ? TextStyles.textDark : TextStyles.text,
          labelSmall: isDarkMode ? TextStyles.textDark : TextStyles.text,
          labelMedium: isDarkMode ? TextStyles.textDark : TextStyles.text,
        ),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: isDarkMode ? TextStyles.textWhite14 : TextStyles.textDarkGray14,
        ),
        appBarTheme: AppBarTheme(
            titleTextStyle: isDarkMode ? TextStyles.textDark : TextStyles.text,
            //
            shadowColor: isDarkMode ? Colors.white10 : Colors.white70,
            elevation: 0.4,
            scrolledUnderElevation: 0.4,
            backgroundColor: isDarkMode ? Colours.dark_app_main : Colours.app_main,
            iconTheme: IconThemeData(
                color: isDarkMode ? Colours.bg_color : Colours.dark_bg_color, size: 28),
            foregroundColor: isDarkMode ? Colors.white : Colours.dark_bg_color,
            actionsIconTheme: isDarkMode
                ? const IconThemeData(color: Colours.bg_color)
                : const IconThemeData(color: Colours.dark_bg_color)),
        cardTheme: CardTheme(
            color: isDarkMode ? Colours.dark_bg_color : Colors.white,
            shadowColor: isDarkMode ? Colours.bg_color : Colors.white),
        dividerTheme: DividerThemeData(
            color: isDarkMode ? Colours.dark_line : Colours.line, space: 0.6, thickness: 0.6),
        textSelectionTheme: TextSelectionThemeData(
          selectionColor: Colours.app_main.withAlpha(70),
          selectionHandleColor: Colours.app_main,
        ));
  }
}

class Colours {
  // static const Color app_main = Colors.redAccent;
  static const Color app_main = Colors.white;
  static const Color dark_app_main = Color(0xFF1B1B24);

  static const Color bg_color = Color(0xfff1f1f1);
  static const Color dark_bg_color = Color(0xFF1B1B24);

  static const Color material_bg = Color(0xFFFFFFFF);
  static const Color dark_material_bg = Color(0xFF303233);

  static const Color text = Color(0xFF333333);
  static const Color dark_text = Color(0xFFB8B8B8);

  static const Color text_gray = Color(0xFF999999);
  static const Color dark_text_gray = Color(0xFF666666);

  static const Color text_gray_c = Color(0xFFcccccc);
  static const Color dark_button_text = Color(0xFFF2F2F2);

  static const Color bg_gray = Color(0xFFF6F6F6);
  static const Color dark_bg_gray = Color(0xFF1F1F1F);

  static const Color line = Color(0xFFEEEEEE);
  static const Color dark_line = Color(0xFF3A3C3D);

  static const Color red = Color(0xFFFF4759);
  static const Color dark_red = Color(0xFFE03E4E);

  static const Color text_disabled = Color(0xFFD4E2FA);
  static const Color dark_text_disabled = Color(0xFFCEDBF2);

  static const Color button_disabled = Color(0xFF96BBFA);
  static const Color dark_button_disabled = Color(0xFF83A5E0);

  static const Color unselected_item_color = Color(0xffbfbfbf);
  static const Color dark_unselected_item_color = Color(0xFF4D4D4D);

  static const Color bg_gray_ = Color(0xFFFAFAFA);
  static const Color dark_bg_gray_ = Color(0xFF242526);

  static const Color gradient_blue = Color(0xFF5793FA);
  static const Color shadow_blue = Color(0x805793FA);
  static const Color orange = Color(0xFFFF8547);
}

class TextStyles {
  static const TextStyle textSize12 = TextStyle(
    fontSize: Dimens.font_sp12,
  );
  static const TextStyle textSize16 = TextStyle(
    fontSize: Dimens.font_sp16,
  );
  static const TextStyle textBold14 =
      TextStyle(fontSize: Dimens.font_sp14, fontWeight: FontWeight.bold);
  static const TextStyle textBold16 =
      TextStyle(fontSize: Dimens.font_sp16, fontWeight: FontWeight.bold);
  static const TextStyle textBold18 =
      TextStyle(fontSize: Dimens.font_sp18, fontWeight: FontWeight.bold);
  static const TextStyle textBold24 = TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold);
  static const TextStyle textBold26 = TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold);

  static const TextStyle textGray14 = TextStyle(
    fontSize: Dimens.font_sp14,
    color: Colours.text_gray,
  );
  static const TextStyle textDarkGray14 = TextStyle(
    fontSize: Dimens.font_sp14,
    color: Colours.dark_text_gray,
  );

  static const TextStyle textWhite14 = TextStyle(
    fontSize: Dimens.font_sp14,
    color: Colors.white,
  );

  static const TextStyle text = TextStyle(
      fontSize: Dimens.font_sp14,
      color: Colours.text,
      // https://github.com/flutter/flutter/issues/40248
      textBaseline: TextBaseline.alphabetic);
  static const TextStyle textDark = TextStyle(
      fontSize: Dimens.font_sp14, color: Colours.dark_text, textBaseline: TextBaseline.alphabetic);

  static const TextStyle textGray12 = TextStyle(
      fontSize: Dimens.font_sp12, color: Colours.text_gray, fontWeight: FontWeight.normal);

  static const TextStyle textDarkGray12 = TextStyle(
      fontSize: Dimens.font_sp12, color: Colours.dark_text_gray, fontWeight: FontWeight.normal);

  static const TextStyle textHint14 = TextStyle(fontSize: Dimens.font_sp14, color: Colours.text);
}

class Dimens {
  static const double font_sp10 = 10.0;
  static const double font_sp12 = 12.0;
  static const double font_sp14 = 14.0;
  static const double font_sp15 = 15.0;
  static const double font_sp16 = 16.0;
  static const double font_sp18 = 18.0;

  static const double gap_dp4 = 4;
  static const double gap_dp5 = 5;
  static const double gap_dp8 = 8;
  static const double gap_dp10 = 10;
  static const double gap_dp12 = 12;
  static const double gap_dp15 = 15;
  static const double gap_dp16 = 16;
  static const double gap_dp24 = 24;
  static const double gap_dp32 = 32;
  static const double gap_dp50 = 50;
}
