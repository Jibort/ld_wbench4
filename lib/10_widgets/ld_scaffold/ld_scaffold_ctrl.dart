//
// CreatedAt: 2025/03/23 dg. CLA[JIQ].

import 'package:flutter/material.dart';

import 'package:ld_wbench4/03b_core/ld_widget.dart';
import 'package:ld_wbench4/10_widgets/ld_app_bar/ld_appbar_widget.dart';

class LdScaffoldCtrl<W extends LdWidget>
extends LdWidgetCtrl<W> {
  // 🧩 MEMBRES ------------------------
  final Widget?   _body;
  final LdAppbar? _appBar;
  final Widget?   _btnFloatingAction;
  final Color?    _backgroundColor;
  final bool      _resizeToAvoidBottomInset;
  
  // 🛠️ CONSTRUCTOR/DISPOSE -----------
  LdScaffoldCtrl({
    required super.pTag,
    required super.pView,
    required String pTitle,
    String?  pSubtitle,
    Widget?  pBody,
    Widget?  pDrawer,
    Widget?  pEndDrawer,
    Widget?  pBtnFloatingAction,
    Color?   pBgColor,
    bool     pResizeToAvoidBottomInset = true,
  }) : 
    _appBar = LdAppbar(
      pTag: null,
      pView: pView,
      pTitle: pTitle,
      pSubtitle: pSubtitle,
      pDrawer: pDrawer,
      pEndDrawer: pEndDrawer,
    ),
    _body                     = pBody,
    _btnFloatingAction        = pBtnFloatingAction,
    _backgroundColor          = pBgColor,
    _resizeToAvoidBottomInset = pResizeToAvoidBottomInset;
    
  
  @override
  void dispose() {
    super.dispose();
  }

  // 📥 GETTERS/SETTERS ----------------
  Widget    get body                     => _body ?? Container();
  LdAppbar? get appBar                   => _appBar;
  Widget?   get floatingActionButton     => _btnFloatingAction;
  Color?    get backgroundColor          => _backgroundColor;
  bool      get resizeToAvoidBottomInset => _resizeToAvoidBottomInset;

  @override
  Widget build(BuildContext pBCtx) {
    throw UnimplementedError();
  }

  // 'LdTagIntf' ----------------------
  @override String get baseTag => "LdScaffoldCtrl";
  
  // 'LdWidget' ----------------------
  @override
  void connectState() {
  }
}