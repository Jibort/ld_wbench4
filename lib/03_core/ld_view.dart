// Abstracció d'una vista de l'aplicació.
// CreatedAt: 2025/03/18 dt. JIQ

import 'package:flutter/material.dart';
import 'package:ld_wbench4/03_core/ld_tag_interface.dart';
import 'package:ld_wbench4/03_core/ld_tag_mixin.dart';
import 'package:ld_wbench4/03_core/ld_view_ctrl.dart';
import 'package:ld_wbench4/03_core/ld_view_state.dart';
import 'package:ld_wbench4/04_manager/injection/ld_binding.dart';
import 'package:ld_wbench4/08_streams/ld_stream_envelope.dart';

export 'package:ld_wbench4/03_core/ld_view_ctrl.dart';
export 'package:ld_wbench4/03_core/ld_view_state.dart';

abstract class LdView<
  T extends LdStreamEnvelope,
  S extends LdViewState<T, dynamic, dynamic>
> 
extends    StatefulWidget 
with       LdTagMixin 
implements LdTagIntf {
  // 📝 ESTÀTICS -----------------------

  // 🧩 MEMBRES ------------------------
  final S _state;
  
  // 📥 GETTERS/SETTERS ----------------
  S get state => _state;

  // 🛠️ CONSTRUCTOR/DISPOSE -----------
  LdView({super.key,  String? pTag, required S pState })
  : _state = pState {
    LdBinding bind = LdBinding.single;
    tag = bind.newViewTag(pTag?? baseTag);
    bind.add(tag, this);
  }

  void dispose() {
    LdBinding.single.remove(tag);
    _state.dispose();
  }

  /// 🌥️ 'LdTagIntf' ------------------
  @override
  String get baseTag => "LdView";

  /// 🌥️ 'StatelessState' -------------
  @override
  C createState();
}