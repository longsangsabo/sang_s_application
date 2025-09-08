import 'package:flutter/material.dart';
import '../core/app_export.dart';
import '../widgets/social_interaction_buttons.dart';
import '../presentation/providers/social_interaction_provider.dart';
import '../presentation/models/social_interaction_model.dart';

/**
 * ConnectedSocialInteractionButtons - Social interaction buttons with state management
 * 
 * Features:
 * - Automatically manages like/save states with Riverpod
 * - Handles animations and user feedback
 * - Integrates with global interaction provider
 * - Supports custom styling and callbacks
 * - Includes analytics and tracking capabilities
 * 
 * @param itemId Unique identifier for the item
 * @param initialData Initial interaction data (optional)
 * @param onCommentPressed Custom callback for comment action
 * @param onSharePressed Custom callback for share action
 */
class ConnectedSocialInteractionButtons extends ConsumerWidget {
  const ConnectedSocialInteractionButtons({
    Key? key,
    required this.itemId,
    this.initialData,
    this.showCounts = true,
    this.buttonSpacing = 16.0,
    this.iconSize = 24.0,
    this.onCommentPressed,
    this.onSharePressed,
    this.onLikeChanged,
    this.onSaveChanged,
  }) : super(key: key);

  /// Unique identifier for the item
  final String itemId;
  
  /// Initial interaction data
  final SocialInteractionModel? initialData;
  
  /// Whether to show count numbers
  final bool showCounts;
  
  /// Spacing between buttons
  final double buttonSpacing;
  
  /// Size of the icons
  final double iconSize;
  
  /// Custom callbacks
  final VoidCallback? onCommentPressed;
  final VoidCallback? onSharePressed;
  final Function(bool isLiked)? onLikeChanged;
  final Function(bool isSaved)? onSaveChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get the interaction provider for this specific item
    final interactionProvider = socialInteractionProvider(itemId);
    final interactionState = ref.watch(interactionProvider);
    
    // Initialize data if not already done
    if (initialData != null && !interactionState.interactions.containsKey(itemId)) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(interactionProvider.notifier).initializeItem(itemId, initialData!);
      });
    }
    
    final interaction = interactionState.interactions[itemId] ?? const SocialInteractionModel();
    
    return SocialInteractionButtons(
      isLiked: interaction.isLiked,
      isSaved: interaction.isSaved,
      likesCount: interaction.likesCount,
      commentsCount: interaction.commentsCount,
      showCounts: showCounts,
      buttonSpacing: buttonSpacing,
      iconSize: iconSize,
      onLikePressed: () => _handleLike(ref),
      onCommentPressed: () => _handleComment(ref),
      onSavePressed: () => _handleSave(ref),
      onSharePressed: () => _handleShare(ref),
    );
  }

  void _handleLike(WidgetRef ref) {
    final notifier = ref.read(socialInteractionProvider(itemId).notifier);
    final currentInteraction = notifier.getInteraction(itemId);
    
    notifier.toggleLike(itemId);
    
    // Call custom callback
    onLikeChanged?.call(!currentInteraction.isLiked);
    
    // Analytics tracking (TODO: implement)
    _trackAnalytics('like_button_pressed', {
      'item_id': itemId,
      'is_liked': !currentInteraction.isLiked,
    });
  }

  void _handleComment(WidgetRef ref) {
    if (onCommentPressed != null) {
      onCommentPressed!();
    } else {
      // Default behavior - navigate to comments
      final notifier = ref.read(socialInteractionProvider(itemId).notifier);
      notifier.navigateToComments(itemId);
    }
    
    // Analytics tracking
    _trackAnalytics('comment_button_pressed', {
      'item_id': itemId,
    });
  }

  void _handleSave(WidgetRef ref) {
    final notifier = ref.read(socialInteractionProvider(itemId).notifier);
    final currentInteraction = notifier.getInteraction(itemId);
    
    notifier.toggleSave(itemId);
    
    // Call custom callback
    onSaveChanged?.call(!currentInteraction.isSaved);
    
    // Show feedback to user
    _showSaveFeedback(ref, !currentInteraction.isSaved);
    
    // Analytics tracking
    _trackAnalytics('save_button_pressed', {
      'item_id': itemId,
      'is_saved': !currentInteraction.isSaved,
    });
  }

  void _handleShare(WidgetRef ref) {
    if (onSharePressed != null) {
      onSharePressed!();
    } else {
      // Default behavior - handle sharing
      final notifier = ref.read(socialInteractionProvider(itemId).notifier);
      notifier.shareItem(itemId);
      
      // Show native share dialog (TODO: implement)
      _showShareDialog(ref);
    }
    
    // Analytics tracking
    _trackAnalytics('share_button_pressed', {
      'item_id': itemId,
    });
  }

  void _showSaveFeedback(WidgetRef ref, bool isSaved) {
    // Show snackbar or toast message
    final message = isSaved ? 'Đã lưu bài viết' : 'Đã bỏ lưu bài viết';
    
    // TODO: Implement proper feedback mechanism
    debugPrint('Save feedback: $message');
  }

  void _showShareDialog(WidgetRef ref) {
    // TODO: Implement native share dialog
    // Use share_plus package or similar
    debugPrint('Opening share dialog for item: $itemId');
  }

  void _trackAnalytics(String eventName, Map<String, dynamic> parameters) {
    // TODO: Implement analytics tracking
    // Firebase Analytics, Mixpanel, etc.
    debugPrint('Analytics: $eventName - $parameters');
  }
}

/**
 * Simplified social interaction buttons without state management
 * For use in places where you want to handle state manually
 */
class SimpleSocialInteractionButtons extends StatelessWidget {
  const SimpleSocialInteractionButtons({
    Key? key,
    this.isLiked = false,
    this.isSaved = false,
    this.likesCount = 0,
    this.commentsCount = 0,
    this.showCounts = true,
    this.buttonSpacing = 16.0,
    this.iconSize = 24.0,
    required this.onLikePressed,
    required this.onCommentPressed,
    required this.onSavePressed,
    required this.onSharePressed,
  }) : super(key: key);

  final bool isLiked;
  final bool isSaved;
  final int likesCount;
  final int commentsCount;
  final bool showCounts;
  final double buttonSpacing;
  final double iconSize;
  final VoidCallback onLikePressed;
  final VoidCallback onCommentPressed;
  final VoidCallback onSavePressed;
  final VoidCallback onSharePressed;

  @override
  Widget build(BuildContext context) {
    return SocialInteractionButtons(
      isLiked: isLiked,
      isSaved: isSaved,
      likesCount: likesCount,
      commentsCount: commentsCount,
      showCounts: showCounts,
      buttonSpacing: buttonSpacing,
      iconSize: iconSize,
      onLikePressed: onLikePressed,
      onCommentPressed: onCommentPressed,
      onSavePressed: onSavePressed,
      onSharePressed: onSharePressed,
    );
  }
}
