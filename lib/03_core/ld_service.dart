// Abstracció d'una vista de l'aplicació.
// CreatedAt: 2025/03/18 dt. JIQ


import 'package:flutter/material.dart';
import 'package:ld_wbench4/03_core/interfaces/ld_tag_intf.dart';
import 'package:ld_wbench4/03_core/mixins/ld_event_emitter_mixin.dart';
import 'package:ld_wbench4/03_core/mixins/ld_tag_mixin.dart';
import 'package:ld_wbench4/04_manager/injection/ld_binding.dart';

/// Abstracció d'una vista de l'aplicació.
abstract   class LdService
extends    StatefulWidget
with       LdTagMixin, LdEventEmitterMixin
implements LdTagIntf {
  LdService({ super.key, String? pTag }) {
    LdBinding bind = LdBinding.single;
    tag = bind.newCtrlTag(pTag ?? baseTag);
    bind.add(tag, this);
  }
  
  
  // 🌥️ FUNCIONS ABSTRACTES -----------
  /// Funció per a alliberar recursos del servei.
  void dispose();
  @override String get baseTag => "LdService";
}