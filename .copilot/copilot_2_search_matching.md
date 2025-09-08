# 🤖 COPILOT 2 - SEARCH & MATCHING SPECIALIST

## 🎯 YOUR MISSION
You are the **Search & Matching Specialist** for the SABO Billiards Social App. Your primary responsibility is implementing the Search Screen (/search) with advanced filtering and player matching algorithms.

## 🔍 PROJECT CONTEXT
- **App**: SABO Billiards Social Platform
- **Architecture**: Clean Architecture + Riverpod + Material Design 3
- **Your Focus**: Search Screen + Intelligent Player Matching
- **Integration**: Works with Home Screen (Copilot 1) for search results

## 🔍 SEARCH SCREEN REQUIREMENTS

### **Core Features to Implement**
1. **Advanced Search Interface**
   - Search bar with real-time suggestions
   - Filter chips for quick selection
   - Advanced filter modal/drawer
   - Search history and saved searches

2. **Filter Categories**
   ```dart
   // Filter Options
   - Rank: G, F, E, D, C, B, A, Pro
   - Location: Distance radius, specific areas
   - Availability: Online now, Today, This week
   - Game Type: 8-ball, 9-ball, 10-ball, Snooker
   - Skill Level: Beginner, Intermediate, Advanced, Expert
   - Club Affiliation: SABO members, Other clubs
   ```

3. **Search Results**
   - Grid/List view toggle
   - Sort by: Distance, Rank, Rating, Activity
   - Pagination with infinite scroll
   - Empty states and loading indicators

### **Matching Algorithm Features**
1. **Compatibility Scoring**
   - Skill level compatibility (±2 ranks)
   - Location proximity scoring
   - Playing style preferences
   - Historical match success rate

2. **Smart Recommendations**
   - "Players near you" section
   - "Similar skill level" suggestions
   - "Available now" priority
   - "Frequent opponents" recommendations

### **Technical Implementation**
```dart
// Expected Structure
lib/presentation/search_screen/
├── search_screen.dart
├── widgets/
│   ├── search_app_bar.dart
│   ├── filter_chips.dart
│   ├── advanced_filter_modal.dart
│   ├── search_results_grid.dart
│   └── player_match_card.dart
├── models/
│   ├── search_filter_model.dart
│   ├── match_result_model.dart
│   └── search_history_model.dart
├── providers/
│   ├── search_provider.dart
│   ├── filter_provider.dart
│   └── matching_provider.dart
└── services/
    ├── search_service.dart
    └── matching_algorithm.dart
```

## 🧠 MATCHING ALGORITHM DESIGN

### **Core Algorithm Logic**
```dart
class MatchingAlgorithm {
  double calculateCompatibility(UserProfile current, UserProfile target) {
    double rankScore = _calculateRankCompatibility(current.rank, target.rank);
    double locationScore = _calculateLocationScore(current.location, target.location);
    double availabilityScore = _calculateAvailabilityScore(current, target);
    double preferenceScore = _calculatePreferenceScore(current, target);
    
    return (rankScore * 0.3) + (locationScore * 0.3) + 
           (availabilityScore * 0.25) + (preferenceScore * 0.15);
  }
}
```

### **Ranking System Integration**
```dart
// Rank Compatibility Matrix
Map<String, List<String>> rankCompatibility = {
  'G': ['G', 'F'],           // Beginners
  'F': ['G', 'F', 'E'],      // Novice
  'E': ['F', 'E', 'D'],      // Intermediate
  'D': ['E', 'D', 'C'],      // Advanced
  'C': ['D', 'C', 'B'],      // Expert
  'B': ['C', 'B', 'A'],      // Professional
  'A': ['B', 'A', 'Pro'],    // Master
  'Pro': ['A', 'Pro'],       // Professional
};
```

## 🎨 DESIGN GUIDELINES

### **Search Interface Design**
- Clean, Google-style search bar
- Filter chips below search bar
- Results in card format (similar to home feed)
- Use existing color scheme and components

### **Filter Modal Design**
```dart
// Filter Categories Layout
┌─────────────────────────────┐
│ 🏆 Rank Range               │
│ ┌─┐ ┌─┐ ┌─┐ ┌─┐ ┌─┐ ┌─┐   │
│ │G│ │F│ │E│ │D│ │C│ │B│   │
│ └─┘ └─┘ └─┘ └─┘ └─┘ └─┘   │
│                             │
│ 📍 Location (15km)          │
│ ●━━━━━○━━━━━● (slider)      │
│                             │
│ ⏰ Availability             │
│ ☐ Online now               │
│ ☐ Available today          │
│ ☐ Available this week      │
│                             │
│ 🎱 Game Type               │
│ ☐ 8-Ball  ☐ 9-Ball        │
│ ☐ 10-Ball ☐ Snooker       │
└─────────────────────────────┘
```

## 🔧 EXISTING COMPONENTS TO USE

### **Available Widgets**
- Use `CustomAppBar` for search screen header
- Leverage `CustomImageView` for player avatars
- Use existing card styling from profile components
- Apply `SocialInteractionButtons` in search results

### **State Management Pattern**
```dart
// Follow existing pattern
final searchProvider = StateNotifierProvider.autoDispose<SearchNotifier, SearchState>(
  (ref) => SearchNotifier(),
);

class SearchState {
  final String query;
  final SearchFilterModel filters;
  final List<PlayerMatchResult> results;
  final bool isLoading;
  final String? error;
}
```

## 📋 DELIVERABLES CHECKLIST

### **Phase 1: Basic Search** ✅
- [ ] Create search_screen.dart with search bar
- [ ] Implement basic text search functionality
- [ ] Setup search providers and models
- [ ] Add route and navigation integration
- [ ] Create search results grid layout

### **Phase 2: Advanced Filtering** ✅
- [ ] Implement filter chips interface
- [ ] Create advanced filter modal
- [ ] Add filter logic to search results
- [ ] Implement search history
- [ ] Add sort and view toggle options

### **Phase 3: Matching Algorithm** ✅
- [ ] Implement compatibility scoring algorithm
- [ ] Add location-based search with radius
- [ ] Create recommendation engine
- [ ] Add match percentage display
- [ ] Optimize search performance

## 🔗 INTEGRATION POINTS

### **With Copilot 1 (Home Screen)**
```dart
// Provide search interface for home screen
class SearchService {
  Future<List<OpponentModel>> searchOpponents(SearchFilterModel filters);
  Stream<List<OpponentModel>> getRecommendations(String userId);
}
```

### **With Copilot 3 (Tournament/Club)**
```dart
// Tournament player search
Future<List<PlayerModel>> searchTournamentPlayers(String tournamentId);

// Club member search  
Future<List<PlayerModel>> searchClubMembers(String clubId);
```

### **With Copilot 4 (Backend)**
```dart
// Real-time search with Supabase
Stream<List<PlayerModel>> searchPlayersRealTime(String query);
Future<void> saveSearchHistory(SearchHistoryModel history);
```

## 🧪 TESTING REQUIREMENTS

### **Search Functionality Tests**
- [ ] Search returns relevant results
- [ ] Filters work correctly in combination
- [ ] Search history saves and loads
- [ ] Performance with large datasets
- [ ] Debounced search (300ms delay)

### **Matching Algorithm Tests**
```dart
// Test cases
void testMatchingAlgorithm() {
  // Same rank should score high
  assert(algorithm.calculate(rankG_user, rankG_opponent) > 0.7);
  
  // Distant ranks should score low  
  assert(algorithm.calculate(rankG_user, rankPro_opponent) < 0.3);
  
  // Close location should boost score
  assert(algorithm.calculate(sameLocation) > algorithm.calculate(farLocation));
}
```

## 🚨 CRITICAL CONSTRAINTS

### **Performance Requirements**
- Search results must load within 500ms
- Filter updates should be instant (local filtering)
- Support 1000+ player database
- Smooth scrolling with image loading

### **Matching Algorithm Constraints**
- Never suggest players >3 ranks different
- Prioritize players within 25km
- Consider availability status
- Factor in historical match success

## 📱 UI/UX REQUIREMENTS

### **Search Experience**
1. **Instant Feedback**: Show loading states immediately
2. **Progressive Disclosure**: Basic filters visible, advanced in modal
3. **Visual Hierarchy**: Clear distinction between filter types
4. **Empty States**: Helpful messages when no results found

### **Filter Design**
```dart
// Filter Chip Examples
FilterChip(
  label: Text('Rank G-E'),
  selected: isSelected,
  onSelected: onToggle,
  backgroundColor: appTheme.deep_purple_A700.withOpacity(0.1),
  selectedColor: appTheme.deep_purple_A700,
)
```

## 🎯 SUCCESS CRITERIA

### **Minimum Viable Product**
- ✅ Basic text search functionality
- ✅ Filter by rank and location
- ✅ Results display with pagination
- ✅ Integration with app navigation

### **Ideal Implementation**
- ✅ Advanced matching algorithm
- ✅ Real-time search suggestions
- ✅ Smart recommendations
- ✅ Search analytics and optimization

## 🚀 GETTING STARTED

1. **Study existing patterns**: Look at user_profile_screen structure
2. **Start with basic search**: Text input + simple results
3. **Build filter system**: Add one filter type at a time
4. **Implement matching**: Start with simple rank compatibility
5. **Optimize and polish**: Performance tuning and UX improvements

**Make search the best feature of the app! 🔍✨**
