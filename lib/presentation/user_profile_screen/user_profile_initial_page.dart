import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../widgets/custom_image_view.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_icon_button.dart';
import 'notifier/user_profile_notifier.dart';

class UserProfileInitialPage extends ConsumerStatefulWidget {
  const UserProfileInitialPage({Key? key}) : super(key: key);

  @override
  UserProfileInitialPageState createState() => UserProfileInitialPageState();
}

class UserProfileInitialPageState extends ConsumerState<UserProfileInitialPage>
    with SingleTickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(userProfileNotifier);

    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Stack(
          children: [
            CustomImageView(
              imagePath: ImageConstant.imgAvatarBackground,
              height: double.maxFinite,
              width: double.maxFinite,
              fit: BoxFit.cover,
            ),
            Column(
              children: [
                _buildAppBar(context),
                _buildTabBar(context),
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      _buildOpponentTab(context),
                      _buildTournamentTab(context),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      title: 'SABO',
      gradientColors: [Color(0xFF6403C8), Color(0xFF0414AC)],
      actionIcons: [
        ImageConstant.imgButomSun,
        ImageConstant.imgButtonMessages,
        ImageConstant.imgButtonNotifications
      ],
      onActionTap: (index) {
        switch (index) {
          case 0:
            // Handle sun/theme toggle
            break;
          case 1:
            // Handle messages
            break;
          case 2:
            // Handle notifications
            break;
        }
      },
    );
  }

  Widget _buildTabBar(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 92.h, vertical: 12.h),
      child: TabBar(
        controller: tabController,
        labelColor: appTheme.whiteCustom,
        unselectedLabelColor: appTheme.colorCCD7D7,
        labelStyle: TextStyleHelper.instance.title16BoldLexendExa,
        unselectedLabelStyle: TextStyleHelper.instance.title16BoldLexendExa,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(color: appTheme.whiteCustom, width: 2.h),
        ),
        tabs: [
          Tab(text: 'Đối thủ '),
          Tab(text: 'Giải đấu'),
        ],
      ),
    );
  }

  Widget _buildOpponentTab(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 4.h),
      child: Column(
        children: [
          _buildUserProfileCard(context),
          SizedBox(height: 30.h),
          _buildRankAndActions(context),
          SizedBox(height: 12.h),
          _buildInteractionStats(context),
          SizedBox(height: 16.h),
          _buildUserInfo(context),
        ],
      ),
    );
  }

  Widget _buildTournamentTab(BuildContext context) {
    return Center(
      child: Text(
        'Giải đấu content',
        style: TextStyleHelper.instance.title16,
      ),
    );
  }

  Widget _buildUserProfileCard(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 32.h),
      width: 300.h,
      height: 294.h,
      child: Stack(
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgSaboAvatar,
            height: 292.h,
            width: 296.h,
            radius: BorderRadius.circular(16.h),
            margin: EdgeInsets.only(left: 2.h, top: 1.h),
          ),
          Container(
            width: 300.h,
            height: 294.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18.h),
              gradient: LinearGradient(
                begin: Alignment(0.165, -1.0),
                end: Alignment(-0.165, 1.0),
                colors: [
                  Color(0xF8667784),
                  appTheme.color26331B,
                  appTheme.colorF866C6,
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: double.maxFinite,
                  padding:
                      EdgeInsets.symmetric(horizontal: 31.h, vertical: 4.h),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0x00000000),
                        appTheme.colorCC0000,
                      ],
                    ),
                  ),
                  child: Text(
                    'Anh Long Magic',
                    style: TextStyleHelper.instance.display40BlackAlumniSans
                        .copyWith(letterSpacing: 3.h),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRankAndActions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgContainer,
                height: 14.h,
                width: 14.h,
              ),
              SizedBox(width: 14.h),
              Text(
                ' RANK : G',
                style: TextStyleHelper.instance.headline28SemiBoldRoboto,
              ),
            ],
          ),
        ),
        CustomImageView(
          imagePath: ImageConstant.imgIconAvatar,
          height: 58.h,
          width: 46.h,
          margin: EdgeInsets.only(top: 10.h),
        ),
      ],
    );
  }

  Widget _buildInteractionStats(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildActionButtons(context),
              SizedBox(height: 18.h),
              _buildScheduleAction(context),
              SizedBox(height: 14.h),
              _buildClubInfo(context),
            ],
          ),
        ),
        SizedBox(width: 12.h),
        _buildSocialStats(context),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 2.h),
      child: Stack(
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgSword2,
            height: 48.h,
            width: 50.h,
          ),
          Positioned(
            right: 10.h,
            top: 4.h,
            child: CustomImageView(
              imagePath: ImageConstant.imgSword1,
              height: 38.h,
              width: 40.h,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlayNowText(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 17.h),
      child: Text(
        'Chơi luôn',
        style: TextStyleHelper.instance.body13RegularABeeZee.copyWith(shadows: [
          Shadow(
            color: appTheme.color4C0000,
            offset: Offset(1, 1),
            blurRadius: 1,
          ),
        ]),
      ),
    );
  }

  Widget _buildScheduleAction(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomImageView(
          imagePath: ImageConstant.imgIcon,
          height: 44.h,
          width: 44.h,
          margin: EdgeInsets.only(left: 8.h),
        ),
        SizedBox(height: 1.h),
        Container(
          margin: EdgeInsets.only(left: 2.h),
          child: Text(
            'Lên lịch',
            style: TextStyleHelper.instance.body14RegularABeeZee
                .copyWith(shadows: [
              Shadow(
                color: appTheme.color4C0000,
                offset: Offset(1, 1),
                blurRadius: 1,
              ),
            ]),
          ),
        ),
      ],
    );
  }

  Widget _buildClubInfo(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 6.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgClbAvatar,
            height: 60.h,
            width: 50.h,
          ),
          SizedBox(width: 16.h),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'SABO Billiards',
                  style: TextStyleHelper.instance.title20RegularAldrich,
                ),
                SizedBox(height: 8.h),
                CustomIconButton(
                  text: 'Vũng Tàu',
                  leftIcon: ImageConstant.imgIconLocation,
                  backgroundColor: appTheme.cyan_900,
                  textColor: appTheme.whiteCustom,
                  borderRadius: 5.h,
                  fontSize: 14.fSize,
                  padding: EdgeInsets.only(top: 2.h, right: 10.h, bottom: 2.h),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialStats(BuildContext context) {
    return Column(
      children: [
        _buildStatItem(
          icon: ImageConstant.imgHeartIcon,
          count: '328.7K',
        ),
        SizedBox(height: 24.h),
        _buildStatItem(
          icon: ImageConstant.imgMessageIcon,
          count: '578',
        ),
        SizedBox(height: 20.h),
        _buildStatItem(
          icon: ImageConstant.imgShareIcon,
          count: '99',
        ),
      ],
    );
  }

  Widget _buildStatItem({required String icon, required String count}) {
    return Column(
      children: [
        CustomImageView(
          imagePath: icon,
          height: 32.h,
          width: 34.h,
        ),
        SizedBox(height: 6.h),
        Text(
          count,
          style:
              TextStyleHelper.instance.body13RegularABeeZee.copyWith(shadows: [
            Shadow(
              color: appTheme.color4C0000,
              offset: Offset(1, 1),
              blurRadius: 1,
            ),
          ]),
        ),
      ],
    );
  }

  Widget _buildUserInfo(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 6.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '@longsang',
                        style: TextStyleHelper.instance.title17RegularABeeZee,
                      ),
                      TextSpan(
                        text: ' · 03',
                        style: TextStyleHelper.instance.title17RegularABeeZee,
                      ),
                      TextSpan(
                        text: '-09',
                        style: TextStyleHelper.instance.body15RegularABeeZee,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 2.h),
                Container(
                  width: 110.h,
                  child: Text(
                    'Tìm đối tối nay #sabo #rankG',
                    style: TextStyleHelper.instance.body15RegularABeeZee,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgShareIconWhiteA700,
                height: 26.h,
                width: 34.h,
              ),
              SizedBox(height: 8.h),
              Text(
                'Share',
                style: TextStyleHelper.instance.body13RegularABeeZee
                    .copyWith(shadows: [
                  Shadow(
                    color: appTheme.color4C0000,
                    offset: Offset(1, 1),
                    blurRadius: 1,
                  ),
                ]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
