// ld_appbar_ctrl.dart
//
// Controlador del widget 'LdAppbar'.
// CreatedAt: 2025/03/23 dg. JIQ

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ld_wbench4/03b_core/ld_widget.dart';
import 'package:ld_wbench4/05_tools/null_mang.dart';
import 'package:ld_wbench4/09_trans/l.dart';
import 'package:ld_wbench4/10_widgets/ld_app_bar/ld_appbar_widget.dart';

class LdAppbarCtrl 
extends LdWidgetCtrl<LdAppbar> {
  // 📝 ESTÀTICS -----------------------
  
  // 🧩 MEMBRES ------------------------
  late StreamBuilder _builder;
  Widget? _drawer;
  Widget? _endDrawer;
  final List<Widget>? _actions;
  final bool showProgress;
  final double? progress;
  final bool showDrawerIcon;
  final bool showBackButton;
  final double _actionsRightMargin;
  final double _actionButtonsSpacing;

  // 🛠️ CONSTRUCTORS ------------------
  LdAppbarCtrl({
    required super.pTag, 
    required super.pView,
    List<Widget>? pActions,
    this.showProgress = true, 
    this.progress, 
    this.showDrawerIcon = false, 
    this.showBackButton = false, 
    double? pActionsRightMargin,
    double? pActionButtonsSpacing, 
  }): 
    _actions = pActions,
    _actionsRightMargin = pActionsRightMargin?? 15.0.sp,
    _actionButtonsSpacing = pActionButtonsSpacing?? 2.0.sp;

  // FUNCIONS AUXILIARS ---------------
  // Construeix l'icona "leading" en funció de la configuració
  Widget? buildLeadingIcon(BuildContext context) {
    if (showBackButton) {
      return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => Navigator.of(context).pop(),
      );
    } else if (showDrawerIcon) {
      return IconButton(
        icon: Icon(Icons.menu),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      );
    }
    return null;
  }

  // Construeix la barra de progrés per l'estat de càrrega
  Widget buildProgressContent(BuildContext context) {
    _progressBuilder ??= GetBuilder<LdAppBarWidgetCtrl>(
      id: appBarProgressIdx,
      tag: appBarProgressIdx,
      init: this,
      builder: (ctrl) {
        var stats = viewCtrl.state.stats;
        String? loadingElement = Get.parameters[LdState.loadingElm];
        if (loadingElement != null) {
          Get.parameters.remove(LdState.loadingElm);
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "${L.loading.tx} ${(loadingElement != null) ? '\'$loadingElement\'' : '...'}",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(
              (stats.$3 != null)
                  ? "${stats.$2} ${L.of.tx} ${stats.$1} (${(stats.$3! * 100).toStringAsPrecision(3)}%)"
                  : "${stats.$2} ${L.of.tx} ${stats.$1}",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: viewCtrl.state.isError ? Colors.red : null,
              ),
            ),
            LinearProgressIndicator(
              minHeight: 5.0.h,
              value: stats.$3,
              backgroundColor: Theme.of(context).colorScheme.primary,
              valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ],
        );
      },
    );

    return _progressBuilder!;
  }

  // Construeix el contingut normal de l'AppBar quan no està carregant
  Widget buildNormalContent(BuildContext context) {
    return _progressBuilder ??= GetBuilder<LdAppBarWidgetCtrl>(
      id: appBarProgressIdx,
      tag: appBarProgressIdx,
      init: this,
      builder:
          (ctrl) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: txsAppBarTitleStyle()),
              if (subtitle != null)
                Text(
                  subtitle!,
                  style: txsAppBarSubtitleStyle(
                    pFgColor: viewCtrl.state.isError ? Colors.red : null,
                  ),
                  textHeightBehavior: TextHeightBehavior(
                    applyHeightToFirstAscent: true,
                    applyHeightToLastDescent: true,
                  ),
                ),
            ],
          ),
    );
  }

  // 🌥️ 'LdCtrl' ----------------------
  @override
  Widget build(BuildContext pBCtx) {
    final theme = Theme.of(pBCtx);

    // Preparem accions amb espais entre elles i marge a la dreta si n'hi ha
    List<Widget>? spacedActions;
    if (_actions != null && _actions.isNotEmpty) {
      spacedActions = [];
      // Afegim cada acció seguida d'un espai
      for (int i = 0; i < _actions.length; i++) {
        // Afegim l'acció
        spacedActions.add(_actions[i]);
        // Si no és l'última, afegim un espai
        if (i < _actions.length - 1) {
          spacedActions.add(SizedBox(width: _actionButtonsSpacing.w));
        }
      }
      
      // Afegim el marge a la dreta
      spacedActions.add(SizedBox(width: _actionsRightMargin.w));
    }

    return AppBar(
          titleSpacing: (showBackButton || showDrawerIcon) ? 0.0.h : 15.0.h,
          automaticallyImplyLeading: false,
          leading: buildLeadingIcon(pBCtx),
          backgroundColor:
              theme.brightness == Brightness.dark
                  ? Colors.blueGrey[800] // Color fosc per al tema fosc
                  : theme.colorScheme.primary,
          foregroundColor: theme.colorScheme.onPrimary,
          title:
              (showProgress)
                  ? buildProgressContent(pBCtx)
                  : buildNormalContent(pBCtx),
          actions: [...?spacedActions],
          bottom:
              showProgress && isNotNull(progress)
                  ? PreferredSize(
                    preferredSize: const Size.fromHeight(2.0),
                    child: LinearProgressIndicator(value: progress),
                  )
                  : null,
        );
  }
  
  @override
  String get baseTag => "LdAppbarCtrl";
  
  @override
  void connectState() {
  }
  
}