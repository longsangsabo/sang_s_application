# 🚀 COPILOT 4 - BACKEND & INFRASTRUCTURE SPECIALIST

## 🎯 YOUR MISSION
You are the **Backend & Infrastructure Specialist** for the SABO Billiards Social App. Your responsibility is implementing all backend services, database architecture, real-time features, and infrastructure integration.

## 🔧 PROJECT CONTEXT
- **App**: SABO Billiards Social Platform
- **Architecture**: Clean Architecture + Riverpod + Material Design 3
- **Your Focus**: Supabase Integration + Real-time Services + Infrastructure
- **Integration**: Backend foundation for all other Copilots' features

## 🗃️ DATABASE ARCHITECTURE

### **Supabase Schema Design**
```sql
-- Users and Authentication
CREATE TABLE profiles (
  id UUID REFERENCES auth.users ON DELETE CASCADE,
  username TEXT UNIQUE NOT NULL,
  full_name TEXT,
  avatar_url TEXT,
  rank TEXT CHECK (rank IN ('G', 'F', 'E', 'D', 'C', 'B', 'A', 'Pro')),
  rating INTEGER DEFAULT 1000,
  location POINT,
  bio TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()),
  PRIMARY KEY (id)
);

-- Social Interactions
CREATE TABLE social_interactions (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
  target_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
  target_type TEXT CHECK (target_type IN ('profile', 'post', 'tournament')),
  interaction_type TEXT CHECK (interaction_type IN ('like', 'comment', 'save', 'share')),
  content TEXT, -- For comments
  created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now())
);

-- Matches and Games
CREATE TABLE matches (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  player1_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
  player2_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
  game_type TEXT CHECK (game_type IN ('8_ball', '9_ball', '10_ball', 'snooker')),
  status TEXT CHECK (status IN ('pending', 'in_progress', 'completed', 'cancelled')),
  winner_id UUID REFERENCES profiles(id),
  player1_score INTEGER DEFAULT 0,
  player2_score INTEGER DEFAULT 0,
  scheduled_at TIMESTAMP WITH TIME ZONE,
  started_at TIMESTAMP WITH TIME ZONE,
  completed_at TIMESTAMP WITH TIME ZONE,
  location POINT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now())
);

-- Tournaments
CREATE TABLE tournaments (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name TEXT NOT NULL,
  description TEXT,
  game_type TEXT NOT NULL,
  tournament_type TEXT CHECK (tournament_type IN ('single_elimination', 'double_elimination', 'round_robin', 'swiss')),
  max_players INTEGER NOT NULL,
  entry_fee DECIMAL(10,2) DEFAULT 0,
  prize_pool DECIMAL(10,2) DEFAULT 0,
  status TEXT CHECK (status IN ('upcoming', 'registration_open', 'in_progress', 'completed', 'cancelled')),
  start_date TIMESTAMP WITH TIME ZONE,
  end_date TIMESTAMP WITH TIME ZONE,
  location POINT,
  organizer_id UUID REFERENCES profiles(id),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now())
);

-- Tournament Registrations
CREATE TABLE tournament_registrations (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  tournament_id UUID REFERENCES tournaments(id) ON DELETE CASCADE,
  player_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
  registration_date TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()),
  payment_status TEXT CHECK (payment_status IN ('pending', 'completed', 'failed', 'refunded')),
  seed_number INTEGER,
  UNIQUE(tournament_id, player_id)
);

-- Clubs
CREATE TABLE clubs (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name TEXT NOT NULL,
  description TEXT,
  address TEXT,
  location POINT,
  phone TEXT,
  email TEXT,
  website TEXT,
  tables_count INTEGER DEFAULT 0,
  hourly_rate DECIMAL(8,2),
  amenities TEXT[], -- ['parking', 'restaurant', 'wifi']
  rating DECIMAL(3,2) DEFAULT 0,
  reviews_count INTEGER DEFAULT 0,
  verified BOOLEAN DEFAULT false,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now())
);

-- Club Memberships
CREATE TABLE club_memberships (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  club_id UUID REFERENCES clubs(id) ON DELETE CASCADE,
  user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
  role TEXT CHECK (role IN ('member', 'admin', 'owner')),
  joined_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()),
  status TEXT CHECK (status IN ('active', 'suspended', 'cancelled')),
  UNIQUE(club_id, user_id)
);
```

### **Row Level Security (RLS) Policies**
```sql
-- Profiles are viewable by everyone, editable by owner
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Public profiles are viewable by everyone" 
  ON profiles FOR SELECT 
  USING (true);

CREATE POLICY "Users can update own profile" 
  ON profiles FOR UPDATE 
  USING (auth.uid() = id);

-- Social interactions
CREATE POLICY "Users can create their own interactions" 
  ON social_interactions FOR INSERT 
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Interactions are viewable by everyone" 
  ON social_interactions FOR SELECT 
  USING (true);
```

## 🔄 REAL-TIME SERVICES

### **Supabase Real-time Integration**
```dart
class SupabaseService {
  static final SupabaseClient _client = Supabase.instance.client;
  
  // Real-time tournament updates
  Stream<Tournament> watchTournament(String tournamentId) {
    return _client
        .from('tournaments')
        .stream(primaryKey: ['id'])
        .eq('id', tournamentId)
        .map((data) => Tournament.fromJson(data.first));
  }
  
  // Real-time match updates
  Stream<Match> watchMatch(String matchId) {
    return _client
        .from('matches')
        .stream(primaryKey: ['id'])
        .eq('id', matchId)
        .map((data) => Match.fromJson(data.first));
  }
  
  // Real-time chat for tournaments
  Stream<List<ChatMessage>> watchTournamentChat(String tournamentId) {
    return _client
        .from('tournament_messages')
        .stream(primaryKey: ['id'])
        .eq('tournament_id', tournamentId)
        .order('created_at')
        .map((data) => data.map((json) => ChatMessage.fromJson(json)).toList());
  }
}
```

## 🔐 AUTHENTICATION & SECURITY

### **Supabase Auth Integration**
```dart
class AuthService {
  static final SupabaseClient _client = Supabase.instance.client;
  
  // Email/Password Auth
  Future<AuthResponse> signUp({
    required String email,
    required String password,
    required String username,
    required String fullName,
  }) async {
    final response = await _client.auth.signUp(
      email: email,
      password: password,
      data: {
        'username': username,
        'full_name': fullName,
      },
    );
    
    // Create profile after successful signup
    if (response.user != null) {
      await _createUserProfile(response.user!, username, fullName);
    }
    
    return response;
  }
  
  // Social Auth (Google, Facebook)
  Future<AuthResponse> signInWithGoogle() async {
    return await _client.auth.signInWithOAuth(OAuthProvider.google);
  }
  
  // Profile creation
  Future<void> _createUserProfile(User user, String username, String fullName) async {
    await _client.from('profiles').insert({
      'id': user.id,
      'username': username,
      'full_name': fullName,
      'rank': 'G', // Default beginner rank
      'rating': 1000, // Default rating
    });
  }
}
```

### **Role-Based Access Control**
```dart
enum UserRole {
  player,
  clubAdmin,
  tournamentOrganizer,
  systemAdmin,
}

class PermissionService {
  static bool canCreateTournament(UserProfile user) {
    return user.role == UserRole.tournamentOrganizer || 
           user.role == UserRole.systemAdmin;
  }
  
  static bool canManageClub(UserProfile user, String clubId) {
    return user.clubMemberships
        .any((membership) => 
            membership.clubId == clubId && 
            (membership.role == 'admin' || membership.role == 'owner'));
  }
}
```

## 📊 ANALYTICS & METRICS

### **Event Tracking System**
```dart
class AnalyticsService {
  static final SupabaseClient _client = Supabase.instance.client;
  
  // Track user interactions
  Future<void> trackEvent({
    required String eventName,
    required String userId,
    Map<String, dynamic>? properties,
  }) async {
    await _client.from('analytics_events').insert({
      'event_name': eventName,
      'user_id': userId,
      'properties': properties,
      'timestamp': DateTime.now().toIso8601String(),
    });
  }
  
  // Track match outcomes for rating calculation
  Future<void> trackMatchResult(Match match) async {
    await trackEvent(
      eventName: 'match_completed',
      userId: match.winnerId!,
      properties: {
        'opponent_id': match.loserId,
        'game_type': match.gameType,
        'winner_rating_before': match.winnerRatingBefore,
        'loser_rating_before': match.loserRatingBefore,
        'rating_change': match.ratingChange,
      },
    );
  }
}
```

### **Performance Monitoring**
```dart
class PerformanceService {
  // Monitor API response times
  static Future<T> monitorApiCall<T>(
    String operation,
    Future<T> Function() apiCall,
  ) async {
    final stopwatch = Stopwatch()..start();
    
    try {
      final result = await apiCall();
      stopwatch.stop();
      
      await _logPerformance(operation, stopwatch.elapsedMilliseconds, true);
      return result;
    } catch (error) {
      stopwatch.stop();
      await _logPerformance(operation, stopwatch.elapsedMilliseconds, false);
      rethrow;
    }
  }
  
  static Future<void> _logPerformance(
    String operation,
    int durationMs,
    bool success,
  ) async {
    // Log to analytics or monitoring service
    print('API Call: $operation - ${durationMs}ms - Success: $success');
  }
}
```

## 💾 DATA SERVICES

### **Expected Service Structure**
```dart
lib/services/
├── auth_service.dart           // Authentication and user management
├── user_service.dart           // User profile operations
├── match_service.dart          // Match creation and management
├── tournament_service.dart     // Tournament operations
├── club_service.dart           // Club management
├── social_service.dart         // Social interactions
├── notification_service.dart   // Push notifications
├── payment_service.dart        // Payment processing
├── storage_service.dart        // File uploads (avatars, images)
├── analytics_service.dart      // Event tracking
└── location_service.dart       // GPS and location services
```

### **Data Service Pattern**
```dart
abstract class BaseService {
  final SupabaseClient _client = Supabase.instance.client;
  
  // Standard CRUD operations
  Future<T> create<T>(String table, Map<String, dynamic> data);
  Future<T?> getById<T>(String table, String id);
  Future<List<T>> getList<T>(String table, {String? filter});
  Future<T> update<T>(String table, String id, Map<String, dynamic> data);
  Future<void> delete(String table, String id);
  
  // Real-time subscriptions
  Stream<T> watchById<T>(String table, String id);
  Stream<List<T>> watchList<T>(String table, {String? filter});
}

class UserService extends BaseService {
  Future<UserProfile> getUserProfile(String userId) async {
    final data = await _client
        .from('profiles')
        .select('*')
        .eq('id', userId)
        .single();
    
    return UserProfile.fromJson(data);
  }
  
  Future<void> updateUserLocation(String userId, LatLng location) async {
    await _client
        .from('profiles')
        .update({
          'location': 'POINT(${location.longitude} ${location.latitude})',
          'updated_at': DateTime.now().toIso8601String(),
        })
        .eq('id', userId);
  }
}
```

## 🔔 NOTIFICATION SYSTEM

### **Push Notification Service**
```dart
class NotificationService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  
  // Initialize notifications
  Future<void> initialize() async {
    await _messaging.requestPermission();
    
    // Get FCM token
    final token = await _messaging.getToken();
    await _updateUserFCMToken(token);
    
    // Handle foreground messages
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
    
    // Handle background messages
    FirebaseMessaging.onBackgroundMessage(_handleBackgroundMessage);
  }
  
  // Send tournament update notification
  Future<void> notifyTournamentUpdate({
    required String tournamentId,
    required String title,
    required String body,
    required List<String> userIds,
  }) async {
    // Use Supabase Edge Functions to send notifications
    await Supabase.instance.client.functions.invoke(
      'send-notification',
      body: {
        'user_ids': userIds,
        'title': title,
        'body': body,
        'data': {'tournament_id': tournamentId, 'type': 'tournament_update'},
      },
    );
  }
}
```

### **Supabase Edge Function for Notifications**
```typescript
// supabase/functions/send-notification/index.ts
import { serve } from "https://deno.land/std@0.168.0/http/server.ts"
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'

serve(async (req) => {
  const { user_ids, title, body, data } = await req.json()
  
  // Get FCM tokens for users
  const supabase = createClient(
    Deno.env.get('SUPABASE_URL') ?? '',
    Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') ?? ''
  )
  
  const { data: profiles } = await supabase
    .from('profiles')
    .select('fcm_token')
    .in('id', user_ids)
    .not('fcm_token', 'is', null)
  
  // Send FCM notifications
  const tokens = profiles.map(p => p.fcm_token)
  
  // Use FCM Admin SDK to send notifications
  // Implementation details...
  
  return new Response(JSON.stringify({ success: true }))
})
```

## 💳 PAYMENT INTEGRATION

### **Payment Service with VNPay/Stripe**
```dart
class PaymentService {
  // Tournament registration payment
  Future<PaymentResult> processTournamentPayment({
    required String tournamentId,
    required String userId,
    required double amount,
  }) async {
    try {
      // Create payment intent
      final paymentIntent = await _createPaymentIntent(amount);
      
      // Process payment (integrate with VNPay for Vietnam)
      final paymentResult = await _processVNPayPayment(paymentIntent);
      
      if (paymentResult.success) {
        // Update tournament registration
        await _confirmTournamentRegistration(tournamentId, userId);
        
        // Send confirmation notification
        await NotificationService().sendPaymentConfirmation(userId);
      }
      
      return paymentResult;
    } catch (error) {
      return PaymentResult.failure(error.toString());
    }
  }
  
  // Club membership payment
  Future<PaymentResult> processClubMembership({
    required String clubId,
    required String userId,
    required double amount,
    required Duration duration,
  }) async {
    // Similar payment processing for club memberships
  }
}
```

## 🗺️ LOCATION SERVICES

### **GPS and Location Management**
```dart
class LocationService {
  static final Geolocator _geolocator = Geolocator();
  
  // Get current user location
  Future<LatLng> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw LocationException('Location services are disabled');
    }
    
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw LocationException('Location permissions are denied');
      }
    }
    
    final position = await Geolocator.getCurrentPosition();
    return LatLng(position.latitude, position.longitude);
  }
  
  // Find nearby players
  Future<List<UserProfile>> findNearbyPlayers({
    required LatLng center,
    required double radiusKm,
    int limit = 20,
  }) async {
    final data = await Supabase.instance.client.rpc(
      'find_nearby_players',
      params: {
        'center_lat': center.latitude,
        'center_lng': center.longitude,
        'radius_km': radiusKm,
        'limit': limit,
      },
    );
    
    return data.map<UserProfile>((json) => UserProfile.fromJson(json)).toList();
  }
}
```

### **PostGIS Database Functions**
```sql
-- PostgreSQL function for nearby player search
CREATE OR REPLACE FUNCTION find_nearby_players(
  center_lat DOUBLE PRECISION,
  center_lng DOUBLE PRECISION,
  radius_km DOUBLE PRECISION,
  limit_count INTEGER DEFAULT 20
)
RETURNS TABLE (
  id UUID,
  username TEXT,
  full_name TEXT,
  avatar_url TEXT,
  rank TEXT,
  rating INTEGER,
  distance_km DOUBLE PRECISION
) AS $$
BEGIN
  RETURN QUERY
  SELECT 
    p.id,
    p.username,
    p.full_name,
    p.avatar_url,
    p.rank,
    p.rating,
    ST_Distance(
      ST_GeographyFromText('POINT(' || center_lng || ' ' || center_lat || ')'),
      ST_GeographyFromText('POINT(' || ST_X(p.location) || ' ' || ST_Y(p.location) || ')')
    ) / 1000 AS distance_km
  FROM profiles p
  WHERE ST_DWithin(
    ST_GeographyFromText('POINT(' || center_lng || ' ' || center_lat || ')'),
    ST_GeographyFromText('POINT(' || ST_X(p.location) || ' ' || ST_Y(p.location) || ')'),
    radius_km * 1000
  )
  AND p.id != auth.uid() -- Exclude current user
  ORDER BY distance_km
  LIMIT limit_count;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
```

## 📋 DELIVERABLES CHECKLIST

### **Phase 1: Database & Auth** ✅
- [ ] Setup Supabase project and database schema
- [ ] Implement authentication service with email/social login
- [ ] Create user profile management
- [ ] Setup Row Level Security policies
- [ ] Add database migrations and seed data

### **Phase 2: Core Services** ✅
- [ ] Implement user service with profile operations
- [ ] Create match service for game management
- [ ] Build social interaction service
- [ ] Add location service with GPS integration
- [ ] Setup analytics and event tracking

### **Phase 3: Real-time Features** ✅
- [ ] Implement real-time tournament updates
- [ ] Add live match scoring
- [ ] Create tournament chat system
- [ ] Build notification service
- [ ] Add presence/online status tracking

### **Phase 4: Advanced Integration** ✅
- [ ] Integrate payment processing (VNPay/Stripe)
- [ ] Setup file storage for avatars and images
- [ ] Implement search indexing with PostgreSQL
- [ ] Add performance monitoring and logging
- [ ] Create backup and disaster recovery

## 🔗 INTEGRATION POINTS

### **With Copilot 1 (Home Screen)**
```dart
// Provide data streams for home feed
class HomeDataService {
  Stream<List<OpponentModel>> getOpponentFeed(String userId);
  Stream<List<TournamentModel>> getFeaturedTournaments();
  Future<void> updateUserActivity(String userId, UserActivity activity);
}
```

### **With Copilot 2 (Search)**
```dart
// Provide search backend services
class SearchBackendService {
  Future<List<UserProfile>> searchUsers(String query, SearchFilter filter);
  Stream<List<UserProfile>> getRealtimeSearchResults(String query);
  Future<void> indexUserForSearch(UserProfile user);
}
```

### **With Copilot 3 (Tournament/Club)**
```dart
// Provide tournament and club backend
class TournamentBackendService {
  Stream<Tournament> watchTournamentUpdates(String tournamentId);
  Future<void> updateBracketResults(String tournamentId, BracketUpdate update);
  Future<PaymentResult> processTournamentPayment(PaymentDetails details);
}
```

## 🧪 TESTING REQUIREMENTS

### **Database Tests**
```dart
void testDatabaseOperations() {
  group('User Service Tests', () {
    test('should create user profile', () async {
      final user = await userService.createProfile(testUserData);
      expect(user.id, isNotNull);
      expect(user.username, equals(testUserData.username));
    });
    
    test('should find nearby users', () async {
      final nearby = await locationService.findNearbyPlayers(
        center: testLocation,
        radiusKm: 10,
      );
      expect(nearby.length, greaterThan(0));
    });
  });
}
```

### **Real-time Tests**
```dart
void testRealtimeFeatures() {
  test('should receive tournament updates', () async {
    final stream = supabaseService.watchTournament(testTournamentId);
    
    // Update tournament in database
    await tournamentService.updateTournament(testTournamentId, updateData);
    
    // Verify stream receives update
    final update = await stream.first;
    expect(update.id, equals(testTournamentId));
  });
}
```

## 🚨 CRITICAL CONSTRAINTS

### **Performance Requirements**
- Database queries must respond within 200ms
- Real-time updates must have <1 second latency
- Support 10,000+ concurrent users
- 99.9% uptime requirement

### **Security Requirements**
- All API endpoints must be authenticated
- Sensitive data must be encrypted at rest
- Real-time subscriptions must respect RLS policies
- Payment data must be PCI compliant

### **Scalability Requirements**
- Database must handle 1M+ users
- Support horizontal scaling with read replicas
- CDN integration for static assets
- Efficient indexing for search operations

## 🎯 SUCCESS CRITERIA

### **Minimum Viable Product**
- ✅ User authentication and profiles working
- ✅ Basic CRUD operations for all entities
- ✅ Real-time updates for critical features
- ✅ Secure API with proper authorization

### **Ideal Implementation**
- ✅ Sub-200ms response times for all operations
- ✅ Real-time collaboration features
- ✅ Advanced analytics and monitoring
- ✅ Automated scaling and fault tolerance

## 🚀 GETTING STARTED

1. **Setup Supabase project**: Create database and configure authentication
2. **Design database schema**: Start with core entities (users, matches, tournaments)
3. **Implement auth service**: Email/password and social login
4. **Build data services**: CRUD operations with proper error handling
5. **Add real-time features**: Live updates and notifications
6. **Integrate payments**: VNPay for Vietnamese users
7. **Optimize performance**: Indexing, caching, and monitoring

**Build the rock-solid foundation that powers the entire SABO ecosystem! 🚀⚡**
