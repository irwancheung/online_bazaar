import 'package:google_fonts/google_fonts.dart';
import 'package:online_bazaar/exports.dart';

class AppText {
  Text xl(
    String text, {
    Color? color,
    FontWeight? fontWeight,
    TextOverflow? overflow,
    TextDecoration? decoration,
  }) {
    return Text(
      text,
      overflow: overflow,
      style: GoogleFonts.varelaRound(
        height: 1,
        fontSize: 30.sp,
        color: color,
        fontWeight: fontWeight,
        decoration: decoration,
      ),
    );
  }

  Text header(
    String text, {
    Color? color,
    FontWeight? fontWeight,
    double? letterSpacing,
    TextAlign? textAlign,
    TextOverflow? overflow,
    TextDecoration? decoration,
  }) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: overflow,
      style: GoogleFonts.varelaRound(
        fontSize: 20.sp,
        color: color,
        fontWeight: fontWeight,
        letterSpacing: letterSpacing,
        decoration: decoration,
      ),
    );
  }

  Text body(
    String text, {
    Color? color,
    FontWeight? fontWeight,
    TextAlign? textAlign,
    TextOverflow? overflow,
    TextDecoration? decoration,
  }) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: overflow,
      style: GoogleFonts.varelaRound(
        fontSize: 16.sp,
        color: color,
        fontWeight: fontWeight,
        decoration: decoration,
      ),
    );
  }

  Text caption(
    String text, {
    Color? color,
    FontWeight? fontWeight,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    TextDecoration? decoration,
  }) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      style: GoogleFonts.varelaRound(
        fontSize: 14.sp,
        color: color,
        fontWeight: fontWeight,
        decoration: decoration,
      ),
    );
  }

  Text label(
    String text, {
    Color? color,
    FontWeight? fontWeight,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    TextDecoration? decoration,
  }) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      style: GoogleFonts.varelaRound(
        fontSize: 12.sp,
        color: color,
        fontWeight: fontWeight,
        decoration: decoration,
      ),
    );
  }

  Text smLabel(
    String text, {
    Color? color,
    FontWeight? fontWeight,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    TextDecoration? decoration,
  }) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      style: GoogleFonts.varelaRound(
        fontSize: 10.sp,
        color: color,
        fontWeight: fontWeight,
        decoration: decoration,
      ),
    );
  }

  Text fieldError(
    String text, {
    Color? color,
    FontWeight? fontWeight,
    TextAlign? textAlign,
    TextOverflow? overflow,
    TextDecoration? decoration,
  }) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: overflow,
      style: GoogleFonts.varelaRound(
        fontSize: 10.sp,
        color: color,
        fontWeight: fontWeight,
        decoration: decoration,
      ),
    );
  }
}
