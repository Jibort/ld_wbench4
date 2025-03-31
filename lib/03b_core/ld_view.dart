// Abstracció d'una vista de l'aplicació.
// CreatedAt: 2025/03/18 dt. JIQ

import 'package:flutter/material.dart';
import 'package:ld_wbench4/03_core/ld_tag_interface.dart';
import 'package:ld_wbench4/03_core/ld_tag_mixin.dart';
import 'package:ld_wbench4/03b_core/ld_view_ctrl.dart';
import 'package:ld_wbench4/03b_core/ld_view_state.dart';
import 'package:ld_wbench4/04_manager/injection/ld_binding.dart';

export 'package:ld_wbench4/03b_core/ld_view_ctrl.dart';
export 'package:ld_wbench4/03b_core/ld_view_state.dart';

abstract class LdView
extends    StatefulWidget
with       LdTagMixin
implements LdTagIntf {
  // 📝 ESTÀTICS -----------------------
  
  // 🧩 MEMBRES ------------------------
  final LdViewState _state;
  
  // 📥 GETTERS/SETTERS ----------------
  LdViewState get state => _state;

  // 🛠️ CONSTRUCTOR/DISPOSE -----------
  LdView({super.key,  String? pTag, required LdViewState pState })
  : _state = pState {
    LdBinding bind = LdBinding.single;
    tag = bind.newViewTag(pTag?? baseTag);
    bind.add(tag, this);
  }

  void dispose() {
    LdBinding.single.remove(tag);
    _state.dispose();
  }

  /// 🌥️ 'StatefulState' -------------
  @override LdViewCtrl createState();

  /// 🌥️ 'LdTagIntf' ------------------
  @override
  String get baseTag => "LdView";
}