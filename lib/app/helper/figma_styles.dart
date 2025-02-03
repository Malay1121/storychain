// ignore_for_file: overridden_fields, unused_element, non_constant_identifier_names

/// The all getter and classes with variables and functions statics:
/// [Styles], [Shadows], [ColorStyle], [FigmaTheme]
///
///
/// Text Style Documents:
/// * [TextStyle] are represented in an class called [Style].
/// * To access all [Style] statically, you can just access them using the [Styles] class.
/// * To color a [Style], just use the .tint([Color]) function.
/// * [Style] may or may not have figma variables depending on the design in figma
/// * The attributes exported from figma are [fontFamily], [fontSize], [decoration], [fontStyle], [fontWeight], [height], [letterSpacing]
///
/// Shadow Documents:
/// * ONLY support DROP_SHADOW and INNER_SHADOW.
/// * [BoxShadow] are represented in an class called [Shadow].
/// * To access all [Shadow] statically, you can just access them using the [Shadows}] class.
/// * Shadows may or may not have figma variables depending on the design in figma
/// * The attributes exported from figma are [color], [offset], [blurRadius], [spreadRadius], [blurStyle]
///
/// Color Styles Documents:
/// * Support SOLID COLOR and GRADIENT LINEAR and GRADIENT RADIAL.
/// * To access all [Color] statically, you can just access them using the [ColorStyle}] class.
/// * Colors may or may not have figma variables depending on the design in figma
///
/// *IMPORTANT*: You need a [FigmaTheme] on top of your Material so that colors, sizes, strings, booleans are rebuilt when changed.
///
/// ```dart
///  class MyApp extends StatelessWidget {
///    const MyApp({super.key});
///
///    @override
///    Widget build(BuildContext context) {
///      return const FigmaTheme(
///        child: MaterialApp(
///          title: 'Figma Demo',
///          home: MyHomePage(title: 'Figma Demo Home Page'),
///        ),
///      );
///    }
///  }
/// ```
///
///
library figma_theme;

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:storychain/app/helper/all_imports.dart';
import 'package:storychain/app/helper/all_imports.dart';
import 'package:storychain/app/helper/all_imports.dart';
import 'package:storychain/app/helper/all_imports.dart';
import 'package:storychain/app/helper/all_imports.dart';
import 'package:storychain/app/helper/all_imports.dart';
import 'package:storychain/app/helper/all_imports.dart';
import 'package:storychain/app/helper/all_imports.dart';
import 'package:storychain/app/helper/all_imports.dart';
import 'package:storychain/app/helper/all_imports.dart';
import 'package:storychain/app/helper/all_imports.dart';
import 'package:storychain/app/helper/all_imports.dart';
import 'package:storychain/app/helper/all_imports.dart';
import 'package:storychain/app/helper/all_imports.dart';
import 'package:storychain/app/helper/all_imports.dart';
import 'package:storychain/app/helper/all_imports.dart';
import 'package:storychain/app/helper/all_imports.dart';
import 'package:storychain/app/helper/all_imports.dart';
import 'package:storychain/app/helper/all_imports.dart';
import 'package:storychain/app/helper/all_imports.dart';
import 'package:storychain/app/helper/all_imports.dart';
import 'package:storychain/app/helper/all_imports.dart';
import 'package:storychain/app/helper/all_imports.dart';
import 'package:storychain/app/helper/all_imports.dart';
import 'package:storychain/app/helper/all_imports.dart';
import 'package:storychain/app/helper/all_imports.dart';

class FigmaTheme extends StatefulWidget {
  final Widget child;
  final Duration duration;
  const FigmaTheme({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 300),
  });

  @override
  State<FigmaTheme> createState() => _FigmaThemeState();
}

class _FigmaThemeState extends State<FigmaTheme> with TickerProviderStateMixin {
  void _rebuildAllChildren(BuildContext context) {
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }

    (context as Element).visitChildren(rebuild);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge([]),
      builder: (context, _) {
        _rebuildAllChildren(context);
        return widget.child;
      },
    );
  }
}

class ColorStyle {
  ColorStyle._();

  static final primary500 = const Color.fromARGB(255, 18, 102, 241);
  static final primary400 = const Color.fromARGB(255, 66, 133, 244);
  static final primary300 = const Color.fromARGB(255, 114, 164, 247);
  static final primary200 = const Color.fromARGB(255, 162, 195, 250);
  static final primary100 = const Color.fromARGB(255, 211, 226, 252);
  static final secondary500 = const Color(0xFFf19c12);
  static final secondary400 = const Color(0xFFF4B042);
  static final secondary300 = const Color(0xFFF7C472);
  static final secondary200 = const Color(0xFFFAD8A2);
  static final secondary100 = const Color(0xFFFCECD3);
  static final alertsStatusSuccess = const Color.fromARGB(255, 74, 222, 128);
  static final alertsStatusInfo = const Color.fromARGB(255, 36, 107, 253);
  static final alertsStatusWarning = const Color.fromARGB(255, 250, 204, 21);
  static final alertsStatusError = const Color.fromARGB(255, 247, 85, 85);
  static final alertsStatusDisabled = const Color.fromARGB(255, 216, 216, 216);
  static final alertsStatusButtonDisabled =
      const Color.fromARGB(255, 15, 86, 204);
  static final greyscale900 = const Color.fromARGB(255, 33, 33, 33);
  static final greyscale800 = const Color.fromARGB(255, 66, 66, 66);
  static final greyscale700 = const Color.fromARGB(255, 97, 97, 97);
  static final greyscale600 = const Color.fromARGB(255, 117, 117, 117);
  static final greyscale500 = const Color.fromARGB(255, 158, 158, 158);
  static final greyscale400 = const Color.fromARGB(255, 189, 189, 189);
  static final greyscale300 = const Color.fromARGB(255, 224, 224, 224);
  static final greyscale200 = const Color.fromARGB(255, 238, 238, 238);
  static final greyscale100 = const Color.fromARGB(255, 245, 245, 245);
  static final greyscale50 = const Color.fromARGB(255, 250, 250, 250);
  static final gradientsGradientRed = LinearGradient(
    transform: GradientRotation(4.994608720432173),
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0, 1],
    colors: [
      const Color.fromARGB(255, 66, 133, 244),
      const Color.fromARGB(255, 162, 195, 250)
    ],
  );
  static final gradientsGradientPurple = LinearGradient(
    transform: GradientRotation(4.994608720432173),
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0, 1],
    colors: [
      const Color.fromARGB(255, 114, 16, 255),
      const Color.fromARGB(255, 157, 89, 255)
    ],
  );
  static final gradientsGradientYellow = LinearGradient(
    transform: GradientRotation(4.994608720432173),
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0, 1],
    colors: [
      const Color.fromARGB(255, 250, 204, 21),
      const Color.fromARGB(255, 255, 229, 128)
    ],
  );
  static final gradientsGradientBlue = LinearGradient(
    transform: GradientRotation(4.994608720432173),
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0, 1],
    colors: [
      const Color.fromARGB(255, 51, 94, 247),
      const Color.fromARGB(255, 95, 130, 255)
    ],
  );
  static final gradientsGradientGreen = LinearGradient(
    transform: GradientRotation(4.994608720432173),
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0, 1],
    colors: [
      const Color.fromARGB(255, 34, 187, 156),
      const Color.fromARGB(255, 53, 222, 188)
    ],
  );
  static final gradientsGradidentOrange = LinearGradient(
    transform: GradientRotation(4.994608720432173),
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0, 1],
    colors: [
      const Color.fromARGB(255, 251, 148, 0),
      const Color.fromARGB(255, 255, 171, 56)
    ],
  );
  static final othersWhite = const Color.fromARGB(255, 255, 255, 255);
  static final othersBlack = const Color.fromARGB(255, 0, 0, 0);
  static final othersRed = const Color.fromARGB(255, 245, 67, 54);
  static final othersPink = const Color.fromARGB(255, 234, 30, 97);
  static final othersPurple = const Color.fromARGB(255, 157, 40, 172);
  static final othersDeepPurple = const Color.fromARGB(255, 103, 58, 179);
  static final othersIndigo = const Color.fromARGB(255, 63, 81, 178);
  static final othersBlue = const Color.fromARGB(255, 26, 150, 240);
  static final othersLightBlue = const Color.fromARGB(255, 0, 169, 241);
  static final othersCyan = const Color.fromARGB(255, 0, 188, 211);
  static final othersTeal = const Color.fromARGB(255, 0, 150, 137);
  static final othersGreen = const Color.fromARGB(255, 74, 175, 87);
  static final othersLightGreen = const Color.fromARGB(255, 139, 194, 85);
  static final othersLime = const Color.fromARGB(255, 205, 220, 76);
  static final othersYellow = const Color.fromARGB(255, 255, 235, 79);
  static final othersAmber = const Color.fromARGB(255, 255, 192, 45);
  static final othersOrange = const Color.fromARGB(255, 255, 152, 31);
  static final othersDeepOrange = const Color.fromARGB(255, 255, 87, 38);
  static final othersBrown = const Color.fromARGB(255, 122, 85, 72);
  static final othersBlueGrey = const Color.fromARGB(255, 96, 125, 138);
  static final darkDark1 = const Color.fromARGB(255, 24, 26, 32);
  static final darkDark2 = const Color.fromARGB(255, 31, 34, 42);
  static final darkDark3 = const Color.fromARGB(255, 53, 56, 63);
  static final backgroundRed = const Color.fromARGB(255, 255, 241, 243);
  static final backgroundPurple = const Color.fromARGB(255, 244, 236, 255);
  static final backgroundBlue = const Color.fromARGB(255, 246, 250, 253);
  static final backgroundGreen = const Color.fromARGB(255, 242, 255, 252);
  static final backgroundOrange = const Color.fromARGB(255, 255, 248, 237);
  static final backgroundPink = const Color.fromARGB(255, 255, 245, 245);
  static final backgroundYellow = const Color.fromARGB(255, 255, 254, 224);
  static final transparentRed = const Color.fromARGB(20, 255, 77, 103);
  static final transparentPurple = const Color.fromARGB(20, 114, 16, 255);
  static final transparentBlue = const Color.fromARGB(20, 51, 94, 247);
  static final transparentOrange = const Color.fromARGB(20, 255, 152, 0);
  static final transparentYellow = const Color.fromARGB(20, 250, 204, 21);
  static final transparentGreen = const Color.fromARGB(20, 76, 175, 80);
  static final transparentCyan = const Color.fromARGB(20, 0, 188, 212);
}

class Style extends TextStyle {
  const Style._({
    super.inherit = true,
    super.color,
    super.backgroundColor,
    super.fontSize,
    super.fontWeight,
    super.fontStyle,
    super.letterSpacing,
    super.wordSpacing,
    super.textBaseline,
    super.height,
    super.leadingDistribution,
    super.locale,
    super.foreground,
    super.background,
    super.shadows,
    super.fontFeatures,
    super.fontVariations,
    super.decoration,
    super.decorationColor,
    super.decorationStyle,
    super.decorationThickness,
    super.debugLabel,
    super.fontFamilyFallback,
    super.overflow,
    super.fontFamily,
  });

  Style tint(Color? color) => Style._style(copyWith(color: color));

  static FontWeight _parseVariableWeight(double parse) {
    if (parse <= 100) {
      return FontWeight.w100;
    } else if (parse <= 200) {
      return FontWeight.w200;
    } else if (parse <= 300) {
      return FontWeight.w300;
    } else if (parse <= 400) {
      return FontWeight.w400;
    } else if (parse <= 500) {
      return FontWeight.w500;
    } else if (parse <= 600) {
      return FontWeight.w600;
    } else if (parse <= 700) {
      return FontWeight.w700;
    } else if (parse <= 800) {
      return FontWeight.w800;
    } else {
      return FontWeight.w900;
    }
  }

  static FontStyle _parseStringStyle(String parse) {
    return parse.contains("italic") ? FontStyle.italic : FontStyle.normal;
  }

  factory Style._style(TextStyle textStyle) {
    return Style._(
      inherit: textStyle.inherit,
      color: textStyle.color,
      backgroundColor: textStyle.backgroundColor,
      fontSize: textStyle.fontSize,
      fontWeight: textStyle.fontWeight,
      fontStyle: textStyle.fontStyle,
      letterSpacing: textStyle.letterSpacing,
      wordSpacing: textStyle.wordSpacing,
      textBaseline: textStyle.textBaseline,
      height: textStyle.height,
      leadingDistribution: textStyle.leadingDistribution,
      locale: textStyle.locale,
      foreground: textStyle.foreground,
      background: textStyle.background,
      shadows: textStyle.shadows,
      fontFeatures: textStyle.fontFeatures,
      fontVariations: textStyle.fontVariations,
      decoration: textStyle.decoration,
      decorationColor: textStyle.decorationColor,
      decorationStyle: textStyle.decorationStyle,
      decorationThickness: textStyle.decorationThickness,
      debugLabel: textStyle.debugLabel,
      fontFamily: textStyle.fontFamily,
      fontFamilyFallback: textStyle.fontFamilyFallback,
      overflow: textStyle.overflow,
    );
  }
}

class Styles {
  const Styles._();

  static const _parent = TextStyle(
    debugLabel: '',
    leadingDistribution: TextLeadingDistribution.even,
  );

  static TextStyle _style(TextStyle baseStyle, {Color? color}) {
    return baseStyle.copyWith(color: color);
  }

  static TextStyle h1Bold({Color? color}) => _style(
        _parent.copyWith(
          fontFamily: "Urbanist",
          fontSize: 48.t(Get.context!),
          decoration: TextDecoration.none,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w700,
          height: 1.2000000476837158,
          letterSpacing: 0,
        ),
        color: color,
      );

  static TextStyle h2Bold({Color? color}) => _style(
        _parent.copyWith(
          fontFamily: "Urbanist",
          fontSize: 40.t(Get.context!),
          decoration: TextDecoration.none,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w700,
          height: 1.2000000476837158,
          letterSpacing: 0,
        ),
        color: color,
      );

  static TextStyle h3Bold({Color? color}) => _style(
        _parent.copyWith(
          fontFamily: "Urbanist",
          fontSize: 32.t(Get.context!),
          decoration: TextDecoration.none,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w700,
          height: 1.2000000476837158,
          letterSpacing: 0,
        ),
        color: color,
      );

  static TextStyle h4Bold({Color? color}) => _style(
        _parent.copyWith(
          fontFamily: "Urbanist",
          fontSize: 24.t(Get.context!),
          decoration: TextDecoration.none,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w700,
          height: 1.2000000476837158,
          letterSpacing: 0,
        ),
        color: color,
      );

  static TextStyle h5Bold({Color? color}) => _style(
        _parent.copyWith(
          fontFamily: "Urbanist",
          fontSize: 20.t(Get.context!),
          decoration: TextDecoration.none,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w700,
          height: 1.2000000476837158,
          letterSpacing: 0,
        ),
        color: color,
      );

  static TextStyle h6Bold({Color? color}) => _style(
        _parent.copyWith(
          fontFamily: "Urbanist",
          fontSize: 18.t(Get.context!),
          decoration: TextDecoration.none,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w700,
          height: 1.2000000476837158,
          letterSpacing: 0,
        ),
        color: color,
      );

  // Body Styles
  static TextStyle bodyXlargeRegular({Color? color}) => _style(
        _parent.copyWith(
          fontFamily: "Urbanist",
          fontSize: 18.t(Get.context!),
          decoration: TextDecoration.none,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w400,
          height: 1.399999976158142,
          letterSpacing: 0.20000000298023224,
        ),
        color: color,
      );

  static TextStyle bodyXlargeSemibold({Color? color}) => _style(
        _parent.copyWith(
          fontFamily: "Urbanist",
          fontSize: 18.t(Get.context!),
          decoration: TextDecoration.none,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w700,
          height: 1.399999976158142,
          letterSpacing: 0.20000000298023224,
        ),
        color: color,
      );

  static TextStyle bodyXlargeBold({Color? color}) => _style(
        _parent.copyWith(
          fontFamily: "Urbanist",
          fontSize: 18.t(Get.context!),
          decoration: TextDecoration.none,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w700,
          height: 1.399999976158142,
          letterSpacing: 0.20000000298023224,
        ),
        color: color,
      );

  static TextStyle bodyXlargeMedium({Color? color}) => _style(
        _parent.copyWith(
          fontFamily: "Urbanist",
          fontSize: 18.t(Get.context!),
          decoration: TextDecoration.none,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w500,
          height: 1.399999976158142,
          letterSpacing: 0.20000000298023224,
        ),
        color: color,
      );

  static TextStyle bodyLargeRegular({Color? color}) => _style(
        _parent.copyWith(
          fontFamily: "Urbanist",
          fontSize: 16.t(Get.context!),
          decoration: TextDecoration.none,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w400,
          height: 1.399999976158142,
          letterSpacing: 0.20000000298023224,
        ),
        color: color,
      );

  static TextStyle bodyLargeSemibold({Color? color}) => _style(
        _parent.copyWith(
          fontFamily: "Urbanist",
          fontSize: 16.t(Get.context!),
          decoration: TextDecoration.none,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w700,
          height: 1.399999976158142,
          letterSpacing: 0.20000000298023224,
        ),
        color: color,
      );

  static TextStyle bodyLargeBold({Color? color}) => _style(
        _parent.copyWith(
          fontFamily: "Urbanist",
          fontSize: 16.t(Get.context!),
          decoration: TextDecoration.none,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w700,
          height: 1.399999976158142,
          letterSpacing: 0.20000000298023224,
        ),
        color: color,
      );

  static TextStyle bodyLargeMedium({Color? color}) => _style(
        _parent.copyWith(
          fontFamily: "Urbanist",
          fontSize: 16.t(Get.context!),
          decoration: TextDecoration.none,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w500,
          height: 1.399999976158142,
          letterSpacing: 0.20000000298023224,
        ),
        color: color,
      );

  static TextStyle bodyMediumRegular({Color? color}) => _style(
        _parent.copyWith(
          fontFamily: "Urbanist",
          fontSize: 14.t(Get.context!),
          decoration: TextDecoration.none,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w400,
          height: 1.399999976158142,
          letterSpacing: 0.20000000298023224,
        ),
        color: color,
      );

  static TextStyle bodyMediumSemibold({Color? color}) => _style(
        _parent.copyWith(
          fontFamily: "Urbanist",
          fontSize: 14.t(Get.context!),
          decoration: TextDecoration.none,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w700,
          height: 1.399999976158142,
          letterSpacing: 0.20000000298023224,
        ),
        color: color,
      );

  static TextStyle bodyMediumBold({Color? color}) => _style(
        _parent.copyWith(
          fontFamily: "Urbanist",
          fontSize: 14.t(Get.context!),
          decoration: TextDecoration.none,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w700,
          height: 1.399999976158142,
          letterSpacing: 0.20000000298023224,
        ),
        color: color,
      );

  static TextStyle bodyMediumMedium({Color? color}) => _style(
        _parent.copyWith(
          fontFamily: "Urbanist",
          fontSize: 14.t(Get.context!),
          decoration: TextDecoration.none,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w500,
          height: 1.399999976158142,
          letterSpacing: 0.20000000298023224,
        ),
        color: color,
      );

  static TextStyle bodySmallRegular({Color? color}) => _style(
        _parent.copyWith(
          fontFamily: "Urbanist",
          fontSize: 12.t(Get.context!),
          decoration: TextDecoration.none,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w400,
          height: 1,
          letterSpacing: 0.20000000298023224,
        ),
        color: color,
      );

  static TextStyle bodySmallSemibold({Color? color}) => _style(
        _parent.copyWith(
          fontFamily: "Urbanist",
          fontSize: 12.t(Get.context!),
          decoration: TextDecoration.none,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w500,
          height: 1,
          letterSpacing: 0.20000000298023224,
        ),
        color: color,
      );

  static TextStyle bodySmallBold({Color? color}) => _style(
        _parent.copyWith(
          fontFamily: "Urbanist",
          fontSize: 12.t(Get.context!),
          decoration: TextDecoration.none,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w700,
          height: 1,
          letterSpacing: 0.20000000298023224,
        ),
        color: color,
      );

  static TextStyle bodySmallMedium({Color? color}) => _style(
        _parent.copyWith(
          fontFamily: "Urbanist",
          fontSize: 12.t(Get.context!),
          decoration: TextDecoration.none,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w500,
          height: 1,
          letterSpacing: 0.20000000298023224,
        ),
        color: color,
      );

  static TextStyle bodyXsmallRegular({Color? color}) => _style(
        _parent.copyWith(
          fontFamily: "Urbanist",
          fontSize: 10.t(Get.context!),
          decoration: TextDecoration.none,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w400,
          height: 1,
          letterSpacing: 0.20000000298023224,
        ),
        color: color,
      );

  static TextStyle bodyXsmallSemibold({Color? color}) => _style(
        _parent.copyWith(
          fontFamily: "Urbanist",
          fontSize: 10.t(Get.context!),
          decoration: TextDecoration.none,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w700,
          height: 1,
          letterSpacing: 0.20000000298023224,
        ),
        color: color,
      );

  static TextStyle bodyXsmallBold({Color? color}) => _style(
        _parent.copyWith(
          fontFamily: "Urbanist",
          fontSize: 10.t(Get.context!),
          decoration: TextDecoration.none,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w700,
          height: 1,
          letterSpacing: 0.20000000298023224,
        ),
        color: color,
      );

  static TextStyle bodyXsmallMedium({Color? color}) => _style(
        _parent.copyWith(
          fontFamily: "Urbanist",
          fontSize: 10.t(Get.context!),
          decoration: TextDecoration.none,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w500,
          height: 1,
          letterSpacing: 0.20000000298023224,
        ),
        color: color,
      );
}

class Shadow extends BoxShadow {
  const Shadow._({
    super.color,
    super.offset,
    super.blurRadius,
    super.spreadRadius = 0.0,
    super.blurStyle,
  });
}

class Shadows {
  const Shadows._();

  static final List<Shadow> cardShadow1 = [
    Shadow._(
      color: Color.fromRGBO(4, 15, 6, 0.07999999821186066),
      offset: Offset(0, 4),
      blurRadius: 60,
      spreadRadius: 0,
      blurStyle: BlurStyle.normal,
    ),
  ];

  static final List<Shadow> cardShadow2 = [
    Shadow._(
      color: Color.fromRGBO(4, 15, 6, 0.05000000074505806),
      offset: Offset(0, 4),
      blurRadius: 60,
      spreadRadius: 0,
      blurStyle: BlurStyle.normal,
    ),
  ];

  static final List<Shadow> cardShadow3 = [
    Shadow._(
      color: Color.fromRGBO(4, 15, 6, 0.07999999821186066),
      offset: Offset(0, 20),
      blurRadius: 100,
      spreadRadius: 0,
      blurStyle: BlurStyle.normal,
    ),
  ];

  static final List<Shadow> buttonShadow1 = [
    Shadow._(
      color: ColorStyle.primary500.withOpacity(0.25),
      offset: Offset(4, 8),
      blurRadius: 24,
      spreadRadius: 0,
      blurStyle: BlurStyle.normal,
    ),
  ];

  static final List<Shadow> buttonShadow2 = [
    Shadow._(
      color: ColorStyle.primary500.withOpacity(0.25),
      offset: Offset(4, 12),
      blurRadius: 32,
      spreadRadius: 0,
      blurStyle: BlurStyle.normal,
    ),
  ];

  static final List<Shadow> buttonShadow3 = [
    Shadow._(
      color: ColorStyle.primary500.withOpacity(0.25),
      offset: Offset(4, 16),
      blurRadius: 32,
      spreadRadius: 0,
      blurStyle: BlurStyle.normal,
    ),
  ];
}

extension _LerpDouble on double {
  double _lerp(double b, double t) {
    return lerpDouble(this, b, t) ?? this;
  }
}

extension _LerpColor on Color {
  Color _lerp(Color b, double t) {
    return Color.lerp(this, b, t) ?? this;
  }
}

extension _LerpString on String {
  String _lerp(String b, double t) {
    return t < 0.5 ? b : this;
  }
}

extension _LerpBoolean on bool {
  bool _lerp(bool b, double t) {
    return t < 0.5 ? b : this;
  }
}
