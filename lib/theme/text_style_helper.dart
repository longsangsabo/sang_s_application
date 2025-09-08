import 'package:flutter/material.dart';
import '../core/app_export.dart';

/// A helper class for managing text styles in the application
class TextStyleHelper {
  static TextStyleHelper? _instance;

  TextStyleHelper._();

  static TextStyleHelper get instance {
    _instance ??= TextStyleHelper._();
    return _instance!;
  }

  // Display Styles
  // Large text styles typically used for headers and hero elements

  TextStyle get display40BlackAlumniSans => TextStyle(
        fontSize: 40.fSize,
        fontWeight: FontWeight.w900,
        fontFamily: 'Alumni Sans',
      );

  // Headline Styles
  // Medium-large text styles for section headers

  TextStyle get headline28SemiBoldRoboto => TextStyle(
        fontSize: 28.fSize,
        fontWeight: FontWeight.w600,
        fontFamily: 'Roboto',
        color: appTheme.indigo_900,
      );

  TextStyle get headline24BlackInter => TextStyle(
        fontSize: 24.fSize,
        fontWeight: FontWeight.w900,
        fontFamily: 'Inter',
        color: appTheme.whiteCustom,
      );

  // Title Styles
  // Medium text styles for titles and subtitles

  TextStyle get title20RegularRoboto => TextStyle(
        fontSize: 20.fSize,
        fontWeight: FontWeight.w400,
        fontFamily: 'Roboto',
      );

  TextStyle get title20RegularAldrich => TextStyle(
        fontSize: 20.fSize,
        fontWeight: FontWeight.w400,
        fontFamily: 'Aldrich',
        color: appTheme.whiteCustom,
      );

  TextStyle get title17RegularABeeZee => TextStyle(
        fontSize: 17.fSize,
        fontWeight: FontWeight.w400,
        fontFamily: 'ABeeZee',
        color: appTheme.whiteCustom,
      );

  TextStyle get title16BoldLexendExa => TextStyle(
        fontSize: 16.fSize,
        fontWeight: FontWeight.w700,
        fontFamily: 'Lexend Exa',
      );

  TextStyle get title16 => TextStyle(
        fontSize: 16.fSize,
        color: appTheme.whiteCustom,
      );

  // Body Styles
  // Standard text styles for body content

  TextStyle get body15RegularABeeZee => TextStyle(
        fontSize: 15.fSize,
        fontWeight: FontWeight.w400,
        fontFamily: 'ABeeZee',
        color: appTheme.whiteCustom,
      );

  TextStyle get body14RegularABeeZee => TextStyle(
        fontSize: 14.fSize,
        fontWeight: FontWeight.w400,
        fontFamily: 'ABeeZee',
        color: appTheme.whiteCustom,
      );

  TextStyle get body13RegularABeeZee => TextStyle(
        fontSize: 13.fSize,
        fontWeight: FontWeight.w400,
        fontFamily: 'ABeeZee',
        color: appTheme.whiteCustom,
      );

  // Label Styles
  // Small text styles for labels, captions, and hints

  TextStyle get label10Regular => TextStyle(
        fontSize: 10.fSize,
        fontWeight: FontWeight.w400,
      );

  TextStyle get label8RegularABeeZee => TextStyle(
        fontSize: 8.fSize,
        fontWeight: FontWeight.w400,
        fontFamily: 'ABeeZee',
        color: appTheme.black_900,
      );

  // Other Styles
  // Miscellaneous text styles without specified font size

  TextStyle get bodyTextABeeZee => TextStyle(
        fontFamily: 'ABeeZee',
      );
}
