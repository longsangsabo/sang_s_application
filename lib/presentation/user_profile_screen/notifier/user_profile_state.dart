part of 'user_profile_notifier.dart';

class UserProfileState extends Equatable {
  final UserProfileModel? userProfileModel;
  final bool isLoading;

  const UserProfileState({
    this.userProfileModel,
    this.isLoading = false,
  });

  @override
  List<Object?> get props => [
        userProfileModel,
        isLoading,
      ];

  UserProfileState copyWith({
    UserProfileModel? userProfileModel,
    bool? isLoading,
  }) {
    return UserProfileState(
      userProfileModel: userProfileModel ?? this.userProfileModel,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
