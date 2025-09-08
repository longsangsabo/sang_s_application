import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../widgets/custom_bottom_bar.dart';
import 'user_profile_initial_page.dart';

class UserProfileScreen extends ConsumerStatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  UserProfileScreenState createState() => UserProfileScreenState();
}

class UserProfileScreenState extends ConsumerState<UserProfileScreen> {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Navigator(
          key: navigatorKey,
          initialRoute: AppRoutes.userProfileScreenInitialPage,
          onGenerateRoute: (routeSetting) => PageRouteBuilder(
            pageBuilder: (ctx, a1, a2) =>
                getCurrentPage(context, routeSetting.name!),
            transitionDuration: Duration(seconds: 0),
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        width: double.maxFinite,
        child: _buildBottomBar(context),
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return CustomBottomBar(
      bottomBarItemList: [
        CustomBottomBarItem(
          icon: ImageConstant.imgNavTrangCh,
          title: 'Trang chủ',
          routeName: '/home',
          fontFamily: 'ABeeZee',
        ),
        CustomBottomBarItem(
          icon: ImageConstant.imgNavTMI,
          title: 'Tìm đối',
          routeName: '/search',
        ),
        CustomBottomBarItem(
          icon: '',
          title: 'Giải đấu',
          routeName: '/tournament',
          isTournament: true,
          badgeCount: '8',
          textColor: appTheme.gray_500,
        ),
        CustomBottomBarItem(
          icon: ImageConstant.imgClb,
          title: 'Club',
          routeName: '/club',
          iconHeight: 32,
          iconWidth: 32,
        ),
        CustomBottomBarItem(
          icon: ImageConstant.imgNavHS,
          title: 'Hồ sơ',
          routeName: AppRoutes.userProfileScreenInitialPage,
        ),
      ],
      selectedIndex: 4,
      onChanged: (index) {
        var routeNames = [
          '/home',
          '/search',
          '/tournament',
          '/club',
          AppRoutes.userProfileScreenInitialPage
        ];
        navigatorKey.currentState?.pushNamed(routeNames[index]);
      },
    );
  }

  Widget getCurrentPage(BuildContext context, String currentRoute) {
    switch (currentRoute) {
      case AppRoutes.userProfileScreenInitialPage:
        return UserProfileInitialPage();
      default:
        return Container();
    }
  }
}
