import 'package:flutter/material.dart';
import '../core/app_export.dart';
import 'custom_image_view.dart';

/**
 * CustomBottomBar - A customizable bottom navigation bar component
 * 
 * Features:
 * - Supports multiple navigation items with icons and labels
 * - Special tournament item with gradient backgrounds and notification badge
 * - Customizable selection states and callbacks
 * - Responsive design with proper scaling
 * 
 * @param bottomBarItemList List of bottom bar navigation items
 * @param selectedIndex Current selected item index (default: 0)
 * @param onChanged Callback function when item is tapped, returns index
 */
class CustomBottomBar extends StatelessWidget {
  CustomBottomBar({
    Key? key,
    required this.bottomBarItemList,
    required this.onChanged,
    this.selectedIndex = 0,
  }) : super(key: key);

  /// List of bottom bar items with their properties
  final List<CustomBottomBarItem> bottomBarItemList;

  /// Current selected index of the bottom bar
  final int selectedIndex;

  /// Callback function triggered when a bottom bar item is tapped will give index
  final Function(int) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.h),
      decoration: BoxDecoration(
        color: appTheme.black_900,
        boxShadow: [
          BoxShadow(
            color: appTheme.gray_900_02,
            blurRadius: 1.h,
            spreadRadius: 0,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(bottomBarItemList.length, (index) {
          final item = bottomBarItemList[index];
          final isSelected = selectedIndex == index;

          return Expanded(
            child: InkWell(
              onTap: () => onChanged(index),
              child: _buildBottomBarItem(item, isSelected, index),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildBottomBarItem(
      CustomBottomBarItem item, bool isSelected, int index) {
    // Special handling for tournament item (index 2 based on JSON structure)
    if (item.isTournament == true) {
      return _buildTournamentItem(item, isSelected);
    }

    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomImageView(
            imagePath: item.icon,
            height: item.iconHeight ?? 20.h,
            width: item.iconWidth ?? 20.h,
          ),
          SizedBox(height: 4.h),
          Text(
            item.title,
            style: TextStyleHelper.instance.label10Regular.copyWith(
                color: isSelected
                    ? Color(0xFF52D1C6)
                    : (item.textColor ?? Color(0xFFFFFFFF))),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildTournamentItem(CustomBottomBarItem item, bool isSelected) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 42.h,
            height: 28.h,
            child: Stack(
              children: [
                // Right gradient background
                Positioned(
                  right: 0,
                  child: Container(
                    width: 36.h,
                    height: 28.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.h),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0xFF3C0B43), Color(0xFFE220FD)],
                      ),
                    ),
                  ),
                ),
                // Left gradient background
                Positioned(
                  left: 0,
                  child: Container(
                    width: 36.h,
                    height: 28.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.h),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0xFF6987DE), Color(0xFF081E5F)],
                      ),
                    ),
                  ),
                ),
                // White overlay container
                Positioned(
                  left: 3.h,
                  right: 3.h,
                  top: 0,
                  bottom: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.h),
                      color: appTheme.white_A700,
                    ),
                    child: Center(
                      child: item.badgeCount != null
                          ? _buildBadge(item.badgeCount!)
                          : null,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            item.title,
            style: TextStyleHelper.instance.label10Regular.copyWith(
                color: isSelected
                    ? Color(0xFF52D1C6)
                    : (item.textColor ?? Color(0xFFA1A2A5))),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(String count) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.h),
        gradient: LinearGradient(
          begin: Alignment(0.0, -1.0),
          end: Alignment(1.0, 1.0),
          colors: [Color(0xFF1A1919), Color(0xFF000000)],
        ),
        boxShadow: [
          BoxShadow(
            color: appTheme.color990000,
            blurRadius: 8.h,
            spreadRadius: 0,
          ),
        ],
      ),
      width: 24.h,
      child: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 2.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.h),
            color: appTheme.white_A700,
          ),
          child: Text(
            count,
            style: TextStyleHelper.instance.label8RegularABeeZee,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

/// Item data model for custom bottom bar
class CustomBottomBarItem {
  CustomBottomBarItem({
    required this.icon,
    required this.title,
    required this.routeName,
    this.iconHeight,
    this.iconWidth,
    this.textColor,
    this.fontFamily,
    this.isTournament = false,
    this.badgeCount,
  });

  /// Path to the icon (SVG or image)
  final String icon;

  /// Title text shown below the icon
  final String title;

  /// Route name for navigation
  final String routeName;

  /// Custom height for the icon
  final double? iconHeight;

  /// Custom width for the icon
  final double? iconWidth;

  /// Text color for the label
  final Color? textColor;

  /// Font family for the text
  final String? fontFamily;

  /// Whether this item is the special tournament item
  final bool isTournament;

  /// Badge count for tournament item
  final String? badgeCount;
}
