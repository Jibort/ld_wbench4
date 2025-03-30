// Abstracció d'una vista de l'aplicació.
// CreatedAt: 2025/03/18 dt. JIQ

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ld_wbench4/03_core/ld_tag_interface.dart';
import 'package:ld_wbench4/03_core/ld_tag_mixin.dart';
import 'package:ld_wbench4/03_core/ld_view.dart';
import 'package:ld_wbench4/03_core/ld_widget_ctrl.dart';
import 'package:ld_wbench4/03_core/ld_widget_state.dart';
import 'package:ld_wbench4/04_manager/injection/ld_binding.dart';
import 'package:ld_wbench4/07_models/ld_model.dart';
import 'package:ld_wbench4/08_streams/ld_stream_envelope.dart';

export 'package:ld_wbench4/03_core/ld_widget_ctrl.dart';
export 'package:ld_wbench4/03_core/ld_widget_state.dart';

abstract class LdWidget<
  T extends LdStreamEnvelope,
  C extends LdWidgetCtrl<T, LdWidget<T, C, S>, S>,
  S extends LdWidgetState<T, C, S>
>
extends    StatelessWidget  
with       LdTagMixin
implements LdTagIntf {
  // 📝 ESTÀTICS -----------------------
  
  // 🧩 MEMBRES ------------------------
  StreamSubscription<LdStreamEnvelope>? _lstn;

  final LdWidgetState _state;
  final LdWidgetCtrl  _ctrl;  
  final LdView        _view;

  // 🛠️ CONSTRUCTOR/DISPOSE -----------
  LdWidget({
    super.key, 
    String? pTag, 
    required LdView pView, 
    required LdWidgetState pState, 
    required LdWidgetCtrl pCtrl })
  : _state = pState,
    _ctrl = pCtrl,
    _view = pView {
    LdBinding bind = LdBinding.single;
    tag = bind.newViewTag(pTag?? baseTag);
    bind.add(tag, this);
    LdBinding.single.add(tag, this);
    _lstn = _view.state.subscribe(
      pLstn: listen,
      pOnError: onError,
      pOnDone: onDone,
      cancelOnError: true,
    );

  }

  void dispose() {
    _view.state.unsubscribe(_lstn);
    LdBinding.single.remove(tag);
    _state.dispose();
    _ctrl.dispose();
  }

  // 📥 GETTERS/SETTERS ----------------
  LdWidgetState get state => _state;
  LdWidgetCtrl  get ctrl  => _ctrl;
  LdView        get view  => _view;

  // 🌥️ 'LdWidget' ---------------------
  @override
  Widget build(BuildContext pBCtx) {
    return _ctrl.build(pBCtx);
  }
 
  // 🌥️ 'LdTagIntf' -------------------
  @override
  String get baseTag => "LdWidget";

  // 🌥️ FUNCIONS ESTÀTIQUES -----------
  void listen(LdStreamEnvelope<LdModel> pEnv);
  void onError();
  void onDone();
}