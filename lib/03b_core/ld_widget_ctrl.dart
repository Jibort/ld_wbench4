// Abstracció del controlador d'una vista.
// CreatedAt: 2025/03/18 dt. 

import 'package:flutter/material.dart';
import 'package:ld_wbench4/03b_core/ld_ctrl.dart';
import 'package:ld_wbench4/03b_core/ld_view.dart';
import 'package:ld_wbench4/03b_core/ld_widget.dart';

abstract class LdWidgetCtrl<V  extends LdWidget>
extends LdCtrl<V> {
  // 📝 ESTÀTICS -----------------------
  
  // 🧩 MEMBRES ------------------------
  final LdView _view;
  bool  _enabled;
  bool  _focusable;
  bool  _visible;

  // 🛠️ CONSTRUCTOR/DISPOSE -----------
  LdWidgetCtrl({
    required super.pTag,
    required LdView pView,
    bool pEnabled = true, 
    bool pFocusable = true, 
    bool pVisible = true,
  }): 
    _view = pView,
    _enabled = pEnabled, 
    _focusable = pFocusable, 
    _visible = pVisible;

  @override
  @mustCallSuper
  void dispose() {
    super.dispose();
  }
  
  // 📥 GETTERS/SETTERS ----------------
  LdView get view => _view;
  bool get enabled => _enabled;
       set enabled(bool pEnabled) => _enabled = pEnabled;
  bool get focusable => _focusable;
       set focusable(bool pFocusable) => _focusable = pFocusable;
  bool get visible => _visible;
       set visible(bool pVisible) => _visible = pVisible;




}