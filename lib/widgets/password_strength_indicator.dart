import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../utils/validators.dart';

class PasswordStrengthIndicator extends StatelessWidget {
  final String password;

  const PasswordStrengthIndicator({super.key, required this.password});

  @override
  Widget build(BuildContext context) {
    final strength = Validators.getPasswordStrength(password);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: List.generate(4, (index) {
            return Expanded(
              child: Container(
                height: 4,
                margin: EdgeInsets.only(
                  right: index < 3 ? AppTheme.spacingXS : 0,
                ),
                decoration: BoxDecoration(
                  color: index < strength
                      ? _getStrengthColor(strength)
                      : AppTheme.lightGray,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            );
          }),
        ),
        if (password.isNotEmpty) ...[
          const SizedBox(height: AppTheme.spacingS),
          Text(
            _getStrengthText(strength),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: _getStrengthColor(strength),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ],
    );
  }

  Color _getStrengthColor(int strength) {
    switch (strength) {
      case 0:
      case 1:
        return AppTheme.errorRed;
      case 2:
        return AppTheme.warningOrange;
      case 3:
        return Colors.yellow.shade700;
      case 4:
        return AppTheme.successGreen;
      default:
        return AppTheme.lightGray;
    }
  }

  String _getStrengthText(int strength) {
    switch (strength) {
      case 0:
      case 1:
        return 'Weak password';
      case 2:
        return 'Fair password';
      case 3:
        return 'Good password';
      case 4:
        return 'Strong password';
      default:
        return '';
    }
  }
}
