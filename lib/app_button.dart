import 'package:flutter/material.dart';
import 'package:profile_fetch/extension_helper.dart';

import 'app_colors.dart';

double _buttonFontSizeMedium = 14;
double _buttonFontSizeNormal = 12;

enum ButtonSize {
  medium,
  normal,
}

class AppButton extends StatelessWidget {
  final Color backgroundColor;
  final Color borderColor;
  final String text;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? splashColor;
  final Color? highlightColor;
  final Color textColor;
  final VoidCallback? onTap;
  final bool isEnabled;
  final ButtonSize buttonSize;

  const AppButton({
    super.key,
    required this.backgroundColor,
    required this.borderColor,
    required this.text,
    required this.textColor,
    required this.isEnabled,
    required this.buttonSize,
    this.prefixIcon,
    this.suffixIcon,
    this.splashColor,
    this.highlightColor,
    this.onTap,
  });

  AppButton.primary({
    super.key,
    required this.text,
    this.isEnabled = true,
    this.prefixIcon,
    this.suffixIcon,
    this.onTap,
    this.buttonSize = ButtonSize.medium,
  })  : backgroundColor = isEnabled ? AppColors.appButton : AppColors.grey400,
        borderColor = Colors.transparent,
        highlightColor = const Color(0xffaafaaa),
        splashColor = Colors.white.withOpacity(0.7),
        textColor = Colors.black;

  const AppButton.secondary({
    super.key,
    required this.text,
    this.isEnabled = true,
    this.prefixIcon,
    this.suffixIcon,
    this.onTap,
    this.buttonSize = ButtonSize.medium,
  })  : backgroundColor = Colors.white,
        borderColor = AppColors.grey300,
        highlightColor = AppColors.grey100,
        splashColor = AppColors.grey300,
        textColor = AppColors.textFieldLabelColor;

  AppButton.constructive({
    super.key,
    required this.text,
    this.isEnabled = true,
    this.prefixIcon,
    this.suffixIcon,
    this.onTap,
    this.buttonSize = ButtonSize.medium,
  })  : backgroundColor = isEnabled ? AppColors.success500 : AppColors.grey400,
        borderColor = Colors.transparent,
        highlightColor = AppColors.success500,
        splashColor = Colors.white.withOpacity(0.7),
        textColor = Colors.white;

  AppButton.destructive({
    super.key,
    required this.text,
    this.isEnabled = true,
    this.prefixIcon,
    this.suffixIcon,
    this.onTap,
    this.buttonSize = ButtonSize.medium,
  })  : backgroundColor = isEnabled ? AppColors.error500 : Colors.white,
        borderColor = isEnabled ? Colors.transparent : AppColors.grey300,
        highlightColor = const Color(0xFFF6877F),
        splashColor = Colors.white.withOpacity(0.7),
        textColor = isEnabled ? Colors.white : AppColors.textFieldLabelColor;

  AppButton.primaryLoader({
    super.key,
    required this.text,
    this.buttonSize = ButtonSize.medium,
  })  : isEnabled = false,
        backgroundColor = AppColors.grey400,
        borderColor = Colors.transparent,
        highlightColor = const Color(0xff6ea4f1),
        splashColor = Colors.white.withOpacity(0.7),
        textColor = Colors.white,
        prefixIcon = null,
        suffixIcon = SizedBox(
          height: _getButtonSize(buttonSize),
          width: _getButtonSize(buttonSize),
          child: const CircularProgressIndicator(
            color: AppColors.grey400,
            strokeWidth: 2,
          ),
        ),
        onTap = null;

  @override
  Widget build(BuildContext context) {
    var cornerRadius = BorderRadius.circular(40);
    return Container(
      decoration: BoxDecoration(
        borderRadius: cornerRadius,
        border: Border.all(
          color: borderColor,
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: cornerRadius,
        child: Material(
          color: backgroundColor,
          child: InkWell(
            onTap: isEnabled ? (onTap ?? () => {}) : null,
            highlightColor: highlightColor,
            splashColor: splashColor,
            child: Padding(
              padding: _getButtonInset(),
              child: Container(
                alignment: Alignment.center,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    prefixIcon,
                    Flexible(
                      child: Text(
                        text,
                        style: TextStyle(
                          color: textColor,
                          fontSize: _getButtonSize(buttonSize),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    suffixIcon,
                  ].spaceHorizontally(8),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  static double _getButtonSize(ButtonSize buttonSize) {
    if (buttonSize == ButtonSize.medium) {
      return _buttonFontSizeMedium;
    } else {
      return _buttonFontSizeNormal;
    }
  }

  EdgeInsets _getButtonInset() {
    if (buttonSize == ButtonSize.medium) {
      return const EdgeInsets.all(8);
    } else {
      return const EdgeInsets.all(4);
    }
  }
}
