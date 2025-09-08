import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_bottom_bar.dart';
import '../../widgets/profile_interaction_components.dart';
import '../models/opponent_card_model.dart';
import 'notifier/home_notifier.dart';

/**
 * HomeScreen - Main feed screen for discovering opponents
 * 
 * Features:
 * - Social feed with opponent cards
 * - Pull-to-refresh functionality
 * - Infinite scroll with pagination
 * - Interactive opponent cards with social buttons
 * - Bottom navigation integration
 */
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends ConsumerState<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final RefreshIndicator _refreshIndicator = RefreshIndicator(
    onRefresh: () async {},
    child: SizedBox(),
  );

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    
    // Initialize data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(homeNotifier.notifier).loadOpponents();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= 
        _scrollController.position.maxScrollExtent - 200) {
      // Load more data when near bottom
      ref.read(homeNotifier.notifier).loadMoreOpponents();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.black_900,
      appBar: _buildAppBar(),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return CustomAppBar(
      title: 'SABO',
      gradientColors: [Color(0xFF6403C8), Color(0xFF0414AC)],
      actionIcons: [
        ImageConstant.imgButomSun,
        ImageConstant.imgButtonMessages,
        ImageConstant.imgButtonNotifications,
      ],
      onActionTap: (index) {
        switch (index) {
          case 0:
            _handleThemeToggle();
            break;
          case 1:
            _handleMessages();
            break;
          case 2:
            _handleNotifications();
            break;
        }
      },
    );
  }

  Widget _buildBody() {
    return RefreshIndicator(
      onRefresh: _handleRefresh,
      child: Consumer(
        builder: (context, ref, child) {
          final state = ref.watch(homeNotifier);
          
          if (state.isLoading && state.opponents.isEmpty) {
            return _buildLoadingState();
          }
          
          if (state.error != null && state.opponents.isEmpty) {
            return _buildErrorState(state.error!);
          }
          
          if (state.opponents.isEmpty) {
            return _buildEmptyState();
          }
          
          return _buildOpponentsFeed(state);
        },
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF6403C8)),
          ),
          SizedBox(height: 16.h),
          Text(
            'Đang tìm đối thủ...',
            style: TextStyleHelper.instance.body16RegularABeeZee.copyWith(
              color: appTheme.white_A700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64.h,
            color: appTheme.white_A700.withOpacity(0.6),
          ),
          SizedBox(height: 16.h),
          Text(
            'Có lỗi xảy ra',
            style: TextStyleHelper.instance.title20RegularRoboto.copyWith(
              color: appTheme.white_A700,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            error,
            style: TextStyleHelper.instance.body14RegularABeeZee.copyWith(
              color: appTheme.white_A700.withOpacity(0.7),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.h),
          ElevatedButton(
            onPressed: () {
              ref.read(homeNotifier.notifier).loadOpponents();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF6403C8),
              foregroundColor: appTheme.white_A700,
            ),
            child: Text('Thử lại'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 64.h,
            color: appTheme.white_A700.withOpacity(0.6),
          ),
          SizedBox(height: 16.h),
          Text(
            'Không tìm thấy đối thủ',
            style: TextStyleHelper.instance.title20RegularRoboto.copyWith(
              color: appTheme.white_A700,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Hãy thử lại sau hoặc mở rộng khu vực tìm kiếm',
            style: TextStyleHelper.instance.body14RegularABeeZee.copyWith(
              color: appTheme.white_A700.withOpacity(0.7),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildOpponentsFeed(HomeState state) {
    return ListView.builder(
      controller: _scrollController,
      padding: EdgeInsets.symmetric(vertical: 8.h),
      itemCount: state.opponents.length + (state.isLoadingMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index >= state.opponents.length) {
          return _buildLoadingMoreIndicator();
        }
        
        final opponent = state.opponents[index];
        return _buildOpponentCard(opponent, index);
      },
    );
  }

  Widget _buildLoadingMoreIndicator() {
    return Container(
      padding: EdgeInsets.all(16.h),
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF6403C8)),
        ),
      ),
    );
  }

  Widget _buildOpponentCard(OpponentCardModel opponent, int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.h, vertical: 8.h),
      child: OpponentCard(
        opponent: opponent,
        onLikePressed: () => _handleLike(opponent),
        onCommentPressed: () => _handleComment(opponent),
        onSharePressed: () => _handleShare(opponent),
        onPlayNowPressed: () => _handlePlayNow(opponent),
        onSchedulePressed: () => _handleSchedule(opponent),
        onProfileTap: () => _handleProfileTap(opponent),
      ),
    );
  }

  Widget _buildBottomBar() {
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
          routeName: AppRoutes.userProfileScreen,
        ),
      ],
      selectedIndex: 0, // Home is selected
      onChanged: (index) {
        _handleBottomNavigation(index);
      },
    );
  }

  // Event Handlers
  Future<void> _handleRefresh() async {
    await ref.read(homeNotifier.notifier).refreshOpponents();
  }

  void _handleThemeToggle() {
    debugPrint('Theme toggle pressed');
    // TODO: Implement theme switching
  }

  void _handleMessages() {
    debugPrint('Messages pressed');
    // TODO: Navigate to messages screen
  }

  void _handleNotifications() {
    debugPrint('Notifications pressed');
    // TODO: Navigate to notifications screen
  }

  void _handleLike(OpponentCardModel opponent) {
    ref.read(homeNotifier.notifier).toggleLike(opponent.id);
    debugPrint('Liked opponent: ${opponent.userName}');
  }

  void _handleComment(OpponentCardModel opponent) {
    debugPrint('Comment on opponent: ${opponent.userName}');
    // TODO: Navigate to comments screen
  }

  void _handleShare(OpponentCardModel opponent) {
    debugPrint('Share opponent: ${opponent.userName}');
    // TODO: Implement sharing functionality
  }

  void _handlePlayNow(OpponentCardModel opponent) {
    debugPrint('Play now with: ${opponent.userName}');
    // TODO: Navigate to game setup
  }

  void _handleSchedule(OpponentCardModel opponent) {
    debugPrint('Schedule game with: ${opponent.userName}');
    // TODO: Navigate to schedule screen
  }

  void _handleProfileTap(OpponentCardModel opponent) {
    debugPrint('View profile: ${opponent.userName}');
    // TODO: Navigate to opponent profile
  }

  void _handleBottomNavigation(int index) {
    final routeNames = [
      '/home',        // 0 - Current screen
      '/search',      // 1 - Search
      '/tournament',  // 2 - Tournament
      '/club',        // 3 - Club
      AppRoutes.userProfileScreen, // 4 - Profile
    ];
    
    if (index != 0) { // Don't navigate if already on home
      NavigatorService.pushNamed(routeNames[index]);
    }
  }
}
