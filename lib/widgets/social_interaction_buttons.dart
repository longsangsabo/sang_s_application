import 'package:flutter/material.dart';
import '../core/app_export.dart';
import 'custom_image_view.dart';

/**
 * SocialInteractionButtons - Interactive social action buttons component
 * 
 * Features:
 * - Like button with heart animation and state management
 * - Comment button with navigation capability
 * - Save/Bookmark button with toggle state
 * - Share button with custom share functionality
 * - Responsive design with proper scaling
 * - Support for custom styling and callbacks
 * 
 * @param isLiked Current like state
 * @param isSaved Current save/bookmark state
 * @param likesCount Number of likes to display
 * @param commentsCount Number of comments to display
 * @param onLikePressed Callback when like button is pressed
 * @param onCommentPressed Callback when comment button is pressed
 * @param onSavePressed Callback when save button is pressed
 * @param onSharePressed Callback when share button is pressed
 */
class SocialInteractionButtons extends StatefulWidget {
  const SocialInteractionButtons({
    Key? key,
    this.isLiked = false,
    this.isSaved = false,
    this.likesCount = 0,
    this.commentsCount = 0,
    this.showCounts = true,
    this.buttonSpacing = 16.0,
    this.iconSize = 24.0,
    this.onLikePressed,
    this.onCommentPressed,
    this.onSavePressed,
    this.onSharePressed,
  }) : super(key: key);

  /// Whether the item is currently liked
  final bool isLiked;
  
  /// Whether the item is currently saved/bookmarked
  final bool isSaved;
  
  /// Number of likes to display
  final int likesCount;
  
  /// Number of comments to display
  final int commentsCount;
  
  /// Whether to show count numbers below buttons
  final bool showCounts;
  
  /// Spacing between buttons
  final double buttonSpacing;
  
  /// Size of the icons
  final double iconSize;
  
  /// Callback functions for each button
  final VoidCallback? onLikePressed;
  final VoidCallback? onCommentPressed;
  final VoidCallback? onSavePressed;
  final VoidCallback? onSharePressed;

  @override
  SocialInteractionButtonsState createState() => SocialInteractionButtonsState();
}

class SocialInteractionButtonsState extends State<SocialInteractionButtons>
    with TickerProviderStateMixin {
  
  late AnimationController _likeAnimationController;
  late AnimationController _saveAnimationController;
  late Animation<double> _likeScaleAnimation;
  late Animation<double> _saveScaleAnimation;
  late Animation<double> _likeRotationAnimation;

  @override
  void initState() {
    super.initState();
    
    // Like animation controller
    _likeAnimationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    
    // Save animation controller
    _saveAnimationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    
    // Scale animations
    _likeScaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _likeAnimationController,
      curve: Curves.elasticOut,
    ));
    
    _saveScaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _saveAnimationController,
      curve: Curves.easeInOut,
    ));
    
    // Rotation animation for like
    _likeRotationAnimation = Tween<double>(
      begin: 0.0,
      end: 0.1,
    ).animate(CurvedAnimation(
      parent: _likeAnimationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _likeAnimationController.dispose();
    _saveAnimationController.dispose();
    super.dispose();
  }

  void _animateLike() {
    _likeAnimationController.forward().then((_) {
      _likeAnimationController.reverse();
    });
  }

  void _animateSave() {
    _saveAnimationController.forward().then((_) {
      _saveAnimationController.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildLikeButton(),
          SizedBox(width: widget.buttonSpacing.h),
          _buildCommentButton(),
          SizedBox(width: widget.buttonSpacing.h),
          _buildSaveButton(),
          SizedBox(width: widget.buttonSpacing.h),
          _buildShareButton(),
        ],
      ),
    );
  }

  Widget _buildLikeButton() {
    return GestureDetector(
      onTap: () {
        _animateLike();
        widget.onLikePressed?.call();
      },
      child: AnimatedBuilder(
        animation: _likeAnimationController,
        builder: (context, child) {
          return Transform.scale(
            scale: _likeScaleAnimation.value,
            child: Transform.rotate(
              angle: _likeRotationAnimation.value,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.all(8.h),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: widget.isLiked 
                          ? Color(0xFF6403C8).withOpacity(0.2)
                          : Colors.transparent,
                      border: widget.isLiked 
                          ? Border.all(color: Color(0xFF6403C8), width: 1)
                          : null,
                    ),
                    child: Icon(
                      widget.isLiked ? Icons.favorite : Icons.favorite_border,
                      color: widget.isLiked 
                          ? Color(0xFF6403C8)
                          : appTheme.white_A700,
                      size: widget.iconSize.h,
                    ),
                  ),
                  if (widget.showCounts) ...[
                    SizedBox(height: 4.h),
                    Text(
                      _formatCount(widget.likesCount),
                      style: TextStyleHelper.instance.body13RegularABeeZee.copyWith(
                        color: widget.isLiked 
                            ? Color(0xFF6403C8)
                            : appTheme.white_A700,
                        fontWeight: widget.isLiked ? FontWeight.w600 : FontWeight.normal,
                        shadows: [
                          Shadow(
                            color: appTheme.black_900.withOpacity(0.5),
                            offset: Offset(0, 1),
                            blurRadius: 2,
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCommentButton() {
    return GestureDetector(
      onTap: widget.onCommentPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(8.h),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
            ),
            child: CustomImageView(
              imagePath: ImageConstant.imgMessageIcon,
              height: widget.iconSize.h,
              width: widget.iconSize.h,
              color: appTheme.white_A700,
            ),
          ),
          if (widget.showCounts) ...[
            SizedBox(height: 4.h),
            Text(
              _formatCount(widget.commentsCount),
              style: TextStyleHelper.instance.body13RegularABeeZee.copyWith(
                color: appTheme.white_A700,
                shadows: [
                  Shadow(
                    color: appTheme.black_900.withOpacity(0.3),
                    offset: Offset(1, 1),
                    blurRadius: 2,
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSaveButton() {
    return GestureDetector(
      onTap: () {
        _animateSave();
        widget.onSavePressed?.call();
      },
      child: AnimatedBuilder(
        animation: _saveAnimationController,
        builder: (context, child) {
          return Transform.scale(
            scale: _saveScaleAnimation.value,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.all(8.h),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: widget.isSaved 
                        ? Color(0xFF7792E2).withOpacity(0.2)
                        : Colors.transparent,
                    border: widget.isSaved 
                        ? Border.all(color: Color(0xFF7792E2), width: 1)
                        : null,
                  ),
                  child: Icon(
                    widget.isSaved ? Icons.bookmark : Icons.bookmark_border,
                    color: widget.isSaved 
                        ? Color(0xFF7792E2)
                        : appTheme.white_A700,
                    size: widget.iconSize.h,
                  ),
                ),
                if (widget.showCounts) ...[
                  SizedBox(height: 4.h),
                  Text(
                    widget.isSaved ? 'Đã lưu' : 'Lưu',
                    style: TextStyleHelper.instance.body13RegularABeeZee.copyWith(
                      color: widget.isSaved 
                          ? Color(0xFF7792E2)
                          : appTheme.white_A700,
                      fontWeight: widget.isSaved ? FontWeight.w600 : FontWeight.normal,
                      shadows: [
                        Shadow(
                          color: appTheme.black_900.withOpacity(0.5),
                          offset: Offset(0, 1),
                          blurRadius: 2,
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildShareButton() {
    return GestureDetector(
      onTap: widget.onSharePressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(8.h),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
            ),
            child: CustomImageView(
              imagePath: ImageConstant.imgShareIcon,
              height: widget.iconSize.h,
              width: widget.iconSize.h,
              color: appTheme.white_A700,
            ),
          ),
          if (widget.showCounts) ...[
            SizedBox(height: 4.h),
            Text(
              'Chia sẻ',
              style: TextStyleHelper.instance.body13RegularABeeZee.copyWith(
                color: appTheme.white_A700,
                shadows: [
                  Shadow(
                    color: appTheme.black_900.withOpacity(0.3),
                    offset: Offset(1, 1),
                    blurRadius: 2,
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _formatCount(int count) {
    if (count >= 1000000) {
      return '${(count / 1000000).toStringAsFixed(1)}M';
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}K';
    } else {
      return count.toString();
    }
  }
}
