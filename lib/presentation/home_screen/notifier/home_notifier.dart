import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:equatable/equatable.dart';
import '../../models/opponent_card_model.dart';
import '../../models/social_interaction_model.dart';

/// State class for managing home screen data
class HomeState extends Equatable {
  const HomeState({
    this.opponents = const [],
    this.isLoading = false,
    this.isRefreshing = false,
    this.hasError = false,
    this.errorMessage = '',
    this.hasMoreData = true,
    this.currentPage = 0,
    this.searchQuery = '',
    this.selectedRankFilter = '',
    this.selectedLocationFilter = '',
  });

  /// List of opponents in the feed
  final List<OpponentCardModel> opponents;
  
  /// Whether data is currently being loaded
  final bool isLoading;
  
  /// Whether pull-to-refresh is active
  final bool isRefreshing;
  
  /// Whether an error occurred
  final bool hasError;
  
  /// Error message if any
  final String errorMessage;
  
  /// Whether there's more data to load for pagination
  final bool hasMoreData;
  
  /// Current page for pagination
  final int currentPage;
  
  /// Search query text
  final String searchQuery;
  
  /// Selected rank filter (G, A, B, C, All)
  final String selectedRankFilter;
  
  /// Selected location filter
  final String selectedLocationFilter;

  /// Create a copy with updated values
  HomeState copyWith({
    List<OpponentCardModel>? opponents,
    bool? isLoading,
    bool? isRefreshing,
    bool? hasError,
    String? errorMessage,
    bool? hasMoreData,
    int? currentPage,
    String? searchQuery,
    String? selectedRankFilter,
    String? selectedLocationFilter,
  }) {
    return HomeState(
      opponents: opponents ?? this.opponents,
      isLoading: isLoading ?? this.isLoading,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      hasError: hasError ?? this.hasError,
      errorMessage: errorMessage ?? this.errorMessage,
      hasMoreData: hasMoreData ?? this.hasMoreData,
      currentPage: currentPage ?? this.currentPage,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedRankFilter: selectedRankFilter ?? this.selectedRankFilter,
      selectedLocationFilter: selectedLocationFilter ?? this.selectedLocationFilter,
    );
  }

  @override
  List<Object?> get props => [
        opponents,
        isLoading,
        isRefreshing,
        hasError,
        errorMessage,
        hasMoreData,
        currentPage,
        searchQuery,
        selectedRankFilter,
        selectedLocationFilter,
      ];

  @override
  String toString() {
    return 'HomeState(opponents: ${opponents.length}, isLoading: $isLoading, hasError: $hasError)';
  }
}

/// Notifier for managing home screen state
class HomeNotifier extends StateNotifier<HomeState> {
  HomeNotifier() : super(const HomeState()) {
    loadInitialData();
  }

  /// Load initial data for the home feed
  Future<void> loadInitialData() async {
    if (state.isLoading) return;

    state = state.copyWith(isLoading: true, hasError: false);

    try {
      // Simulate API delay
      await Future.delayed(const Duration(milliseconds: 1500));
      
      // Load mock data
      final mockOpponents = OpponentCardModelFactory.createMockOpponents();
      
      state = state.copyWith(
        opponents: mockOpponents,
        isLoading: false,
        currentPage: 1,
        hasMoreData: true,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        hasError: true,
        errorMessage: 'Không thể tải dữ liệu. Vui lòng thử lại.',
      );
    }
  }

  /// Refresh the home feed
  Future<void> refreshData() async {
    if (state.isRefreshing) return;

    state = state.copyWith(isRefreshing: true, hasError: false);

    try {
      // Simulate API delay
      await Future.delayed(const Duration(milliseconds: 1000));
      
      // Reload mock data with some variations
      final mockOpponents = OpponentCardModelFactory.createMockOpponents();
      
      state = state.copyWith(
        opponents: mockOpponents,
        isRefreshing: false,
        currentPage: 1,
        hasMoreData: true,
      );
    } catch (e) {
      state = state.copyWith(
        isRefreshing: false,
        hasError: true,
        errorMessage: 'Không thể làm mới dữ liệu. Vui lòng thử lại.',
      );
    }
  }

  /// Load more data for pagination
  Future<void> loadMoreData() async {
    if (state.isLoading || !state.hasMoreData) return;

    state = state.copyWith(isLoading: true);

    try {
      // Simulate API delay
      await Future.delayed(const Duration(milliseconds: 800));
      
      // Generate more mock data
      final moreOpponents = List.generate(
        5,
        (index) => OpponentCardModelFactory.createRandomOpponent(
          state.opponents.length + index,
        ),
      );
      
      final updatedOpponents = [...state.opponents, ...moreOpponents];
      
      state = state.copyWith(
        opponents: updatedOpponents,
        isLoading: false,
        currentPage: state.currentPage + 1,
        hasMoreData: updatedOpponents.length < 50, // Max 50 items
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        hasError: true,
        errorMessage: 'Không thể tải thêm dữ liệu.',
      );
    }
  }

  /// Update social interaction for a specific opponent
  void updateOpponentInteraction(String opponentId, SocialInteractionModel newInteraction) {
    final updatedOpponents = state.opponents.map((opponent) {
      if (opponent.id == opponentId) {
        return opponent.copyWith(socialInteraction: newInteraction);
      }
      return opponent;
    }).toList();

    state = state.copyWith(opponents: updatedOpponents);
  }

  /// Update search query
  void updateSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
    _applyFilters();
  }

  /// Update rank filter
  void updateRankFilter(String rank) {
    state = state.copyWith(selectedRankFilter: rank);
    _applyFilters();
  }

  /// Update location filter
  void updateLocationFilter(String location) {
    state = state.copyWith(selectedLocationFilter: location);
    _applyFilters();
  }

  /// Apply current filters to the opponents list
  void _applyFilters() {
    // For now, just trigger a reload with filters
    // In a real app, this would filter the existing data or make a filtered API call
    loadInitialData();
  }

  /// Handle opponent card tap
  void onOpponentCardTap(OpponentCardModel opponent) {
    // Navigate to opponent profile or challenge screen
    // This will be implemented when we create the navigation system
    print('Tapped on opponent: ${opponent.userName}');
  }

  /// Handle challenge button press
  void onChallengeOpponent(OpponentCardModel opponent) {
    // Navigate to challenge setup screen
    print('Challenge opponent: ${opponent.userName}');
  }

  /// Handle schedule button press
  void onScheduleWithOpponent(OpponentCardModel opponent) {
    // Navigate to scheduling screen
    print('Schedule with opponent: ${opponent.userName}');
  }

  /// Clear error state
  void clearError() {
    state = state.copyWith(hasError: false, errorMessage: '');
  }

  /// Reset to initial state
  void reset() {
    state = const HomeState();
    loadInitialData();
  }
}

/// Provider for HomeNotifier
final homeNotifierProvider = StateNotifierProvider<HomeNotifier, HomeState>((ref) {
  return HomeNotifier();
});

/// Provider for getting opponents list
final opponentsProvider = Provider<List<OpponentCardModel>>((ref) {
  final homeState = ref.watch(homeNotifierProvider);
  return homeState.opponents;
});

/// Provider for checking if data is loading
final isLoadingProvider = Provider<bool>((ref) {
  final homeState = ref.watch(homeNotifierProvider);
  return homeState.isLoading;
});

/// Provider for checking if refreshing
final isRefreshingProvider = Provider<bool>((ref) {
  final homeState = ref.watch(homeNotifierProvider);
  return homeState.isRefreshing;
});

/// Provider for error state
final hasErrorProvider = Provider<bool>((ref) {
  final homeState = ref.watch(homeNotifierProvider);
  return homeState.hasError;
});
