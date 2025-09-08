import 'package:flutter/material.dart';
import '../core/app_export.dart';
import 'custom_image_view.dart';

/**
 * A customizable button widget with optional left icon and text content.
 * Supports flexible styling including background colors, text colors, border radius, and padding.
 * 
 * @param text - The text content to display on the button
 * @param onPressed - Callback function triggered when button is pressed
 * @param leftIcon - Path to the left icon image (SVG, PNG, etc.)
 * @param backgroundColor - Background color of the button
 * @param textColor - Color of the button text
 * @param borderRadius - Border radius for rounded corners
 * @param padding - Internal padding of the button content
 * @param iconWidth - Width of the left icon
 * @param iconHeight - Height of the left icon
 * @param fontSize - Font size of the button text
 * @param fontWeight - Font weight of the button text
 * @param iconTextSpacing - Spacing between icon and text
 */
class CustomIconButton extends StatelessWidget {
  CustomIconButton({
    Key? key,
    this.text,
    this.onPressed,
    this.leftIcon,
    this.backgroundColor,
    this.textColor,
    this.borderRadius,
    this.padding,
    this.iconWidth,
    this.iconHeight,
    this.fontSize,
    this.fontWeight,
    this.iconTextSpacing,
  }) : super(key: key);

  /// The text content to display on the button
  final String? text;

  /// Callback function triggered when button is pressed
  final VoidCallback? onPressed;

  /// Path to the left icon image (SVG, PNG, etc.)
  final String? leftIcon;

  /// Background color of the button
  final Color? backgroundColor;

  /// Color of the button text
  final Color? textColor;

  /// Border radius for rounded corners
  final double? borderRadius;

  /// Internal padding of the button content
  final EdgeInsets? padding;

  /// Width of the left icon
  final double? iconWidth;

  /// Height of the left icon
  final double? iconHeight;

  /// Font size of the button text
  final double? fontSize;

  /// Font weight of the button text
  final FontWeight? fontWeight;

  /// Spacing between icon and text
  final double? iconTextSpacing;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? Color(0xFF0A5C6D),
        padding: padding ??
            EdgeInsets.only(
              top: 2.h,
              right: 10.h,
              bottom: 2.h,
              left: 10.h,
            ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 5.h),
        ),
        elevation: 0,
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (leftIcon != null) ...[
            CustomImageView(
              imagePath: leftIcon!,
              width: iconWidth ?? 10.h,
              height: iconHeight ?? 14.h,
            ),
            SizedBox(width: iconTextSpacing ?? 8.h),
          ],
          if (text != null)
            Text(
              text!,
              style: TextStyleHelper.instance.bodyTextABeeZee.copyWith(
                  color: textColor ?? appTheme.whiteCustom, height: 1.21),
            ),
        ],
      ),
    );
  }
}
