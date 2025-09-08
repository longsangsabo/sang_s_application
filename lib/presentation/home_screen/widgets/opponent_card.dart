import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../widgets/custom_image_view.dart';
import '../../../widgets/connected_social_interaction_buttons.dart';
import '../../../widgets/profile_interaction_components.dart';
import '../../models/opponent_card_model.dart';

/// Widget representing a single opponent card in the home feed
class OpponentCard extends ConsumerWidget {
  const OpponentCard({
    super.key,
    required this.opponent,
    this.onTap,
    this.onChallenge,
    this.onSchedule,
    this.onSocialInteraction,
  });

  /// The opponent data to display
  final OpponentCardModel opponent;
  
  /// Callback when the card is tapped
  final VoidCallback? onTap;
  
  /// Callback when challenge button is pressed
  final VoidCallback? onChallenge;
  
  /// Callback when schedule button is pressed
  final VoidCallback? onSchedule;
  
  /// Callback when social interaction occurs
  final Function(String action)? onSocialInteraction;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 16.h,
        vertical: 8.v,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.h),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16.h),
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.all(16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with profile info
                _buildHeader(context),
                
                SizedBox(height: 12.v),
                
                // Post content
                _buildPostContent(context),
                
                SizedBox(height: 16.v),
                
                // Social interaction buttons
                _buildSocialInteractionSection(),
                
                SizedBox(height: 16.v),
                
                // Action buttons (Chơi luôn, Hẹn lịch)
                _buildActionButtons(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Build the header section with profile information
  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        // Profile image
        Container(
          width: 48.h,
          height: 48.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: opponent.isOnline ? Colors.green : Colors.grey.shade300,
              width: 2,
            ),
          ),
          child: ClipOval(
            child: CustomImageView(
              imagePath: opponent.profileImage,
              width: 44.h,
              height: 44.h,
              fit: BoxFit.cover,
            ),
          ),
        ),
        
        SizedBox(width: 12.h),
        
        // Profile info
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Name and handle
              Row(
                children: [
                  Flexible(
                    child: Text(
                      opponent.userName,
                      style: TextStyle(
                        fontSize: 16.fSize,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(width: 4.h),
                  Text(
                    opponent.userHandle,
                    style: TextStyle(
                      fontSize: 14.fSize,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: 2.v),
              
              // Rank, location, club
              Row(
                children: [
                  // Rank badge
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.h,
                      vertical: 2.v,
                    ),
                    decoration: BoxDecoration(
                      color: _getRankColor(opponent.rank),
                      borderRadius: BorderRadius.circular(12.h),
                    ),
                    child: Text(
                      'Rank ${opponent.rank}',
                      style: TextStyle(
                        fontSize: 11.fSize,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  
                  SizedBox(width: 8.h),
                  
                  // Location
                  Icon(
                    Icons.location_on,
                    size: 14.h,
                    color: Colors.grey.shade600,
                  ),
                  SizedBox(width: 2.h),
                  Text(
                    opponent.location,
                    style: TextStyle(
                      fontSize: 12.fSize,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  
                  SizedBox(width: 8.h),
                  
                  // ELO rating
                  Text(
                    'ELO: ${opponent.elo}',
                    style: TextStyle(
                      fontSize: 12.fSize,
                      fontWeight: FontWeight.w500,
                      color: Colors.orange.shade700,
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: 2.v),
              
              // Club name
              Row(
                children: [
                  CustomImageView(
                    imagePath: opponent.clubAvatar,
                    width: 16.h,
                    height: 16.h,
                  ),
                  SizedBox(width: 4.h),
                  Text(
                    opponent.clubName,
                    style: TextStyle(
                      fontSize: 12.fSize,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        
        // Post date and status
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              opponent.postDate,
              style: TextStyle(
                fontSize: 12.fSize,
                color: Colors.grey.shade500,
              ),
            ),
            if (opponent.isOnline) ...[
              SizedBox(height: 4.v),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 6.h,
                  vertical: 2.v,
                ),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(8.h),
                ),
                child: Text(
                  'Online',
                  style: TextStyle(
                    fontSize: 10.fSize,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }

  /// Build the post content section
  Widget _buildPostContent(BuildContext context) {
    return Text(
      opponent.postContent,
      style: TextStyle(
        fontSize: 14.fSize,
        height: 1.4,
        color: Colors.black87,
      ),
    );
  }

  /// Build the social interaction section
  Widget _buildSocialInteractionSection() {
    return ConnectedSocialInteractionButtons(
      initialModel: opponent.socialInteraction,
      itemId: opponent.id,
      onInteraction: (action, model) {
        onSocialInteraction?.call(action);
      },
      size: SocialInteractionSize.medium,
      layout: SocialInteractionLayout.horizontal,
    );
  }

  /// Build the action buttons section
  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        // Challenge button
        Expanded(
          child: ElevatedButton(
            onPressed: onChallenge,
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.primary,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 12.v),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.h),
              ),
              elevation: 0,
            ),
            child: Text(
              'Chơi luôn',
              style: TextStyle(
                fontSize: 14.fSize,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        
        SizedBox(width: 12.h),
        
        // Schedule button
        Expanded(
          child: OutlinedButton(
            onPressed: onSchedule,
            style: OutlinedButton.styleFrom(
              foregroundColor: theme.colorScheme.primary,
              padding: EdgeInsets.symmetric(vertical: 12.v),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.h),
              ),
              side: BorderSide(
                color: theme.colorScheme.primary,
                width: 1.5,
              ),
            ),
            child: Text(
              'Hẹn lịch',
              style: TextStyle(
                fontSize: 14.fSize,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Get color for rank badge
  Color _getRankColor(String rank) {
    switch (rank.toUpperCase()) {
      case 'G':
        return Colors.purple.shade600;
      case 'A':
        return Colors.red.shade600;
      case 'B':
        return Colors.orange.shade600;
      case 'C':
        return Colors.blue.shade600;
      default:
        return Colors.grey.shade600;
    }
  }
}

/// Compact version of opponent card for list views
class CompactOpponentCard extends ConsumerWidget {
  const CompactOpponentCard({
    super.key,
    required this.opponent,
    this.onTap,
    this.onChallenge,
  });

  final OpponentCardModel opponent;
  final VoidCallback? onTap;
  final VoidCallback? onChallenge;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.h, vertical: 4.v),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.h),
        border: Border.all(
          color: Colors.grey.shade200,
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12.h),
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.all(12.h),
            child: Row(
              children: [
                // Profile image
                Container(
                  width: 40.h,
                  height: 40.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: opponent.isOnline ? Colors.green : Colors.grey.shade300,
                      width: 2,
                    ),
                  ),
                  child: ClipOval(
                    child: CustomImageView(
                      imagePath: opponent.profileImage,
                      width: 36.h,
                      height: 36.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                
                SizedBox(width: 12.h),
                
                // Profile info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            opponent.userName,
                            style: TextStyle(
                              fontSize: 14.fSize,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(width: 8.h),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 6.h,
                              vertical: 2.v,
                            ),
                            decoration: BoxDecoration(
                              color: _getRankColor(opponent.rank),
                              borderRadius: BorderRadius.circular(8.h),
                            ),
                            child: Text(
                              opponent.rank,
                              style: TextStyle(
                                fontSize: 10.fSize,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 2.v),
                      Text(
                        '${opponent.location} • ELO: ${opponent.elo}',
                        style: TextStyle(
                          fontSize: 12.fSize,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Challenge button
                SizedBox(
                  width: 80.h,
                  child: ElevatedButton(
                    onPressed: onChallenge,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 8.v),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.h),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Chơi',
                      style: TextStyle(
                        fontSize: 12.fSize,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getRankColor(String rank) {
    switch (rank.toUpperCase()) {
      case 'G':
        return Colors.purple.shade600;
      case 'A':
        return Colors.red.shade600;
      case 'B':
        return Colors.orange.shade600;
      case 'C':
        return Colors.blue.shade600;
      default:
        return Colors.grey.shade600;
    }
  }
}
