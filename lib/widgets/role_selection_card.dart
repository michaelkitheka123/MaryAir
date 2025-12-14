import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/user_role.dart';

class RoleSelectionCard extends StatelessWidget {
  final UserRole role;
  final bool isSelected;
  final VoidCallback onTap;
  final IconData icon;

  const RoleSelectionCard({
    super.key,
    required this.role,
    required this.isSelected,
    required this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.all(AppTheme.spacingM),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppTheme.radiusL),
          gradient: isSelected ? AppTheme.primaryGradient : null,
          color: isSelected ? null : Colors.white,
          border: Border.all(
            color: isSelected ? Colors.transparent : AppTheme.lightGray,
            width: 2,
          ),
          boxShadow: isSelected ? AppTheme.cardShadow : AppTheme.glassShadow,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(AppTheme.spacingM),
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.white.withValues(alpha: 0.2)
                    : AppTheme.lightBlue,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 32,
                color: isSelected ? Colors.white : AppTheme.primaryBlue,
              ),
            ),
            const SizedBox(height: AppTheme.spacingM),
            Text(
              role.displayName,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: isSelected ? Colors.white : AppTheme.darkGray,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppTheme.spacingXS),
            Text(
              role.description,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: isSelected
                    ? Colors.white.withValues(alpha: 0.9)
                    : AppTheme.mediumGray,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
