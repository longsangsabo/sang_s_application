# 🏆 COPILOT 3 - TOURNAMENT & CLUB SPECIALIST

## 🎯 YOUR MISSION
You are the **Tournament & Club Specialist** for the SABO Billiards Social App. Your responsibility is implementing the Tournament Management System and Club Features for competitive billiards play.

## 🏆 PROJECT CONTEXT
- **App**: SABO Billiards Social Platform
- **Architecture**: Clean Architecture + Riverpod + Material Design 3
- **Your Focus**: Tournament System + Club Management + Competition Features
- **Integration**: Works with all other Copilots for tournament participants and club activities

## 🏅 TOURNAMENT SYSTEM REQUIREMENTS

### **Core Tournament Features**
1. **Tournament Discovery**
   - Browse active tournaments
   - Filter by game type, entry fee, skill level
   - Tournament calendar view
   - Featured/upcoming tournaments

2. **Tournament Types**
   ```dart
   enum TournamentType {
     singleElimination,    // Loại trực tiếp
     doubleElimination,    // Loại kép
     roundRobin,          // Vòng tròn
     swiss,               // Hệ thống Thụy Sĩ
     ladder,              // Thang điểm
   }
   
   enum GameType {
     eightBall,           // 8 bi
     nineBall,            // 9 bi
     tenBall,             // 10 bi
     snooker,             // Snooker
     carom,               // Carom/3 băng
   }
   ```

3. **Tournament Management**
   - Registration and payment
   - Bracket generation and updates
   - Live scoring and results
   - Prize distribution
   - Tournament chat/communication

### **Tournament Structure**
```dart
// Expected File Structure
lib/presentation/tournament_screen/
├── tournament_screen.dart
├── tournament_detail_screen.dart
├── create_tournament_screen.dart
├── tournament_bracket_screen.dart
├── widgets/
│   ├── tournament_card.dart
│   ├── tournament_filter_bar.dart
│   ├── bracket_widget.dart
│   ├── match_score_card.dart
│   └── tournament_leaderboard.dart
├── models/
│   ├── tournament_model.dart
│   ├── bracket_model.dart
│   ├── match_model.dart
│   └── tournament_registration_model.dart
├── providers/
│   ├── tournament_provider.dart
│   ├── bracket_provider.dart
│   └── tournament_registration_provider.dart
└── services/
    ├── tournament_service.dart
    └── bracket_generator.dart
```

## 🏛️ CLUB MANAGEMENT SYSTEM

### **Club Features**
1. **Club Discovery & Joining**
   - Browse local clubs
   - Club profiles with amenities
   - Membership application
   - Club verification system

2. **Club Activities**
   ```dart
   // Club Activity Types
   - Regular tournaments
   - Practice sessions
   - Social events
   - Training workshops
   - League matches
   ```

3. **Club Management**
   - Member directory
   - Event scheduling
   - Table booking system
   - Club leaderboards
   - Member communication

### **Club Structure**
```dart
lib/presentation/club_screen/
├── club_screen.dart
├── club_detail_screen.dart
├── club_members_screen.dart
├── club_events_screen.dart
├── widgets/
│   ├── club_card.dart
│   ├── club_amenities_widget.dart
│   ├── member_tile.dart
│   ├── club_event_card.dart
│   └── table_booking_widget.dart
├── models/
│   ├── club_model.dart
│   ├── club_member_model.dart
│   ├── club_event_model.dart
│   └── table_booking_model.dart
├── providers/
│   ├── club_provider.dart
│   ├── club_membership_provider.dart
│   └── club_events_provider.dart
└── services/
    ├── club_service.dart
    └── table_booking_service.dart
```

## 🎯 TOURNAMENT BRACKET SYSTEM

### **Bracket Generation Algorithm**
```dart
class BracketGenerator {
  List<Match> generateSingleElimination(List<Player> players) {
    // Calculate bracket size (next power of 2)
    int bracketSize = _getNextPowerOfTwo(players.length);
    
    // Add byes if needed
    List<Player?> seededPlayers = _seedPlayers(players, bracketSize);
    
    // Generate first round matches
    return _generateMatches(seededPlayers);
  }
  
  List<Match> generateDoubleElimination(List<Player> players) {
    // Winner bracket + Loser bracket
    // More complex algorithm with bracket reset possibility
  }
  
  List<Match> generateRoundRobin(List<Player> players) {
    // Every player plays every other player once
    // n(n-1)/2 total matches
  }
}
```

### **Live Tournament Updates**
```dart
class TournamentLiveProvider extends StateNotifier<TournamentState> {
  StreamSubscription? _tournamentSubscription;
  
  void subscribeToTournament(String tournamentId) {
    _tournamentSubscription = tournamentService
        .getTournamentUpdates(tournamentId)
        .listen((tournament) {
      state = state.copyWith(
        currentTournament: tournament,
        isUpdating: false,
      );
      
      // Notify all participants of bracket updates
      _notifyBracketUpdate(tournament.bracket);
    });
  }
}
```

## 🏅 RANKING & RATING SYSTEM

### **Tournament Points System**
```dart
class TournamentRatingCalculator {
  // Points based on tournament placement and field strength
  int calculateTournamentPoints({
    required int placement,
    required int totalPlayers,
    required double averageOpponentRating,
    required double tournamentMultiplier,
  }) {
    double basePoints = _getPlacementPoints(placement, totalPlayers);
    double strengthBonus = averageOpponentRating / 1000; // Normalize to 1.0
    double tournamentBonus = tournamentMultiplier; // Major tournament = 1.5x
    
    return (basePoints * strengthBonus * tournamentBonus).round();
  }
}
```

### **Club Rankings**
```dart
class ClubRanking {
  // Monthly club leaderboards
  final String clubId;
  final List<ClubMemberRank> rankings;
  final DateTime period;
  
  // Club vs Club competitions
  final int clubRating;
  final List<ClubMatch> interClubMatches;
}
```

## 🎨 DESIGN GUIDELINES

### **Tournament UI Design**
```dart
// Tournament Card Layout
┌─────────────────────────────┐
│ 🏆 SABO Cup 2024           │
│ 📅 15 Jan - 20 Jan         │
│ 🎱 9-Ball Single Elim      │
│ 💰 1,000,000 VND Prize     │
│ 👥 64/128 Players         │
│ ┌──────────┐ ┌─────────┐  │
│ │ Join Now │ │ Details │  │
│ └──────────┘ └─────────┘  │
└─────────────────────────────┘
```

### **Bracket Visualization**
```dart
// Tournament Bracket Layout (Single Elimination)
Round 1    Quarterfinals  Semifinals   Final
Player A ──┐
           ├── Winner A ──┐
Player B ──┘             │
                         ├── Winner AB ──┐
Player C ──┐             │               │
           ├── Winner C ──┘               ├── Champion
Player D ──┘                             │
                                         │
Player E ──┐                             │
           ├── Winner E ──┐               │
Player F ──┘             │               │
                         ├── Winner EF ──┘
Player G ──┐             │
           ├── Winner G ──┘
Player H ──┘
```

### **Club Profile Design**
```dart
// Club Card Layout
┌─────────────────────────────┐
│ 🏛️ SABO Billiards Club     │
│ 📍 District 1, HCMC        │
│ ⭐ 4.8 (124 reviews)       │
│ 🎱 12 Tables • 🅿️ Parking │
│ 💰 50k/hour • 📱 Booking  │
│ 👥 248 Members            │
│ ┌──────────┐ ┌─────────┐  │
│ │ Join Club│ │ Details │  │
│ └──────────┘ └─────────┘  │
└─────────────────────────────┘
```

## 🔧 EXISTING COMPONENTS TO USE

### **Reusable Widgets**
- Use `CustomAppBar` for tournament/club headers
- Leverage `CustomImageView` for tournament logos and club photos
- Use `SocialInteractionButtons` for tournament/club engagement
- Apply existing card styling for consistency

### **State Management Pattern**
```dart
// Tournament Provider Example
final tournamentProvider = StateNotifierProvider<TournamentNotifier, TournamentState>(
  (ref) => TournamentNotifier(ref.read(tournamentServiceProvider)),
);

class TournamentState {
  final List<Tournament> tournaments;
  final Tournament? selectedTournament;
  final TournamentFilter filter;
  final bool isLoading;
  final String? error;
}
```

## 📋 DELIVERABLES CHECKLIST

### **Phase 1: Tournament Discovery** ✅
- [ ] Create tournament_screen.dart with tournament list
- [ ] Implement tournament card widgets
- [ ] Add tournament filtering and search
- [ ] Setup tournament providers and models
- [ ] Add route and navigation integration

### **Phase 2: Tournament Management** ✅
- [ ] Implement tournament detail screen
- [ ] Create registration and payment flow
- [ ] Build bracket visualization widget
- [ ] Add live scoring functionality
- [ ] Implement tournament chat/communication

### **Phase 3: Club System** ✅
- [ ] Create club discovery and detail screens
- [ ] Implement club membership system
- [ ] Add club event management
- [ ] Build table booking functionality
- [ ] Create club leaderboards and rankings

### **Phase 4: Advanced Features** ✅
- [ ] Tournament bracket generation algorithms
- [ ] Live tournament updates with WebSocket
- [ ] Prize distribution system
- [ ] Tournament and club analytics
- [ ] Integration with payment gateway

## 🔗 INTEGRATION POINTS

### **With Copilot 1 (Home Screen)**
```dart
// Provide tournament feed for home screen
class TournamentService {
  Stream<List<Tournament>> getFeaturedTournaments();
  Stream<List<ClubEvent>> getUpcomingClubEvents();
}
```

### **With Copilot 2 (Search)**
```dart
// Tournament and club search functionality
Future<List<Tournament>> searchTournaments(String query, TournamentFilter filter);
Future<List<Club>> searchClubs(String query, ClubFilter filter);
Future<List<Player>> searchTournamentPlayers(String tournamentId);
```

### **With Copilot 4 (Backend)**
```dart
// Real-time tournament updates
Stream<Tournament> getTournamentUpdates(String tournamentId);
Future<void> updateMatchScore(String matchId, MatchScore score);
Future<PaymentResult> processRegistrationPayment(PaymentDetails details);
```

## 🧪 TESTING REQUIREMENTS

### **Tournament System Tests**
```dart
void testBracketGeneration() {
  // Test single elimination bracket
  final players = generateTestPlayers(8);
  final bracket = BracketGenerator().generateSingleElimination(players);
  
  assert(bracket.firstRound.length == 4); // 8 players = 4 first round matches
  assert(bracket.totalRounds == 3); // 8 players = 3 rounds to determine winner
}

void testTournamentRegistration() {
  // Test registration limits and validation
  final tournament = createTestTournament(maxPlayers: 32);
  
  // Should accept valid registration
  assert(tournament.canRegister(validPlayer) == true);
  
  // Should reject when full
  tournament.fillToCapacity();
  assert(tournament.canRegister(newPlayer) == false);
}
```

### **Club System Tests**
- [ ] Club membership validation
- [ ] Table booking conflict resolution
- [ ] Club event scheduling
- [ ] Member permissions and roles
- [ ] Club rating and review system

## 🚨 CRITICAL CONSTRAINTS

### **Tournament Integrity**
- Match results cannot be modified after confirmation
- Tournament brackets must be deterministic and fair
- Payment processing must be secure and reliable
- Real-time updates must be accurate and immediate

### **Club Management**
- Member data privacy and security
- Table booking conflicts must be prevented
- Club financial transactions must be auditable
- Event capacity limits must be enforced

## 📱 UI/UX REQUIREMENTS

### **Tournament Experience**
1. **Bracket Visualization**: Clear, interactive tournament brackets
2. **Live Updates**: Real-time score updates and notifications
3. **Mobile-First**: Touch-friendly bracket navigation
4. **Offline Support**: View tournament info without internet

### **Club Experience**
```dart
// Club Navigation Tabs
TabBar(
  tabs: [
    Tab(text: 'Overview'),
    Tab(text: 'Members'),
    Tab(text: 'Events'),
    Tab(text: 'Leaderboard'),
    Tab(text: 'Booking'),
  ],
)
```

## 🎯 SUCCESS CRITERIA

### **Minimum Viable Product**
- ✅ Tournament discovery and registration
- ✅ Basic bracket display and management
- ✅ Club profiles and membership
- ✅ Event scheduling and booking

### **Ideal Implementation**
- ✅ Advanced bracket algorithms for all tournament types
- ✅ Real-time live scoring and updates
- ✅ Comprehensive club management system
- ✅ Integration with payment and notification systems

## 💰 MONETIZATION FEATURES

### **Tournament Revenue**
```dart
// Tournament entry fees and prize distribution
class TournamentEconomics {
  final double entryFee;
  final double platformFee; // 10% of entry fees
  final PrizeDistribution prizeDistribution;
  
  // 1st: 50%, 2nd: 30%, 3rd: 20% of prize pool
}
```

### **Club Revenue**
- Club membership fees
- Table booking commissions
- Event hosting fees
- Premium club features

## 🚀 GETTING STARTED

1. **Study tournament formats**: Research billiards tournament structures
2. **Design data models**: Start with Tournament and Club models
3. **Build discovery screens**: Tournament and club browsing
4. **Implement registration**: Payment integration and validation
5. **Create bracket system**: Start with single elimination
6. **Add real-time features**: Live updates and notifications

**Make tournaments and clubs the competitive heart of SABO! 🏆🎱**
