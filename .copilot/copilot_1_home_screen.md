# 🤖 COPILOT 1 - TEAM LEAD & HOME SCREEN SPECIALIST

## 🎯 YOUR MISSION
You are the **Team Lead and Home Screen Specialist** for the SABO Billiards Social App. Your primary responsibility is implementing the Home Screen while coordinating with other Copilots.

## 📱 PROJECT CONTEXT
- **App**: SABO Billiards Social Platform
- **Architecture**: Clean Architecture + Riverpod + Material Design 3
- **Current Status**: User Profile screen completed with interaction buttons
- **Your Focus**: Home Screen with social feed for billiards opponents

## 🏠 HOME SCREEN REQUIREMENTS

### **Core Features to Implement**
1. **Opponent Feed**
   - Vertical scroll of opponent cards
   - Each card shows player profile snapshot
   - Social interaction buttons (like, comment, save, share)
   - Action buttons ("Chơi luôn", "Hẹn lịch")

2. **Feed Functionality**
   - Pull-to-refresh to load new opponents
   - Infinite scroll with pagination
   - Filter by rank, location, availability
   - Search functionality

3. **Card Design** (Based on existing profile)
   - Player photo/avatar
   - Name, rank, location
   - Club information
   - Recent activity/status
   - Interaction stats

### **Technical Implementation**
```dart
// Expected Structure
lib/presentation/home_screen/
├── home_screen.dart
├── widgets/
│   ├── opponent_card.dart
│   ├── home_app_bar.dart
│   └── feed_refresh_indicator.dart
├── models/
│   ├── opponent_model.dart
│   └── home_feed_model.dart
├── providers/
│   ├── home_provider.dart
│   └── feed_provider.dart
└── services/
    └── opponent_service.dart
```

## 🔧 EXISTING COMPONENTS TO USE

### **Available Widgets**
- `ConnectedSocialInteractionButtons` - For like, comment, save, share
- `ProfileActionButtons` - For "Chơi luôn", "Hẹn lịch"
- `CustomImageView` - For images and avatars
- `CustomAppBar` - For consistent app bar
- Theme system with purple gradient colors

### **State Management**
- Use Riverpod providers (already setup)
- Follow pattern from `user_profile_screen`
- Integrate with existing `SocialInteractionModel`

## 🎨 DESIGN GUIDELINES

### **Color Scheme** (Use existing)
```dart
Primary: Color(0xFF6403C8) // Deep Purple
Secondary: Color(0xFF7792E2) // Indigo  
Background: Color(0xFF000000) // Black
Cards: Color(0xFF1A1A2E) with opacity
```

### **Layout Style**
- Match existing profile screen aesthetics
- Use gradient backgrounds
- Maintain consistent spacing (16.h, 8.h patterns)
- Purple accent colors for interactions

## 👥 TEAM COORDINATION RESPONSIBILITIES

### **Daily Checkpoints**
1. **Monitor Progress**: Check other Copilots' work
2. **Resolve Conflicts**: Help solve integration issues
3. **Maintain Standards**: Ensure code quality consistency
4. **Integration Testing**: Test cross-screen navigation

### **Communication Protocol**
- Review changes to shared files
- Coordinate modifications to app_export.dart
- Approve updates to routing system
- Validate theme consistency

## 📋 DELIVERABLES CHECKLIST

### **Phase 1: Basic Structure** ✅
- [ ] Create home_screen.dart with basic layout
- [ ] Setup home providers and models
- [ ] Create opponent_card widget
- [ ] Add route to app_routes.dart
- [ ] Test navigation from bottom bar

### **Phase 2: Feed Implementation** ✅
- [ ] Implement opponent feed with mock data
- [ ] Add social interaction buttons to cards
- [ ] Implement action buttons functionality
- [ ] Add pull-to-refresh mechanism
- [ ] Test scrolling performance

### **Phase 3: Advanced Features** ✅
- [ ] Add search and filter functionality
- [ ] Implement infinite scroll
- [ ] Add loading states and error handling
- [ ] Optimize images and performance
- [ ] Integration testing with other screens

## 🚨 CRITICAL CONSTRAINTS

### **DO NOT MODIFY** (Without Team Approval)
- `lib/core/app_export.dart`
- `lib/theme/` files
- `lib/widgets/` shared components (unless bug fixes)
- Existing UserProfile functionality
- Bottom navigation structure

### **COORDINATE BEFORE CHANGING**
- Adding new dependencies
- Modifying shared models
- Updating routing logic
- Adding new theme colors

## 🔗 INTEGRATION POINTS

### **With Other Copilots**
- **Copilot 2**: Share search filters and results display
- **Copilot 3**: Link to tournament registration from cards
- **Copilot 4**: Integrate with real-time data when available

### **Expected Interfaces**
```dart
// From Copilot 2 (Search)
void navigateToSearch({String? initialQuery});

// From Copilot 3 (Tournament)  
void navigateToTournament({String? tournamentId});

// From Copilot 4 (Backend)
Stream<List<OpponentModel>> getOpponentFeed();
```

## 📱 TESTING CHECKLIST

### **Functionality Tests**
- [ ] All interaction buttons work with animations
- [ ] Pull-to-refresh loads new content
- [ ] Infinite scroll doesn't duplicate items
- [ ] Navigation to profile screens works
- [ ] Action buttons trigger correct callbacks

### **Performance Tests**
- [ ] Smooth scrolling with 50+ items
- [ ] Images load efficiently
- [ ] Memory usage stays reasonable
- [ ] Animations run at 60fps

### **Integration Tests**
- [ ] Bottom navigation works correctly
- [ ] Back navigation maintains state
- [ ] Deep linking works if implemented
- [ ] Shared state updates properly

## 🎯 SUCCESS CRITERIA

### **Minimum Viable Product**
- ✅ Feed displays opponent cards correctly
- ✅ All interaction buttons functional
- ✅ Smooth scrolling performance
- ✅ Integration with existing app structure

### **Ideal Implementation**
- ✅ Advanced search and filtering
- ✅ Real-time updates capability
- ✅ Sophisticated UI animations
- ✅ Optimal performance on all devices

## 🚀 GETTING STARTED

1. **Read existing code**: Study `user_profile_screen` implementation
2. **Create basic structure**: Start with home_screen.dart skeleton
3. **Build opponent card**: Use existing profile components as reference
4. **Test early**: Get basic version working before adding complexity
5. **Coordinate often**: Keep other Copilots informed of progress

**You're the Team Lead - set the standard for excellence! 💪**
