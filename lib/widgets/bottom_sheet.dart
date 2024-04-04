import 'package:emoji_room/constants/app_theme.dart';
import 'package:flutter/material.dart';

Future<T?> showCommonModalBottomSheet<T>({
  required BuildContext context,
  required Widget Function(BuildContext context) builder,
  Color? backgroundColor,
  double? elevation,
  ShapeBorder? shape,
  Clip? clipBehavior,
  BoxConstraints? constraints,
  Color? barrierColor,
  bool isScrollControlled = false,
  bool useRootNavigator = false,
  bool isDismissible = true,
  bool enableDrag = true,
  bool? showDragHandle,
  bool useSafeArea = false,
  RouteSettings? routeSettings,
  AnimationController? transitionAnimationController,
  Offset? anchorPoint,
}) {
  return showModalBottomSheet(
    context: context,
    builder: builder,
    backgroundColor: backgroundColor,
    elevation: elevation,
    shape: shape ??
        const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
                top: Radius.circular(AppTheme.bottomRadius))),
    // 底部面板为Scaffold时，需要指定clipBehavior为clip.antiAlias，否则设置的shape圆角无效
    clipBehavior: Clip.antiAlias,
    constraints: const BoxConstraints(maxWidth: 600),
    barrierColor: barrierColor,
    isScrollControlled: isScrollControlled,
    useRootNavigator: useRootNavigator,
    isDismissible: isDismissible,
    enableDrag: enableDrag,
    showDragHandle: showDragHandle,
    useSafeArea: useSafeArea,
    routeSettings: routeSettings,
    transitionAnimationController: transitionAnimationController,
    anchorPoint: anchorPoint,
  );
}
