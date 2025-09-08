import '../../core/app_export.dart';
import '../models/social_interaction_model.dart';

part 'social_interaction_state.dart';

/// Provider for managing social interaction states
final socialInteractionProvider = StateNotifierProvider.family
    .autoDispose<SocialInteractionNotifier, SocialInteractionState, String>(
  (ref, itemId) => SocialInteractionNotifier(
    SocialInteractionState(
      interactions: {
        itemId: const SocialInteractionModel(),
      },
    ),
  ),
);

/// Global provider for all social interactions
final globalSocialInteractionProvider = StateNotifierProvider
    .autoDispose<GlobalSocialInteractionNotifier, Map<String, SocialInteractionModel>>(
  (ref) => GlobalSocialInteractionNotifier({}),
);

class SocialInteractionNotifier extends StateNotifier<SocialInteractionState> {
  SocialInteractionNotifier(SocialInteractionState state) : super(state);

  /// Toggle like for a specific item
  void toggleLike(String itemId) {
    final currentInteraction = state.interactions[itemId] ?? const SocialInteractionModel();
    final updatedInteraction = currentInteraction.toggleLike();
    
    state = state.copyWith(
      interactions: {
        ...state.interactions,
        itemId: updatedInteraction,
      },
    );
  }

  /// Toggle save for a specific item
  void toggleSave(String itemId) {
    final currentInteraction = state.interactions[itemId] ?? const SocialInteractionModel();
    final updatedInteraction = currentInteraction.toggleSave();
    
    state = state.copyWith(
      interactions: {
        ...state.interactions,
        itemId: updatedInteraction,
      },
    );
  }

  /// Handle share action
  void shareItem(String itemId) {
    final currentInteraction = state.interactions[itemId] ?? const SocialInteractionModel();
    final updatedInteraction = currentInteraction.incrementShares();
    
    state = state.copyWith(
      interactions: {
        ...state.interactions,
        itemId: updatedInteraction,
      },
    );
    
    // TODO: Implement actual share functionality
    // - Native share dialog
    // - Deep linking
    // - Social media integration
  }

  /// Handle comment navigation
  void navigateToComments(String itemId) {
    // TODO: Implement navigation to comments screen
    // NavigatorService.pushNamed('/comments', arguments: itemId);
  }

  /// Initialize interaction data for an item
  void initializeItem(String itemId, SocialInteractionModel interaction) {
    state = state.copyWith(
      interactions: {
        ...state.interactions,
        itemId: interaction,
      },
    );
  }

  /// Get interaction data for a specific item
  SocialInteractionModel getInteraction(String itemId) {
    return state.interactions[itemId] ?? const SocialInteractionModel();
  }
}

/// Global notifier for managing all social interactions
class GlobalSocialInteractionNotifier extends StateNotifier<Map<String, SocialInteractionModel>> {
  GlobalSocialInteractionNotifier(Map<String, SocialInteractionModel> state) : super(state);

  /// Batch update multiple interactions
  void batchUpdateInteractions(Map<String, SocialInteractionModel> updates) {
    state = {
      ...state,
      ...updates,
    };
  }

  /// Get all liked items
  List<String> getLikedItems() {
    return state.entries
        .where((entry) => entry.value.isLiked)
        .map((entry) => entry.key)
        .toList();
  }

  /// Get all saved items
  List<String> getSavedItems() {
    return state.entries
        .where((entry) => entry.value.isSaved)
        .map((entry) => entry.key)
        .toList();
  }

  /// Clear all interactions (for logout)
  void clearAll() {
    state = {};
  }
}
