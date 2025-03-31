// Abstracció del controlador d'una vista.
// CreatedAt: 2025/03/18 dt. 

import 'package:flutter/material.dart';
import 'package:ld_wbench4/03b_core/ld_ctrl.dart';
import 'package:ld_wbench4/03b_core/ld_view.dart';

abstract class LdViewCtrl<V extends LdView>
extends LdCtrl<V> {
  // 📝 ESTÀTICS -----------------------
  
  // 🧩 MEMBRES ------------------------
  
  // 🛠️ CONSTRUCTOR/DISPOSE -----------
  LdViewCtrl({ super.pTag });

  @override
  @mustCallSuper
  void dispose() {
    super.dispose();
  }

  // 📥 GETTERS/SETTERS ----------------
  
  // 🌥️ 'LdCtrl' ----------------------
  @override Widget build(BuildContext pBCtx);
}