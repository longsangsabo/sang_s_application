import '../models/user_profile_model.dart';
import '../../../core/app_export.dart';

part 'user_profile_state.dart';

final userProfileNotifier =
    StateNotifierProvider.autoDispose<UserProfileNotifier, UserProfileState>(
  (ref) => UserProfileNotifier(
    UserProfileState(
      userProfileModel: UserProfileModel(),
    ),
  ),
);

class UserProfileNotifier extends StateNotifier<UserProfileState> {
  UserProfileNotifier(UserProfileState state) : super(state) {
    initialize();
  }

  void initialize() {
    state = state.copyWith(
      userProfileModel: UserProfileModel(
        userName: 'Anh Long Magic',
        userHandle: '@longsang',
        rank: 'G',
        location: 'Vũng Tàu',
        clubName: 'SABO Billiards',
        likesCount: '328.7K',
        messagesCount: '578',
        sharesCount: '99',
        postDate: '03-09',
        postContent: 'Tìm đối tối nay #sabo #rankG',
        profileImage: ImageConstant.imgSaboAvatar,
        clubAvatar: ImageConstant.imgClbAvatar,
      ),
    );
  }

  void onLikePressed() {
    final currentModel = state.userProfileModel;
    if (currentModel != null) {
      state = state.copyWith(
        userProfileModel: currentModel.copyWith(
          isLiked: !(currentModel.isLiked ?? false),
        ),
      );
    }
  }

  void onSharePressed() {
    // Handle share functionality
  }

  void onMessagePressed() {
    // Handle message functionality
  }

  void onPlayNowPressed() {
    // Handle play now functionality
  }

  void onSchedulePressed() {
    // Handle schedule functionality
  }
}
