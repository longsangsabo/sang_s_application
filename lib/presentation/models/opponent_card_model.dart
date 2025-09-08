import '../../core/app_export.dart';
import 'social_interaction_model.dart';

/// Model representing an opponent card in the home feed
class OpponentCardModel extends Equatable {
  const OpponentCardModel({
    required this.id,
    required this.userName,
    required this.userHandle,
    required this.rank,
    required this.location,
    required this.clubName,
    required this.profileImage,
    required this.clubAvatar,
    required this.postDate,
    required this.postContent,
    required this.socialInteraction,
    this.elo = 0,
    this.isOnline = false,
    this.lastActiveTime,
    this.gamePreferences = const [],
    this.availableTimeSlots = const [],
  });

  /// Unique identifier for the opponent
  final String id;
  
  /// Display name of the opponent
  final String userName;
  
  /// Social handle (e.g., @username)
  final String userHandle;
  
  /// Game rank (G, A, B, C, etc.)
  final String rank;
  
  /// Location/city
  final String location;
  
  /// Club name
  final String clubName;
  
  /// Profile image path/URL
  final String profileImage;
  
  /// Club avatar path/URL
  final String clubAvatar;
  
  /// Post date/time
  final String postDate;
  
  /// Post content/caption
  final String postContent;
  
  /// Social interaction data (likes, comments, shares)
  final SocialInteractionModel socialInteraction;
  
  /// ELO rating
  final int elo;
  
  /// Whether the opponent is currently online
  final bool isOnline;
  
  /// Last time the opponent was active
  final DateTime? lastActiveTime;
  
  /// Preferred game types
  final List<String> gamePreferences;
  
  /// Available time slots for scheduling games
  final List<String> availableTimeSlots;

  /// Create a copy with updated values
  OpponentCardModel copyWith({
    String? id,
    String? userName,
    String? userHandle,
    String? rank,
    String? location,
    String? clubName,
    String? profileImage,
    String? clubAvatar,
    String? postDate,
    String? postContent,
    SocialInteractionModel? socialInteraction,
    int? elo,
    bool? isOnline,
    DateTime? lastActiveTime,
    List<String>? gamePreferences,
    List<String>? availableTimeSlots,
  }) {
    return OpponentCardModel(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      userHandle: userHandle ?? this.userHandle,
      rank: rank ?? this.rank,
      location: location ?? this.location,
      clubName: clubName ?? this.clubName,
      profileImage: profileImage ?? this.profileImage,
      clubAvatar: clubAvatar ?? this.clubAvatar,
      postDate: postDate ?? this.postDate,
      postContent: postContent ?? this.postContent,
      socialInteraction: socialInteraction ?? this.socialInteraction,
      elo: elo ?? this.elo,
      isOnline: isOnline ?? this.isOnline,
      lastActiveTime: lastActiveTime ?? this.lastActiveTime,
      gamePreferences: gamePreferences ?? this.gamePreferences,
      availableTimeSlots: availableTimeSlots ?? this.availableTimeSlots,
    );
  }

  /// Factory method to create from JSON
  factory OpponentCardModel.fromJson(Map<String, dynamic> json) {
    return OpponentCardModel(
      id: json['id'] ?? '',
      userName: json['userName'] ?? '',
      userHandle: json['userHandle'] ?? '',
      rank: json['rank'] ?? '',
      location: json['location'] ?? '',
      clubName: json['clubName'] ?? '',
      profileImage: json['profileImage'] ?? '',
      clubAvatar: json['clubAvatar'] ?? '',
      postDate: json['postDate'] ?? '',
      postContent: json['postContent'] ?? '',
      socialInteraction: SocialInteractionModel.fromJson(
        json['socialInteraction'] ?? {},
      ),
      elo: json['elo'] ?? 0,
      isOnline: json['isOnline'] ?? false,
      lastActiveTime: json['lastActiveTime'] != null
          ? DateTime.tryParse(json['lastActiveTime'])
          : null,
      gamePreferences: List<String>.from(json['gamePreferences'] ?? []),
      availableTimeSlots: List<String>.from(json['availableTimeSlots'] ?? []),
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userName': userName,
      'userHandle': userHandle,
      'rank': rank,
      'location': location,
      'clubName': clubName,
      'profileImage': profileImage,
      'clubAvatar': clubAvatar,
      'postDate': postDate,
      'postContent': postContent,
      'socialInteraction': socialInteraction.toJson(),
      'elo': elo,
      'isOnline': isOnline,
      'lastActiveTime': lastActiveTime?.toIso8601String(),
      'gamePreferences': gamePreferences,
      'availableTimeSlots': availableTimeSlots,
    };
  }

  @override
  List<Object?> get props => [
        id,
        userName,
        userHandle,
        rank,
        location,
        clubName,
        profileImage,
        clubAvatar,
        postDate,
        postContent,
        socialInteraction,
        elo,
        isOnline,
        lastActiveTime,
        gamePreferences,
        availableTimeSlots,
      ];

  @override
  String toString() {
    return 'OpponentCardModel(id: $id, userName: $userName, rank: $rank, location: $location)';
  }
}

/// Mock data factory for development and testing
class OpponentCardModelFactory {
  static List<OpponentCardModel> createMockOpponents() {
    return [
      OpponentCardModel(
        id: 'opp_001',
        userName: 'Anh Long Magic',
        userHandle: '@longsang',
        rank: 'G',
        location: 'Vũng Tàu',
        clubName: 'SABO Billiards',
        profileImage: ImageConstant.imgSaboAvatar,
        clubAvatar: ImageConstant.imgClbAvatar,
        postDate: '03-09',
        postContent: 'Tìm đối tối nay #sabo #rankG',
        socialInteraction: const SocialInteractionModel(
          likesCount: 328700,
          commentsCount: 578,
          sharesCount: 99,
          isLiked: false,
          isSaved: false,
        ),
        elo: 1485,
        isOnline: true,
        gamePreferences: ['8-Ball', '9-Ball'],
        availableTimeSlots: ['19:00-21:00', '21:00-23:00'],
      ),
      OpponentCardModel(
        id: 'opp_002',
        userName: 'Phạm Minh Tuấn',
        userHandle: '@minhtuan',
        rank: 'A',
        location: 'Hồ Chí Minh',
        clubName: 'Platinum Billiards',
        profileImage: ImageConstant.imgSaboAvatar, // Reusing for demo
        clubAvatar: ImageConstant.imgClbAvatar,
        postDate: '02-09',
        postContent: 'Thách đấu rank A+ #challenge #8ball',
        socialInteraction: const SocialInteractionModel(
          likesCount: 156000,
          commentsCount: 234,
          sharesCount: 45,
          isLiked: false,
          isSaved: false,
        ),
        elo: 2100,
        isOnline: false,
        lastActiveTime: DateTime.now().subtract(Duration(hours: 2)),
        gamePreferences: ['8-Ball', 'Straight Pool'],
        availableTimeSlots: ['18:00-20:00'],
      ),
      OpponentCardModel(
        id: 'opp_003',
        userName: 'Nguyễn Thanh Hà',
        userHandle: '@thanhha',
        rank: 'B',
        location: 'Hà Nội',
        clubName: 'Elite Cue Sports',
        profileImage: ImageConstant.imgSaboAvatar,
        clubAvatar: ImageConstant.imgClbAvatar,
        postDate: '01-09',
        postContent: 'Luyện tập mỗi ngày 💪 #practice #dedicated',
        socialInteraction: const SocialInteractionModel(
          likesCount: 89500,
          commentsCount: 167,
          sharesCount: 23,
          isLiked: true,
          isSaved: false,
        ),
        elo: 1750,
        isOnline: true,
        gamePreferences: ['9-Ball', '10-Ball'],
        availableTimeSlots: ['20:00-22:00'],
      ),
      OpponentCardModel(
        id: 'opp_004',
        userName: 'Trần Quốc Việt',
        userHandle: '@quocviet',
        rank: 'C',
        location: 'Đà Nẵng',
        clubName: 'Ocean Billiards',
        profileImage: ImageConstant.imgSaboAvatar,
        clubAvatar: ImageConstant.imgClbAvatar,
        postDate: '31-08',
        postContent: 'Ai muốn chơi friendly match? 🎱',
        socialInteraction: const SocialInteractionModel(
          likesCount: 42300,
          commentsCount: 89,
          sharesCount: 12,
          isLiked: false,
          isSaved: true,
        ),
        elo: 1350,
        isOnline: false,
        lastActiveTime: DateTime.now().subtract(Duration(minutes: 30)),
        gamePreferences: ['8-Ball'],
        availableTimeSlots: ['19:30-21:30'],
      ),
      OpponentCardModel(
        id: 'opp_005',
        userName: 'Lê Hoàng Nam',
        userHandle: '@hoangnam',
        rank: 'G',
        location: 'Cần Thơ',
        clubName: 'Mekong Billiards',
        profileImage: ImageConstant.imgSaboAvatar,
        clubAvatar: ImageConstant.imgClbAvatar,
        postDate: '30-08',
        postContent: 'Tournament prep mode 🔥 #tournament #ready',
        socialInteraction: const SocialInteractionModel(
          likesCount: 67800,
          commentsCount: 134,
          sharesCount: 28,
          isLiked: false,
          isSaved: false,
        ),
        elo: 1520,
        isOnline: true,
        gamePreferences: ['8-Ball', '9-Ball', '10-Ball'],
        availableTimeSlots: ['17:00-19:00', '21:00-23:00'],
      ),
    ];
  }

  static OpponentCardModel createRandomOpponent(int index) {
    final names = [
      'Anh Tuấn Pro', 'Minh Châu', 'Quang Huy', 'Thanh Tùng', 
      'Hoàng Việt', 'Minh Khôi', 'Đức Anh', 'Thành Đạt'
    ];
    final locations = ['TPHCM', 'Hà Nội', 'Đà Nẵng', 'Hải Phòng', 'Cần Thơ'];
    final ranks = ['G', 'A', 'B', 'C'];
    final clubs = ['SABO Billiards', 'Elite Cue', 'Pro Billiards', 'Champion Club'];

    return OpponentCardModel(
      id: 'opp_${index.toString().padLeft(3, '0')}',
      userName: names[index % names.length],
      userHandle: '@user${index}',
      rank: ranks[index % ranks.length],
      location: locations[index % locations.length],
      clubName: clubs[index % clubs.length],
      profileImage: ImageConstant.imgSaboAvatar,
      clubAvatar: ImageConstant.imgClbAvatar,
      postDate: '${(30 - (index % 30)).toString().padLeft(2, '0')}-08',
      postContent: 'Tìm đối chơi friendly match! #billiards #fun',
      socialInteraction: SocialInteractionModel(
        likesCount: (1000 + (index * 123)) % 100000,
        commentsCount: (50 + (index * 7)) % 500,
        sharesCount: (10 + (index * 3)) % 100,
        isLiked: index % 5 == 0,
        isSaved: index % 7 == 0,
      ),
      elo: 1200 + (index * 25) % 800,
      isOnline: index % 3 == 0,
      gamePreferences: ['8-Ball', '9-Ball'],
      availableTimeSlots: ['19:00-21:00'],
    );
  }
}
