// Abstracció d'una vista de l'aplicació.
// CreatedAt: 2025/03/18 dt. JIQ

import 'package:flutter/material.dart';
import 'package:ld_wbench4/03_core/ld_tag_mixin.dart';
import 'package:ld_wbench4/03_core/ld_view.dart';
import 'package:ld_wbench4/03_core/ld_widget_ctrl.dart';
import 'package:ld_wbench4/03_core/ld_widget_state.dart';
import 'package:ld_wbench4/04_manager/injection/ld_binding.dart';

export 'package:ld_wbench4/03_core/ld_widget_ctrl.dart';
export 'package:ld_wbench4/03_core/ld_widget_state.dart';

abstract class LdWidget 
extends StatelessWidget  
with LdTagMixin {
  // 📝 ESTÀTICS -----------------------
  static const String className = "LdWidgetState";
  
  // 🧩 MEMBRES ------------------------
  final LdWidgetState _state;
  final LdWidgetCtrl  _ctrl;
  final LdView        _view;

  // 🛠️ CONSTRUCTOR/DISPOSE -----------
  LdWidget({super.key, required String pTag, required LdView pView, required LdWidgetState pState, required LdWidgetCtrl pCtrl})
  : _state = pState,
    _ctrl = pCtrl,
    _view = pView {
    LdBinding.single.add(tag, this);
  }

  void dispose() {
    LdBinding.single.remove(tag);
    _state.dispose();
    _ctrl.dispose();
  }

  // 📥 GETTERS/SETTERS ----------------
  LdWidgetState get state => _state;
  LdWidgetCtrl  get ctrl  => _ctrl;
  LdView        get view  => _view;
 
}