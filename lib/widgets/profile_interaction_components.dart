import 'package:flutter/material.dart';
import '../core/app_export.dart';
import '../widgets/connected_social_interaction_buttons.dart';
import '../presentation/models/social_interaction_model.dart';

/**
 * ProfileSocialInteractionCard - Social interaction component for profile screens
 * 
 * Designed to match the SABO app profile interface:
 * - Horizontal layout with stats
 * - Purple gradient accent colors
 * - Clean typography matching the app design
 * - Integrates seamlessly with existing profile cards
 */
class ProfileSocialInteractionCard extends ConsumerWidget {
  const ProfileSocialInteractionCard({
    Key? key,
    required this.itemId,
    this.initialData,
    this.onCommentPressed,
    this.onSharePressed,
    this.backgroundColor,
    this.showCompactLayout = false,
  }) : super(key: key);

  final String itemId;
  final SocialInteractionModel? initialData;
  final VoidCallback? onCommentPressed;
  final VoidCallback? onSharePressed;
  final Color? backgroundColor;
  final bool showCompactLayout;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (showCompactLayout) {
      return _buildCompactLayout(context, ref);
    }
    return _buildFullLayout(context, ref);
  }

  Widget _buildFullLayout(BuildContext context, WidgetRef ref) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.h, vertical: 8.h),
      padding: EdgeInsets.all(16.h),
      decoration: BoxDecoration(
        color: backgroundColor ?? Color(0xFF1A1A2E).withOpacity(0.8),
        borderRadius: BorderRadius.circular(12.h),
        border: Border.all(
          color: Color(0xFF6403C8).withOpacity(0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF6403C8).withOpacity(0.1),
            blurRadius: 8.h,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.thumb_up_outlined,
                color: Color(0xFF6403C8),
                size: 16.h,
              ),
              SizedBox(width: 8.h),
              Text(
                'Tương tác với profile',
                style: TextStyleHelper.instance.body14RegularABeeZee.copyWith(
                  color: appTheme.white_A700,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          ConnectedSocialInteractionButtons(
            itemId: itemId,
            initialData: initialData,
            showCounts: true,
            buttonSpacing: 20.0,
            iconSize: 24.0,
            onCommentPressed: onCommentPressed,
            onSharePressed: onSharePressed,
          ),
        ],
      ),
    );
  }

  Widget _buildCompactLayout(BuildContext context, WidgetRef ref) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 8.h),
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.transparent,
        borderRadius: BorderRadius.circular(8.h),
      ),
      child: ConnectedSocialInteractionButtons(
        itemId: itemId,
        initialData: initialData,
        showCounts: true,
        buttonSpacing: 16.0,
        iconSize: 20.0,
        onCommentPressed: onCommentPressed,
        onSharePressed: onSharePressed,
      ),
    );
  }
}

/**
 * ProfileActionButtons - Action buttons component matching SABO design
 * 
 * Features "Chơi luôn" and "Hẹn lịch" buttons with the app's design language
 */
class ProfileActionButtons extends StatelessWidget {
  const ProfileActionButtons({
    Key? key,
    this.onPlayNowPressed,
    this.onSchedulePressed,
    this.isCompact = false,
  }) : super(key: key);

  final VoidCallback? onPlayNowPressed;
  final VoidCallback? onSchedulePressed;
  final bool isCompact;

  @override
  Widget build(BuildContext context) {
    if (isCompact) {
      return _buildCompactButtons(context);
    }
    return _buildFullButtons(context);
  }

  Widget _buildFullButtons(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.h, vertical: 8.h),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: _buildPlayNowButton(context),
          ),
          SizedBox(width: 12.h),
          Expanded(
            child: _buildScheduleButton(context),
          ),
        ],
      ),
    );
  }

  Widget _buildCompactButtons(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildPlayNowButton(context, isCompact: true),
        SizedBox(width: 8.h),
        _buildScheduleButton(context, isCompact: true),
      ],
    );
  }

  Widget _buildPlayNowButton(BuildContext context, {bool isCompact = false}) {
    return Container(
      height: isCompact ? 36.h : 44.h,
      child: ElevatedButton.icon(
        onPressed: onPlayNowPressed,
        icon: Icon(
          Icons.sports_esports,
          size: isCompact ? 16.h : 18.h,
          color: appTheme.white_A700,
        ),
        label: Text(
          'Chơi luôn',
          style: TextStyleHelper.instance.body14RegularABeeZee.copyWith(
            color: appTheme.white_A700,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF6403C8),
          foregroundColor: appTheme.white_A700,
          elevation: 3,
          shadowColor: Color(0xFF6403C8).withOpacity(0.4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(isCompact ? 18.h : 22.h),
          ),
        ),
      ),
    );
  }

  Widget _buildScheduleButton(BuildContext context, {bool isCompact = false}) {
    return Container(
      height: isCompact ? 36.h : 44.h,
      child: OutlinedButton.icon(
        onPressed: onSchedulePressed,
        icon: Icon(
          Icons.schedule,
          size: isCompact ? 16.h : 18.h,
          color: Color(0xFF7792E2),
        ),
        label: Text(
          'Hẹn lịch',
          style: TextStyleHelper.instance.body14RegularABeeZee.copyWith(
            color: Color(0xFF7792E2),
            fontWeight: FontWeight.w500,
          ),
        ),
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            color: Color(0xFF7792E2),
            width: 1.5,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(isCompact ? 18.h : 22.h),
          ),
        ),
      ),
    );
  }
}

/**
 * IntegratedProfileInteractions - Complete interaction section for profile
 * 
 * Combines social interactions and action buttons in a cohesive layout
 */
class IntegratedProfileInteractions extends ConsumerWidget {
  const IntegratedProfileInteractions({
    Key? key,
    required this.itemId,
    this.initialData,
    this.onCommentPressed,
    this.onSharePressed,
    this.onPlayNowPressed,
    this.onSchedulePressed,
    this.layoutStyle = ProfileInteractionLayout.stacked,
  }) : super(key: key);

  final String itemId;
  final SocialInteractionModel? initialData;
  final VoidCallback? onCommentPressed;
  final VoidCallback? onSharePressed;
  final VoidCallback? onPlayNowPressed;
  final VoidCallback? onSchedulePressed;
  final ProfileInteractionLayout layoutStyle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    switch (layoutStyle) {
      case ProfileInteractionLayout.stacked:
        return _buildStackedLayout(context);
      case ProfileInteractionLayout.horizontal:
        return _buildHorizontalLayout(context);
      case ProfileInteractionLayout.minimal:
        return _buildMinimalLayout(context);
    }
  }

  Widget _buildStackedLayout(BuildContext context) {
    return Column(
      children: [
        ProfileSocialInteractionCard(
          itemId: itemId,
          initialData: initialData,
          onCommentPressed: onCommentPressed,
          onSharePressed: onSharePressed,
        ),
        SizedBox(height: 8.h),
        ProfileActionButtons(
          onPlayNowPressed: onPlayNowPressed,
          onSchedulePressed: onSchedulePressed,
        ),
      ],
    );
  }

  Widget _buildHorizontalLayout(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.h, vertical: 8.h),
      padding: EdgeInsets.all(16.h),
      decoration: BoxDecoration(
        color: Color(0xFF1A1A2E).withOpacity(0.8),
        borderRadius: BorderRadius.circular(12.h),
        border: Border.all(
          color: Color(0xFF6403C8).withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: ProfileSocialInteractionCard(
              itemId: itemId,
              initialData: initialData,
              onCommentPressed: onCommentPressed,
              onSharePressed: onSharePressed,
              showCompactLayout: true,
              backgroundColor: Colors.transparent,
            ),
          ),
          SizedBox(width: 16.h),
          Expanded(
            child: ProfileActionButtons(
              onPlayNowPressed: onPlayNowPressed,
              onSchedulePressed: onSchedulePressed,
              isCompact: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMinimalLayout(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.h, vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ConnectedSocialInteractionButtons(
            itemId: itemId,
            initialData: initialData,
            showCounts: false,
            buttonSpacing: 12.0,
            iconSize: 20.0,
            onCommentPressed: onCommentPressed,
            onSharePressed: onSharePressed,
          ),
          Container(
            height: 24.h,
            width: 1,
            color: appTheme.white_A700.withOpacity(0.3),
          ),
          ProfileActionButtons(
            onPlayNowPressed: onPlayNowPressed,
            onSchedulePressed: onSchedulePressed,
            isCompact: true,
          ),
        ],
      ),
    );
  }
}

enum ProfileInteractionLayout {
  stacked,    // Social buttons on top, action buttons below
  horizontal, // Side by side in a card
  minimal,    // Compact single row
}
