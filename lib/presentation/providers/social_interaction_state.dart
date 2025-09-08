part of 'social_interaction_provider.dart';

/// State class for managing social interactions
class SocialInteractionState extends Equatable {
  const SocialInteractionState({
    this.interactions = const {},
    this.isLoading = false,
    this.error,
  });

  /// Map of item IDs to their interaction states
  final Map<String, SocialInteractionModel> interactions;
  
  /// Loading state for async operations
  final bool isLoading;
  
  /// Error message if any operation fails
  final String? error;

  /// Create a copy with updated values
  SocialInteractionState copyWith({
    Map<String, SocialInteractionModel>? interactions,
    bool? isLoading,
    String? error,
  }) {
    return SocialInteractionState(
      interactions: interactions ?? this.interactions,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  /// Clear error state
  SocialInteractionState clearError() {
    return copyWith(error: null);
  }

  /// Set loading state
  SocialInteractionState setLoading(bool loading) {
    return copyWith(isLoading: loading);
  }

  /// Set error state
  SocialInteractionState setError(String errorMessage) {
    return copyWith(error: errorMessage, isLoading: false);
  }

  @override
  List<Object?> get props => [interactions, isLoading, error];

  @override
  String toString() {
    return 'SocialInteractionState(interactions: ${interactions.length} items, isLoading: $isLoading, error: $error)';
  }
}
