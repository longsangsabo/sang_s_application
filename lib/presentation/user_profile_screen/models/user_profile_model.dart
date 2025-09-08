import '../../../core/app_export.dart';
import '../user_profile_screen.dart';

/// This class is used in the [UserProfileScreen] screen.

// ignore_for_file: must_be_immutable
class UserProfileModel extends Equatable {
  UserProfileModel({
    this.userName,
    this.userHandle,
    this.rank,
    this.location,
    this.clubName,
    this.likesCount,
    this.messagesCount,
    this.sharesCount,
    this.postDate,
    this.postContent,
    this.profileImage,
    this.clubAvatar,
    this.isLiked,
    this.id,
  }) {
    userName = userName ?? 'Anh Long Magic';
    userHandle = userHandle ?? '@longsang';
    rank = rank ?? 'G';
    location = location ?? 'Vũng Tàu';
    clubName = clubName ?? 'SABO Billiards';
    likesCount = likesCount ?? '328.7K';
    messagesCount = messagesCount ?? '578';
    sharesCount = sharesCount ?? '99';
    postDate = postDate ?? '03-09';
    postContent = postContent ?? 'Tìm đối tối nay #sabo #rankG';
    profileImage = profileImage ?? ImageConstant.imgSaboAvatar;
    clubAvatar = clubAvatar ?? ImageConstant.imgClbAvatar;
    isLiked = isLiked ?? false;
    id = id ?? '';
  }

  String? userName;
  String? userHandle;
  String? rank;
  String? location;
  String? clubName;
  String? likesCount;
  String? messagesCount;
  String? sharesCount;
  String? postDate;
  String? postContent;
  String? profileImage;
  String? clubAvatar;
  bool? isLiked;
  String? id;

  UserProfileModel copyWith({
    String? userName,
    String? userHandle,
    String? rank,
    String? location,
    String? clubName,
    String? likesCount,
    String? messagesCount,
    String? sharesCount,
    String? postDate,
    String? postContent,
    String? profileImage,
    String? clubAvatar,
    bool? isLiked,
    String? id,
  }) {
    return UserProfileModel(
      userName: userName ?? this.userName,
      userHandle: userHandle ?? this.userHandle,
      rank: rank ?? this.rank,
      location: location ?? this.location,
      clubName: clubName ?? this.clubName,
      likesCount: likesCount ?? this.likesCount,
      messagesCount: messagesCount ?? this.messagesCount,
      sharesCount: sharesCount ?? this.sharesCount,
      postDate: postDate ?? this.postDate,
      postContent: postContent ?? this.postContent,
      profileImage: profileImage ?? this.profileImage,
      clubAvatar: clubAvatar ?? this.clubAvatar,
      isLiked: isLiked ?? this.isLiked,
      id: id ?? this.id,
    );
  }

  @override
  List<Object?> get props => [
        userName,
        userHandle,
        rank,
        location,
        clubName,
        likesCount,
        messagesCount,
        sharesCount,
        postDate,
        postContent,
        profileImage,
        clubAvatar,
        isLiked,
        id,
      ];
}
