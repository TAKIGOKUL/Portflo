import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/animations.dart';

enum ButtonVariant { primary, secondary, outlined, text, gradient }
enum ButtonSize { small, medium, large }

class CustomButton extends StatefulWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.variant = ButtonVariant.primary,
    this.size = ButtonSize.medium,
    this.icon,
    this.iconPosition = IconPosition.left,
    this.isLoading = false,
    this.isFullWidth = false,
    this.borderRadius,
    this.customColors,
    this.animateOnTap = true,
    this.elevation = 0,
  });

  final String text;
  final VoidCallback? onPressed;
  final ButtonVariant variant;
  final ButtonSize size;
  final IconData? icon;
  final IconPosition iconPosition;
  final bool isLoading;
  final bool isFullWidth;
  final BorderRadius? borderRadius;
  final ButtonColors? customColors;
  final bool animateOnTap;
  final double elevation;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: AppAnimations.fast,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onTapDown(_) {
    if (widget.animateOnTap) {
      _animationController.forward();
    }
  }

  void _onTapUp(_) {
    if (widget.animateOnTap) {
      _animationController.reverse();
    }
  }

  void _onTapCancel() {
    if (widget.animateOnTap) {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final buttonStyle = _getButtonStyle(theme);
    final textStyle = _getTextStyle(theme);
    final padding = _getPadding();

    Widget buttonChild = widget.isLoading
        ? SizedBox(
            height: _getIconSize(),
            width: _getIconSize(),
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(
                textStyle.color ?? Colors.white,
              ),
            ),
          )
        : _buildButtonContent(textStyle);

    Widget button = Container(
      width: widget.isFullWidth ? double.infinity : null,
      height: _getButtonHeight(),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.isLoading ? null : widget.onPressed,
          onTapDown: _onTapDown,
          onTapUp: _onTapUp,
          onTapCancel: _onTapCancel,
          onHover: (hovering) {
            setState(() {
              _isHovered = hovering;
            });
          },
          borderRadius: widget.borderRadius ?? AppTheme.buttonRadius,
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              gradient: _getGradient(),
              color: _getBackgroundColor(theme),
              borderRadius: widget.borderRadius ?? AppTheme.buttonRadius,
              border: _getBorder(theme),
              boxShadow: _getShadow(),
            ),
            child: Center(child: buttonChild),
          ),
        ),
      ),
    );

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          final scaleValue = 1.0 - (_animationController.value * 0.05);
          return Transform.scale(
            scale: scaleValue,
            child: button,
          );
        },
      ),
    );
  }

  Widget _buildButtonContent(TextStyle textStyle) {
    if (widget.icon == null) {
      return Text(widget.text, style: textStyle);
    }

    final iconWidget = Icon(
      widget.icon,
      size: _getIconSize(),
      color: textStyle.color,
    );

    final textWidget = Text(widget.text, style: textStyle);
    const spacing = SizedBox(width: 8);

    if (widget.iconPosition == IconPosition.left) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [iconWidget, spacing, textWidget],
      );
    } else {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [textWidget, spacing, iconWidget],
      );
    }
  }

  ButtonStyle _getButtonStyle(ThemeData theme) {
    switch (widget.variant) {
      case ButtonVariant.primary:
        return theme.elevatedButtonTheme.style!;
      case ButtonVariant.secondary:
      case ButtonVariant.outlined:
        return theme.outlinedButtonTheme.style!;
      case ButtonVariant.text:
      case ButtonVariant.gradient:
        return theme.textButtonTheme.style!;
    }
  }

  TextStyle _getTextStyle(ThemeData theme) {
    final baseStyle = AppTheme.buttonText;
    final fontSize = _getFontSize();

    Color textColor;
    switch (widget.variant) {
      case ButtonVariant.primary:
      case ButtonVariant.gradient:
        textColor = Colors.white;
        break;
      case ButtonVariant.secondary:
        textColor = AppTheme.darkTextPrimary;
        break;
      case ButtonVariant.outlined:
      case ButtonVariant.text:
        textColor = AppTheme.primaryColor;
        break;
    }

    if (widget.customColors != null) {
      textColor = widget.customColors!.textColor;
    }

    return baseStyle.copyWith(
      fontSize: fontSize,
      color: textColor,
    );
  }

  EdgeInsets _getPadding() {
    switch (widget.size) {
      case ButtonSize.small:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 8);
      case ButtonSize.medium:
        return const EdgeInsets.symmetric(horizontal: 24, vertical: 12);
      case ButtonSize.large:
        return const EdgeInsets.symmetric(horizontal: 32, vertical: 16);
    }
  }

  double _getFontSize() {
    switch (widget.size) {
      case ButtonSize.small:
        return 14;
      case ButtonSize.medium:
        return 16;
      case ButtonSize.large:
        return 18;
    }
  }

  double _getIconSize() {
    switch (widget.size) {
      case ButtonSize.small:
        return 16;
      case ButtonSize.medium:
        return 20;
      case ButtonSize.large:
        return 24;
    }
  }

  double _getButtonHeight() {
    switch (widget.size) {
      case ButtonSize.small:
        return 36;
      case ButtonSize.medium:
        return 48;
      case ButtonSize.large:
        return 56;
    }
  }

  Color? _getBackgroundColor(ThemeData theme) {
    if (widget.variant == ButtonVariant.gradient) return null;
    if (widget.customColors != null) {
      return widget.customColors!.backgroundColor;
    }

    switch (widget.variant) {
      case ButtonVariant.primary:
        return _isHovered 
            ? AppTheme.primaryColor.withOpacity(0.9)
            : AppTheme.primaryColor;
      case ButtonVariant.secondary:
        return _isHovered 
            ? AppTheme.darkCard.withOpacity(0.9)
            : AppTheme.darkCard;
      case ButtonVariant.outlined:
      case ButtonVariant.text:
        return _isHovered 
            ? AppTheme.primaryColor.withOpacity(0.1)
            : Colors.transparent;
      case ButtonVariant.gradient:
        return null;
    }
  }

  Gradient? _getGradient() {
    if (widget.variant == ButtonVariant.gradient) {
      return AppTheme.primaryGradient;
    }
    return null;
  }

  Border? _getBorder(ThemeData theme) {
    if (widget.variant == ButtonVariant.outlined) {
      return Border.all(
        color: widget.customColors?.borderColor ?? AppTheme.primaryColor,
        width: 2,
      );
    }
    return null;
  }

  List<BoxShadow>? _getShadow() {
    if (widget.elevation > 0) {
      return [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: widget.elevation * 2,
          offset: Offset(0, widget.elevation),
        ),
      ];
    }

    if (_isHovered && widget.variant == ButtonVariant.primary) {
      return AppTheme.buttonShadows;
    }

    return null;
  }
}

class ButtonColors {
  const ButtonColors({
    required this.backgroundColor,
    required this.textColor,
    this.borderColor,
  });

  final Color backgroundColor;
  final Color textColor;
  final Color? borderColor;
}

enum IconPosition { left, right }

// Static factory methods for common button types
class CustomButtonFactories {
  static CustomButton primary({
    Key? key,
    required String text,
    required VoidCallback? onPressed,
    IconData? icon,
    ButtonSize size = ButtonSize.medium,
    bool isLoading = false,
    bool isFullWidth = false,
  }) {
    return CustomButton(
      key: key,
      text: text,
      onPressed: onPressed,
      variant: ButtonVariant.primary,
      size: size,
      icon: icon,
      isLoading: isLoading,
      isFullWidth: isFullWidth,
    );
  }

  static CustomButton outlined({
    Key? key,
    required String text,
    required VoidCallback? onPressed,
    IconData? icon,
    ButtonSize size = ButtonSize.medium,
    bool isLoading = false,
    bool isFullWidth = false,
  }) {
    return CustomButton(
      key: key,
      text: text,
      onPressed: onPressed,
      variant: ButtonVariant.outlined,
      size: size,
      icon: icon,
      isLoading: isLoading,
      isFullWidth: isFullWidth,
    );
  }

  static CustomButton gradient({
    Key? key,
    required String text,
    required VoidCallback? onPressed,
    IconData? icon,
    ButtonSize size = ButtonSize.medium,
    bool isLoading = false,
    bool isFullWidth = false,
  }) {
    return CustomButton(
      key: key,
      text: text,
      onPressed: onPressed,
      variant: ButtonVariant.gradient,
      size: size,
      icon: icon,
      isLoading: isLoading,
      isFullWidth: isFullWidth,
    );
  }
}
