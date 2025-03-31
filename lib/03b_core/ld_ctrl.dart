// Abstracció d'un controlador general de l'aplicació.
// CreatedAt: 2025/08/18 dt. JIQ

import 'package:flutter/widgets.dart';

import 'package:ld_wbench4/03b_core/ld_state.dart';
import 'package:ld_wbench4/03_core/ld_tag_interface.dart';
import 'package:ld_wbench4/03_core/ld_tag_mixin.dart';
import 'package:ld_wbench4/04_manager/injection/ld_binding.dart';

abstract class LdCtrl<V extends StatefulWidget>
extends    State<V>
with       LdTagMixin
implements LdTagIntf {
  // 📝 ESTÀTICS -----------------------
  
  // 🧩 MEMBRES ------------------------
  bool _isStateSet = false;
  late LdState _state;
  
  // 🛠️ CONSTRUCTOR/DISPOSE -----------
  LdCtrl({ String? pTag }) {
    LdBinding bind = LdBinding.single;
    tag = bind.newCtrlTag(pTag?? baseTag);
    bind.add(tag, this);
  }

  @override
  @mustCallSuper
  void dispose() {
    LdBinding.single.remove(tag);
    super.dispose();
  }

  // 📥 GETTERS/SETTERS ----------------
  LdState get state => _state;
  set state(LdState pState) {
    assert(!_isStateSet);
    _isStateSet = true;
    _state = pState;
  }

  // 🌥️ 'State' -----------------------
  @override
  void initState() {
    super.initState();
    connectState();
  }
  
  // 🌥️ FUNCIONS ABSTRACTES -----------
  void connectState();

  @override Widget build(BuildContext pBCtx);
}
