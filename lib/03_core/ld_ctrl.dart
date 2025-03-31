// ld_ctrl.dart
//
// Controlador general d'un estat.
// CreatedAt: 2025/03/31 dl. CLA[JIQ}

import 'package:flutter/material.dart';
import 'package:ld_wbench4/03_core/ld_event_emitter_mixin.dart';
import 'package:ld_wbench4/03_core/ld_tag_interface.dart';
import 'package:ld_wbench4/03_core/ld_tag_mixin.dart';
import 'package:ld_wbench4/04_manager/injection/ld_binding.dart';

abstract   class LdCtrl<V extends Widget> 
with       LdTagMixin, LdEventEmitterMixin 
implements LdTagIntf {
  late final BuildContext? _context;

  LdCtrl({String? pTag}) {
    LdBinding bind = LdBinding.single;
    tag = bind.newCtrlTag(pTag ?? baseTag);
    bind.add(tag, this);
  }

  void dispose() {
    LdBinding.single.remove(tag);
  }

  BuildContext? get context => _context;
  set context(BuildContext? newCtx) {
    _context = newCtx;
  }

  @override
  String get baseTag;

  Widget build(BuildContext context);
  
  void connectState();
  
  void emitControllerEvent(String eventType, {Map<String, dynamic>? data}) {
    emitEvent(LdControllerEvent(
      eventType: eventType,
      data: data,
      sourceTag: tag
    ));
  }
}