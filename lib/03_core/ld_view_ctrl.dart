// Abstracció del controlador d'una vista.
// CreatedAt: 2025/03/18 dt. 

import 'package:flutter/material.dart';
import 'package:ld_wbench4/03_core/ld_ctrl.dart';
import 'package:ld_wbench4/03_core/ld_view.dart';
import 'package:ld_wbench4/08_streams/ld_stream_envelope.dart';

abstract class LdViewCtrl<
  T extends LdStreamEnvelope,
  V extends LdView<T, dynamic>,
  S extends LdViewState<T, dynamic, dynamic>
> extends LdCtrl<T, V, S> {
  // 📝 ESTÀTICS -----------------------
  
  // 🧩 MEMBRES ------------------------
  
  // 🛠️ CONSTRUCTOR/DISPOSE -----------
  LdViewCtrl({ super.pTag });

  @override
  void dispose() {
    super.dispose();
  }

  // 📥 GETTERS/SETTERS ----------------
  
  // 🌥️ 'LdCtrl' ----------------------
  @override
  Widget build(BuildContext pBCtx);
}