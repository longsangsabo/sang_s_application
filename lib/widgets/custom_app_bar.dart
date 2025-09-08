import 'package:flutter/material.dart';
import '../core/app_export.dart';
import 'custom_image_view.dart';

/**
 * CustomAppBar - A flexible and customizable app bar component
 * 
 * Features:
 * - Gradient text support for title
 * - Configurable action buttons with custom icons
 * - Responsive sizing with SizeUtils
 * - Customizable padding and styling
 * - Support for different gradient combinations
 * 
 * @param title - The main title text to display
 * @param gradientColors - List of colors for gradient text effect
 * @param actionIcons - List of icon paths for action buttons
 * @param onActionTap - Callback function for action button taps (receives index)
 * @param backgroundColor - Background color of the app bar
 * @param elevation - Shadow elevation of the app bar
 * @param centerTitle - Whether to center the title
 * @param automaticallyImplyLeading - Whether to show back button automatically
 */
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({
    Key? key,
    this.title,
    this.gradientColors,
    this.actionIcons,
    this.onActionTap,
    this.backgroundColor,
    this.elevation,
    this.centerTitle,
    this.automaticallyImplyLeading,
    this.leading,
    this.titleSpacing,
  }) : super(key: key);

  /// The main title text to display in the app bar
  final String? title;

  /// List of colors for creating gradient effect on title text
  final List<Color>? gradientColors;

  /// List of icon paths for action buttons
  final List<String>? actionIcons;

  /// Callback function triggered when action buttons are tapped
  /// Receives the index of the tapped action button
  final Function(int)? onActionTap;

  /// Background color of the app bar
  final Color? backgroundColor;

  /// Shadow elevation of the app bar
  final double? elevation;

  /// Whether to center the title text
  final bool? centerTitle;

  /// Whether to automatically show leading widget (back button)
  final bool? automaticallyImplyLeading;

  /// Custom leading widget
  final Widget? leading;

  /// Spacing before the title
  final double? titleSpacing;

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? appTheme.transparentCustom,
      elevation: elevation ?? 0,
      centerTitle: centerTitle ?? false,
      automaticallyImplyLeading: automaticallyImplyLeading ?? false,
      leading: leading,
      titleSpacing: titleSpacing ?? 16.h,
      title: _buildTitle(),
      actions: _buildActions(),
    );
  }

  /// Builds the title widget with optional gradient effect
  Widget? _buildTitle() {
    if (title == null) return null;

    final colors = gradientColors ?? [Color(0xFF6403C8), Color(0xFF0414AC)];

    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        colors: colors,
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ).createShader(bounds),
      child: Text(
        title!,
        style: TextStyleHelper.instance.headline24BlackInter
            .copyWith(letterSpacing: 1, height: 1.25),
      ),
    );
  }

  /// Builds the action buttons list
  List<Widget>? _buildActions() {
    if (actionIcons == null || actionIcons!.isEmpty) return null;

    List<Widget> actions = [];

    for (int i = 0; i < actionIcons!.length; i++) {
      actions.add(
        IconButton(
          onPressed: () => onActionTap?.call(i),
          icon: CustomImageView(
            imagePath: actionIcons![i],
            height: 20.h,
            width: 20.h,
          ),
          padding: EdgeInsets.symmetric(horizontal: 8.h),
        ),
      );
    }

    actions.add(SizedBox(width: 16.h)); // Right padding

    return actions;
  }
}
