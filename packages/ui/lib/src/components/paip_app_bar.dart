import 'package:core_flutter/core_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ui/ui.dart';

class PaipAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Widget? title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool centerTitle;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? elevation;
  final double? scrolledUnderElevation;
  final Color? shadowColor;
  final Color? surfaceTintColor;
  final ShapeBorder? shape;
  final bool automaticallyImplyLeading;
  final IconThemeData? iconTheme;
  final IconThemeData? actionsIconTheme;
  final bool primary;
  final bool excludeHeaderSemantics;
  final double? titleSpacing;
  final double toolbarOpacity;
  final double bottomOpacity;
  final double? toolbarHeight;
  final double? leadingWidth;
  final TextStyle? toolbarTextStyle;
  final TextStyle? titleTextStyle;
  final SystemUiOverlayStyle? systemOverlayStyle;
  final bool forceMaterialTransparency;
  final Clip? clipBehavior;
  final EdgeInsetsGeometry? actionsPadding;
  final PreferredSizeWidget? bottom;
  final Widget? flexibleSpace;
  final bool Function(ScrollNotification) notificationPredicate = defaultScrollNotificationPredicate;

  const PaipAppBar({
    super.key,
    this.title,
    this.actions,
    this.leading,
    this.centerTitle = true,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation,
    this.scrolledUnderElevation,
    this.shadowColor,
    this.surfaceTintColor,
    this.shape,
    this.automaticallyImplyLeading = true,
    this.iconTheme,
    this.actionsIconTheme,
    this.primary = true,
    this.excludeHeaderSemantics = false,
    this.titleSpacing,
    this.toolbarOpacity = 1.0,
    this.bottomOpacity = 1.0,
    this.toolbarHeight,
    this.leadingWidth,
    this.toolbarTextStyle,
    this.titleTextStyle,
    this.systemOverlayStyle,
    this.forceMaterialTransparency = false,
    this.clipBehavior,
    this.actionsPadding,
    this.bottom,
    this.flexibleSpace,
  });

  @override
  State<PaipAppBar> createState() => _PaipAppBarState();

  @override
  Size get preferredSize {
    final double toolbarHeight = this.toolbarHeight ?? kToolbarHeight;
    final double bottomHeight = bottom?.preferredSize.height ?? 0.0;
    return Size.fromHeight(toolbarHeight + bottomHeight);
  }
}

class _PaipAppBarState extends State<PaipAppBar> {
  Widget? effectiveLeading(BuildContext context) {
    if (widget.leading != null) return widget.leading;

    if (widget.automaticallyImplyLeading && context.canPop()) {
      return IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: context.artColorScheme.primary,
        ),
        onPressed: () => Navigator.of(context).pop(),
      );
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: widget.title != null
          ? DefaultTextStyle(
              style: context.artTextTheme.large.copyWith(fontSize: 16, color: context.artColorScheme.foreground),
              child: widget.title!,
            )
          : null,
      actions: widget.actions,
      leading: effectiveLeading(context),
      centerTitle: widget.centerTitle,
      backgroundColor: widget.backgroundColor ?? context.artColorScheme.background,
      foregroundColor: widget.foregroundColor ?? context.artColorScheme.foreground,
      elevation: widget.elevation,
      scrolledUnderElevation: widget.scrolledUnderElevation,
      shadowColor: widget.shadowColor,
      surfaceTintColor: widget.surfaceTintColor ?? context.artColorScheme.background,
      shape: widget.shape,
      automaticallyImplyLeading: widget.leading != null ? false : widget.automaticallyImplyLeading,
      iconTheme: widget.iconTheme,
      actionsIconTheme: widget.actionsIconTheme,
      primary: widget.primary,
      excludeHeaderSemantics: widget.excludeHeaderSemantics,
      titleSpacing: widget.titleSpacing,
      toolbarOpacity: widget.toolbarOpacity,
      bottomOpacity: widget.bottomOpacity,
      toolbarHeight: widget.toolbarHeight,
      leadingWidth: widget.leadingWidth,
      toolbarTextStyle: widget.toolbarTextStyle,
      titleTextStyle: widget.titleTextStyle,
      systemOverlayStyle: widget.systemOverlayStyle,
      forceMaterialTransparency: widget.forceMaterialTransparency,
      clipBehavior: widget.clipBehavior,
      actionsPadding: widget.actionsPadding,
      bottom: widget.bottom,
      flexibleSpace: widget.flexibleSpace,
      key: widget.key,
      notificationPredicate: widget.notificationPredicate,
    );
  }

  bool defaultScrollNotificationPredicate(ScrollNotification notification) {
    return notification.depth == 0;
  }
}
