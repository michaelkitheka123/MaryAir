import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isOutlined;
  final IconData? icon;
  final Color? borderColor;
  final Color? backgroundColor;
  final Color? textColor;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isOutlined = false,
    this.icon,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppTheme.radiusM),
        gradient: !isOutlined && onPressed != null && !isLoading
            ? AppTheme.primaryGradient
            : null,
        boxShadow: !isOutlined && onPressed != null && !isLoading
            ? AppTheme.buttonShadow
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isLoading ? null : onPressed,
          borderRadius: BorderRadius.circular(AppTheme.radiusM),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppTheme.radiusM),
              border: isOutlined
                  ? Border.all(
                      color:
                          borderColor ??
                          (onPressed != null
                              ? AppTheme.primaryBlue
                              : AppTheme.lightGray),
                      width: 2,
                    )
                  : null,
              color: isOutlined
                  ? Colors.transparent
                  : (backgroundColor ?? Colors.transparent),
            ),
            child: Center(
              child: isLoading
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (icon != null) ...[
                          Icon(
                            icon,
                            color: isOutlined
                                ? AppTheme.primaryBlue
                                : (textColor ?? Colors.white),
                            size: 20,
                          ),
                          const SizedBox(width: AppTheme.spacingS),
                        ],
                        Text(
                          text,
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(
                                color: isOutlined
                                    ? AppTheme.primaryBlue
                                    : (textColor ?? Colors.white),
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
