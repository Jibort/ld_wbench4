// Abstracció d'un controlador general de l'aplicació.
// CreatedAt: 2025/08/18 dt. JIQ

import 'package:flutter/widgets.dart';
import 'package:ld_wbench4/03_core/ld_state.dart';

import 'package:ld_wbench4/03_core/ld_tag_mixin.dart';
import 'package:ld_wbench4/04_manager/injection/ld_binding.dart';
import 'package:ld_wbench4/07_models/ld_stream_envelope.dart';

abstract class LdCtrl<
  T extends LdStreamEnvelope,
  S extends LdState
>
with LdTagMixin {
  // 📝 ESTÀTICS -----------------------
  static const String className = "LdCtrl";
  
  // 🧩 MEMBRES ------------------------
  bool _isStateSet = false;
  late S _state;
  
  // 🛠️ CONSTRUCTOR/DISPOSE -----------
  LdCtrl({ required String pTag }) {
    LdBinding bind = LdBinding.single;
    tag = bind.newViewTag(pTag);
    bind.add(pTag, this);
  }

  @mustCallSuper
  void dispose() {
    _state.dispose();
    LdBinding.single.remove(tag);
  }

  // 📥 GETTERS/SETTERS ----------------
  S get state => _state;
  set state(S pState) {
    assert(!_isStateSet);
    _isStateSet = true;
    _state = pState;
  }

}
