import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../widgets/connected_social_interaction_buttons.dart';
import '../../widgets/social_interaction_buttons.dart';
import '../models/social_interaction_model.dart';

/**
 * InteractionButtonsDemo - Demo screen to test social interaction buttons
 * 
 * This screen demonstrates:
 * - Connected social interaction buttons with state management
 * - Simple social interaction buttons without state management
 * - Different configurations and use cases
 * - Animation and feedback testing
 */
class InteractionButtonsDemo extends ConsumerStatefulWidget {
  const InteractionButtonsDemo({Key? key}) : super(key: key);

  @override
  InteractionButtonsDemoState createState() => InteractionButtonsDemoState();
}

class InteractionButtonsDemoState extends ConsumerState<InteractionButtonsDemo> {
  // State for simple buttons demo
  bool _isLiked = false;
  bool _isSaved = false;
  int _likesCount = 1250;
  int _commentsCount = 89;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.black_900,
      appBar: AppBar(
        title: Text(
          'Interaction Buttons Demo',
          style: TextStyleHelper.instance.title20RegularRoboto.copyWith(
            color: appTheme.white_A700,
          ),
        ),
        backgroundColor: appTheme.black_900,
        iconTheme: IconThemeData(color: appTheme.white_A700),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Connected Buttons (with State Management)'),
            SizedBox(height: 16.h),
            _buildConnectedButtonsDemo(),
            
            SizedBox(height: 32.h),
            
            _buildSectionTitle('Simple Buttons (Manual State)'),
            SizedBox(height: 16.h),
            _buildSimpleButtonsDemo(),
            
            SizedBox(height: 32.h),
            
            _buildSectionTitle('Different Configurations'),
            SizedBox(height: 16.h),
            _buildConfigurationDemo(),
            
            SizedBox(height: 32.h),
            
            _buildSectionTitle('Animation Tests'),
            SizedBox(height: 16.h),
            _buildAnimationDemo(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyleHelper.instance.headline24BlackInter.copyWith(
        color: appTheme.white_A700,
      ),
    );
  }

  Widget _buildConnectedButtonsDemo() {
    return Container(
      padding: EdgeInsets.all(16.h),
      decoration: BoxDecoration(
        color: appTheme.deep_purple_900.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12.h),
        border: Border.all(
          color: appTheme.deep_purple_A700.withOpacity(0.5),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'User Profile Example',
            style: TextStyleHelper.instance.title16BoldLexendExa.copyWith(
              color: appTheme.white_A700,
            ),
          ),
          SizedBox(height: 16.h),
          ConnectedSocialInteractionButtons(
            itemId: 'demo_user_1',
            initialData: SocialInteractionModel(
              isLiked: false,
              isSaved: false,
              likesCount: 328700, // 328.7K
              commentsCount: 578,
              sharesCount: 99,
              id: 'demo_user_1',
            ),
            onCommentPressed: () {
              _showSnackBar('Navigate to comments');
            },
            onSharePressed: () {
              _showSnackBar('Sharing profile...');
            },
            onLikeChanged: (isLiked) {
              _showSnackBar(isLiked ? 'Liked!' : 'Unliked!');
            },
            onSaveChanged: (isSaved) {
              _showSnackBar(isSaved ? 'Saved to bookmarks!' : 'Removed from bookmarks!');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSimpleButtonsDemo() {
    return Container(
      padding: EdgeInsets.all(16.h),
      decoration: BoxDecoration(
        color: appTheme.indigo_300.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12.h),
        border: Border.all(
          color: appTheme.indigo_300.withOpacity(0.5),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Manual State Control',
            style: TextStyleHelper.instance.title16BoldLexendExa.copyWith(
              color: appTheme.white_A700,
            ),
          ),
          SizedBox(height: 16.h),
          SocialInteractionButtons(
            isLiked: _isLiked,
            isSaved: _isSaved,
            likesCount: _likesCount,
            commentsCount: _commentsCount,
            onLikePressed: () {
              setState(() {
                _isLiked = !_isLiked;
                _likesCount += _isLiked ? 1 : -1;
              });
              _showSnackBar(_isLiked ? 'Liked!' : 'Unliked!');
            },
            onCommentPressed: () {
              _showSnackBar('Opening comments...');
            },
            onSavePressed: () {
              setState(() {
                _isSaved = !_isSaved;
              });
              _showSnackBar(_isSaved ? 'Saved!' : 'Unsaved!');
            },
            onSharePressed: () {
              _showSnackBar('Sharing...');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildConfigurationDemo() {
    return Column(
      children: [
        // Compact version
        Container(
          padding: EdgeInsets.all(12.h),
          decoration: BoxDecoration(
            color: appTheme.blue_200.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8.h),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Compact (no counts)',
                style: TextStyleHelper.instance.body15RegularABeeZee.copyWith(
                  color: appTheme.white_A700,
                ),
              ),
              SizedBox(height: 8.h),
              ConnectedSocialInteractionButtons(
                itemId: 'demo_compact',
                showCounts: false,
                iconSize: 20.0,
                buttonSpacing: 8.0,
                initialData: SocialInteractionModel(
                  likesCount: 42,
                  commentsCount: 7,
                  id: 'demo_compact',
                ),
              ),
            ],
          ),
        ),
        
        SizedBox(height: 16.h),
        
        // Large version
        Container(
          padding: EdgeInsets.all(12.h),
          decoration: BoxDecoration(
            color: appTheme.blue_200.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8.h),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Large with spacing',
                style: TextStyleHelper.instance.body15RegularABeeZee.copyWith(
                  color: appTheme.white_A700,
                ),
              ),
              SizedBox(height: 8.h),
              ConnectedSocialInteractionButtons(
                itemId: 'demo_large',
                iconSize: 32.0,
                buttonSpacing: 24.0,
                initialData: SocialInteractionModel(
                  likesCount: 999999, // Will show as 1.0M
                  commentsCount: 2500, // Will show as 2.5K
                  id: 'demo_large',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAnimationDemo() {
    return Container(
      padding: EdgeInsets.all(16.h),
      decoration: BoxDecoration(
        color: appTheme.deep_purple_A700.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12.h),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tap quickly to see animations!',
            style: TextStyleHelper.instance.body15RegularABeeZee.copyWith(
              color: appTheme.white_A700,
            ),
          ),
          SizedBox(height: 16.h),
          ConnectedSocialInteractionButtons(
            itemId: 'demo_animation',
            initialData: SocialInteractionModel(
              likesCount: 5,
              commentsCount: 1,
              id: 'demo_animation',
            ),
            onLikeChanged: (isLiked) {
              // Show animated feedback
              if (isLiked) {
                _showAnimatedSnackBar('❤️ Liked with animation!');
              } else {
                _showAnimatedSnackBar('💔 Unliked...');
              }
            },
            onSaveChanged: (isSaved) {
              if (isSaved) {
                _showAnimatedSnackBar('🔖 Bookmarked!');
              } else {
                _showAnimatedSnackBar('📤 Removed bookmark');
              }
            },
          ),
        ],
      ),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 1),
        backgroundColor: appTheme.deep_purple_A700,
      ),
    );
  }

  void _showAnimatedSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_circle, color: appTheme.white_A700),
            SizedBox(width: 8.h),
            Text(message),
          ],
        ),
        duration: Duration(seconds: 2),
        backgroundColor: appTheme.deep_purple_A700,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.h),
        ),
      ),
    );
  }
}
