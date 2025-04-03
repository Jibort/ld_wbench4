// ld_ctrl.dart
//
// Controlador general d'un estat.
// CreatedAt: 2025/04/01 dt. JIQ

// ignore_for_file: annotate_overrides, avoid_renaming_method_parameters

import 'package:flutter/material.dart';
import 'package:ld_wbench4/03_core/ld_state.dart';
import 'package:ld_wbench4/03_core/mixins/ld_event_emitter_mixin.dart';
import 'package:ld_wbench4/03_core/interfaces/ld_tag_intf.dart';
import 'package:ld_wbench4/03_core/mixins/ld_tag_mixin.dart';
import 'package:ld_wbench4/04_manager/injection/ld_binding.dart';
import 'package:ld_wbench4/07_models/ld_model.dart';

abstract class LdCtrl<
  FW extends StatefulWidget,
  M  extends LdModel
>
extends    State<FW>
with       LdTagMixin, LdEventEmitterMixin 
implements LdTagIntf {
  // 🧩 MEMBRES ------------------------
  ///Estat associat al controlador.
  LdState<FW, M> _state;
  
  // 🛠️ CONSTRUCTOR/DISPOSE -----------
  LdCtrl({String? pTag, required LdState<FW, M> pState})
  : _state = pState {
    LdBinding bind = LdBinding.single;
    tag = bind.newCtrlTag(pTag ?? baseTag);
    bind.add(tag, this);
    _state.ctrl = this;
  }

  /// Called when this object is removed from the tree permanently.
  @override
  @mustCallSuper
  void dispose() {
    LdBinding.single.remove(tag);
    _state.dispose();
    super.dispose();
  }

  // 📥 GETTERS/SETTERS ----------------
  LdState<FW, M> get state => _state;
  set state(LdState<FW, M> pState) => _state = pState;
  
  // 🌥️ FUNCIONS ABSTRACTES -----------
  @override String get baseTag => "LdCtrl";
  void connectState();

  // 🌥️ 'State' -----------------------
  /// Called when this object is inserted into the tree.
  @protected
  @mustCallSuper 
  void initState();

  @protected
  @mustCallSuper
  void didUpdateWidget(covariant FW pOldWidget);

  @protected
  @mustCallSuper
  void reassemble();

  /// Called when this object is removed from the tree.
  @protected
  @mustCallSuper
  void deactivate();

  /// Called when this object is reinserted into the tree after having been
  /// removed via [deactivate].
  @protected
  @mustCallSuper
  void activate();

  /// Descriu la interefície d'usuari d'una vista o un widget.
  @protected
  Widget build(BuildContext pBCtx);

  /// Called when a dependency of this [State] object changes.
  @protected
  @mustCallSuper
  void didChangeDependencies();


  // 🌥️ FUNCIONALITAT -----------------
  /// Executa una funció i captura errors
  /// Útil per operacions que no afecten l'estat principal però poden fallar
  Future<R?> safeExecute<R>({ String? pSrcTag, List<String>? pTgtTags, required Future<R> Function() pCBack }) async {
    try {
      return await pCBack();
    } on Exception catch (exc) {
      String msg = "$baseTag.safeExecute(pSrcpTag: ${pSrcTag?? tag}, pTgtTag: $pTgtTags}, EXC): ${exc.toString()}";
      _state.emitError(
        pSrcTag:   pSrcTag?? tag,
        pTgtTags:  pTgtTags,
        error:     msg, 
        exception: Exception(msg)
      );
    } on Error catch (err) {
      String msg = "$baseTag.safeExecute(pTag: ${pSrcTag?? tag}, pTgtTag: $pTgtTags}, ERR): ${err.toString()}";
      _state.emitError(
        pSrcTag:   pSrcTag?? tag,
        pTgtTags:   pTgtTags,
        error:     msg, 
        exception: Exception(msg)
      );
    }
    return null;
  }

  // 🌥️ 'StateFullWidget' -------------
}