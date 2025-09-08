import '../../../core/app_export.dart';

/// Model to manage social interaction states
class SocialInteractionModel extends Equatable {
  const SocialInteractionModel({
    this.isLiked = false,
    this.isSaved = false,
    this.likesCount = 0,
    this.commentsCount = 0,
    this.sharesCount = 0,
    this.id,
  });

  /// Whether the item is currently liked by the user
  final bool isLiked;
  
  /// Whether the item is currently saved/bookmarked by the user
  final bool isSaved;
  
  /// Total number of likes
  final int likesCount;
  
  /// Total number of comments
  final int commentsCount;
  
  /// Total number of shares
  final int sharesCount;
  
  /// Unique identifier for the item
  final String? id;

  /// Create a copy with updated values
  SocialInteractionModel copyWith({
    bool? isLiked,
    bool? isSaved,
    int? likesCount,
    int? commentsCount,
    int? sharesCount,
    String? id,
  }) {
    return SocialInteractionModel(
      isLiked: isLiked ?? this.isLiked,
      isSaved: isSaved ?? this.isSaved,
      likesCount: likesCount ?? this.likesCount,
      commentsCount: commentsCount ?? this.commentsCount,
      sharesCount: sharesCount ?? this.sharesCount,
      id: id ?? this.id,
    );
  }

  /// Toggle like state and update count
  SocialInteractionModel toggleLike() {
    return copyWith(
      isLiked: !isLiked,
      likesCount: isLiked ? likesCount - 1 : likesCount + 1,
    );
  }

  /// Toggle save state
  SocialInteractionModel toggleSave() {
    return copyWith(
      isSaved: !isSaved,
    );
  }

  /// Increment shares count
  SocialInteractionModel incrementShares() {
    return copyWith(
      sharesCount: sharesCount + 1,
    );
  }

  /// Increment comments count
  SocialInteractionModel incrementComments() {
    return copyWith(
      commentsCount: commentsCount + 1,
    );
  }

  /// Factory method to create from JSON
  factory SocialInteractionModel.fromJson(Map<String, dynamic> json) {
    return SocialInteractionModel(
      isLiked: json['isLiked'] ?? false,
      isSaved: json['isSaved'] ?? false,
      likesCount: json['likesCount'] ?? 0,
      commentsCount: json['commentsCount'] ?? 0,
      sharesCount: json['sharesCount'] ?? 0,
      id: json['id'],
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'isLiked': isLiked,
      'isSaved': isSaved,
      'likesCount': likesCount,
      'commentsCount': commentsCount,
      'sharesCount': sharesCount,
      'id': id,
    };
  }

  @override
  List<Object?> get props => [
        isLiked,
        isSaved,
        likesCount,
        commentsCount,
        sharesCount,
        id,
      ];

  @override
  String toString() {
    return 'SocialInteractionModel(isLiked: $isLiked, isSaved: $isSaved, likesCount: $likesCount, commentsCount: $commentsCount, sharesCount: $sharesCount, id: $id)';
  }
}
