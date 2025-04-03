// ld_state.dart
// 
// Estat general d'un controlador.
// CreatedAt: 2025/03/31 dl. CLA[JIQ]

import 'package:flutter/material.dart';
import 'package:ld_wbench4/03_core/events/ld_event.dart';
import 'package:ld_wbench4/03_core/enums/state_event_enum.dart';
import 'package:ld_wbench4/03_core/ld_ctrl.dart';
import 'package:ld_wbench4/03_core/mixins/ld_event_emitter_mixin.dart';
import 'package:ld_wbench4/03_core/interfaces/ld_tag_intf.dart';
import 'package:ld_wbench4/03_core/mixins/ld_tag_mixin.dart';
import 'package:ld_wbench4/04_manager/injection/ld_binding.dart';
import 'package:ld_wbench4/05_tools/ld_map.dart';
import 'package:ld_wbench4/07_models/ld_model.dart';

abstract class LdState<
  FW extends StatefulWidget,
  M  extends LdModel
>
with       LdTagMixin, LdEventEmitterMixin
implements LdTagIntf {
  // 🧩 MEMBRES ------------------------
  bool    _isVirgin = true,   _isCtrlSet = false;
  bool    _isLoading = false, _isError = false;
  String? _errorMessage;
  String? _loadingElement;
  (int, int, double?) _stats = (0, 0, null);
  
  /// Controlador associat a l'estat
  late LdCtrl<FW, M> _ctrl;

  // 🛠️ CONSTRUCTOR/DISPOSE -----------
  LdState({ String? pTag }) {
    LdBinding bind = LdBinding.single;
    tag = bind.newStateTag(pTag ?? baseTag);
    bind.add(tag, this);
  }

  @mustCallSuper
  void dispose() {
    LdBinding.single.remove(tag);
  }

  // 📥 GETTERS/SETTERS ----------------
  bool    get isLoading         => _isLoading;
  bool    get isError           => _isError;
  String? get errorMessage      => _errorMessage;
  (int, int, double?) get stats => _stats;
  String? get loadingElement    => _loadingElement;
  
  bool get isVirgin => _isVirgin;
  set isVirgin(bool pIsVirgin) => _isVirgin = pIsVirgin;
  
  LdCtrl<FW, M> get ctrl => _ctrl;
  set ctrl(LdCtrl<FW, M> pCtrl) {
    assert(!_isCtrlSet);
    _isCtrlSet = true;
    _ctrl      = pCtrl;
  }

  // 🌥️ CÀRREGA DE DADES ASÍNCRONA ----
  /// Funció del cicle de càrrega de dades pel LdState.
  Future<M?> loadData({ String? pSrcTag, List<String>? pTgtTags }) async {
    M? result;

    emitPreparing(
      pSrcTag:   pSrcTag ?? tag,
      pTgtTags:  pTgtTags,
      pIsVirgin: isVirgin);
    
    // Donem un petit temps perquè la UI mostri l'estat "preparant" abans de 
    // canviar a "carregant"
    await Future.delayed(Duration(milliseconds: 50));
    
    (isVirgin)
      ? emitLoading(pSrcTag: pSrcTag ?? tag, pTgtTags: pTgtTags)
      : emitReloading(pSrcTag: pSrcTag ?? tag, pTgtTags: pTgtTags);
    
    try {
      result = await dataProcess(pSrcTag: pSrcTag, pTgtTags: pTgtTags);
      isVirgin = false;
      if (result != null) {
        emitLoaded(pSrcTag: pSrcTag ?? tag, pTgtTags: pTgtTags, pData: result);
      } else {
        throw Exception("Error carregant des de '$pSrcTag!");
      }
    } catch (e) {
      String msg = "$baseTag.loadData(): ${e.toString()}";
      emitError(
        pSrcTag: pSrcTag ?? tag,
        pTgtTags: pTgtTags,
        error: msg,
        exception: e is Exception ? e : Exception(msg)
      );
    }
    return result;
  }

  // 🌥️ FUNCIONALITAT -----------------
  /// Emet un event de canvi d'estat.
  void emitPreparing({ 
    required String pSrcTag, 
    List<String>?   pTgtTags,
    required bool   pIsVirgin }) {
    _isLoading = true;
    _isError = false;
    
    emitEvent(LdEventState(
      pSrcTag: tag,
      pState:  StateEvent.preparingView,
    ));
  }

  void emitLoading({required String pSrcTag, List<String>? pTgtTags, String? pElement}) {
    _isLoading = true;
    _isError = false;
    _loadingElement = pElement;
    
    emitEvent(LdEventState(
      pSrcTag: tag,
      pState:  StateEvent.loadingView,
      pIsVirgin: _isVirgin,
    ));
  }

  void emitReloading({required String pSrcTag, List<String>? pTgtTags}) {
    _isLoading = true;
    _isError   = false;

    emitEvent(LdEventState(
      pSrcTag: tag,
      pState: StateEvent.reloadingView,
      pIsVirgin: _isVirgin,
    ));
  }

  void emitLoaded({
    required String pSrcTag,
    List<String>? pTgtTags, 
    required M pData}) {
    _isLoading = false;
    _isError = false;
    
    emitEvent(LdEventData(
      pSrcTag:   tag,
      pData:     pData,
      pState:    StateEvent.loadedView,
      pIsVirgin: _isVirgin,
    ));
  }

  void emitMap({
    String? pSubType,
    required String pSrcTag,
    List<String>? pTgtTags, 
    required LdMap pMap }) {
    emitEvent(LdEventMap(
      pSrcTag:  tag,
      pSubType: pSubType,
      pMap:     pMap,
    ));
  }
  void emitError({
    required String pSrcTag,
    List<String>? pTgtTags,
    required String error,
    Exception? exception
  }) {
    _isLoading = false;
    _isError = true;
    _errorMessage = error;
    
    emitEvent(LdEventState(
      pSrcTag: tag,
      pState: StateEvent.errorView,
    ));
  }

  void updateStats(int pTotal, int pCurrent, [double? pPercentage]) {
    _stats = (pTotal, pCurrent, pPercentage);
    
    // Opcional: emetre un event específic per a actualització d'estadístiques
    emitEvent(LdEventStats(
      pSrcTag: tag,
      pTotal: pTotal,
      pCurrent: pCurrent,
      pPercentage: pPercentage,
    ));
  }

  // 🔄 CICLE DE CÀRREGA -------------
  /// Càrrega de dades específica de cada LdState.
  Future<M?> dataProcess({ String? pSrcTag, List<String>? pTgtTags });
}