// Abstracció d'un estat general de l'aplicació.
// CreatedAt: 2025/08/18 dt. JIQ

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:ld_wbench4/03_core/ld_ctrl.dart';
import 'package:ld_wbench4/03_core/ld_tag_interface.dart';
import 'package:ld_wbench4/08_streams/ld_stream_envelope.dart';
import 'package:ld_wbench4/08_streams/ld_stream_mixin.dart';

import 'package:ld_wbench4/03_core/ld_tag_mixin.dart';
import 'package:ld_wbench4/04_manager/injection/ld_binding.dart';

abstract class LdState<
  T extends LdStreamEnvelope,
  C extends LdCtrl<T, StatefulWidget, LdState<T, C>>
> 
with       LdTagMixin, LdStreamMixin<T>
implements LdTagIntf {
  // 📝 ESTÀTICS -----------------------
  
  // 🧩 MEMBRES ------------------------
  bool _isVirgin = true;
  bool _isCtrlSet = false;
  late LdCtrl _ctrl;

  // 🛠️ CONSTRUCTOR/DISPOSE -----------
  LdState({String? pTag, bool pCreateStream = true }) {
    LdBinding bind = LdBinding.single;
    tag = bind.newStateTag(pTag ?? baseTag);
    bind.add(tag, this);
    if (pCreateStream) {
      initStream();
    }
  }

  void dispose() {
    disposeStream();
    LdBinding.single.remove(tag);
  }

  // 📥 GETTERS/SETTERS ----------------
  LdCtrl get ctrl => _ctrl;
  set ctrl(LdCtrl pCtrl) {
    assert(!_isCtrlSet);
    _isCtrlSet = true;
    _ctrl = pCtrl;
  }

  // 🔄 CICLE DE CÀRREGA -------------
  /// Funció a implementar en cada classe filla per a la càrrega de les dades.
  Future<T?> dataProcess({ String? pSrcTag, String? pTgtTag });

  /// Executa la càrrega completa de dades
  /// Segueix el flux: Preparant -> Carregant -> Carregat/Error
  Future<T?> loadData({ String? pSrcTag, String? pTgtTag }) async {
    T? result;

    emitPreparing(pSrcTag: pSrcTag?? tag, pTgtTag: pTgtTag, pIsVirgin: _isVirgin);
    
    // Donem un petit temps perquè la UI mostri l'estat "preparant" abans de canviar a "carregant"
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      (_isVirgin)
        ? emitLoading(pSrcTag: pSrcTag?? tag, pTgtTag: pTgtTag)
        : emitReloading(pSrcTag: pSrcTag?? tag, pTgtTag: pTgtTag);
      
      try {
        result = await dataProcess(pSrcTag: pSrcTag,  pTgtTag: pTgtTag);
        _isVirgin = false;
        emitLoaded(pSrcTag: pSrcTag?? tag, pTgtTag: pTgtTag, data: result);

      } on Exception catch (exc) {
        String msg = "$baseTag.loadData(): ${exc.toString()}";
        emitError(
          pSrcTag:   pSrcTag?? tag,
          pTgtTag:   pTgtTag,
          error:     msg, 
          exception: Exception(msg)
        );
      } on Error catch (err) {
        String msg = "$baseTag.loadData(): ${err.toString()}";
        emitError(
          pSrcTag:   pSrcTag?? tag,
          pTgtTag:   pTgtTag,
          error:     msg, 
          exception: Exception(msg)
        );
      }
    });

    return result;
  }
  
  /// Executa una funció i captura errors
  /// Útil per operacions que no afecten l'estat principal però poden fallar
  Future<R?> safeExecute<R>({ String? pSrcTag, String? pTgtTag, required Future<R> Function() pCBack }) async {
    try {
      return await pCBack();
    } on Exception catch (exc) {
      String msg = "$baseTag.safeExecute(pSrcpTag: ${pSrcTag?? tag}, pTgtTag: $pTgtTag}, EXC): ${exc.toString()}";
      emitError(
        pSrcTag:   pSrcTag?? tag,
        pTgtTag:   pTgtTag,
        error:     msg, 
        exception: Exception(msg)
      );
    } on Error catch (err) {
      String msg = "$baseTag.safeExecute(pTag: ${pSrcTag?? tag}, pTgtTag: $pTgtTag}, ERR): ${err.toString()}";
      emitError(
        pSrcTag:   pSrcTag?? tag,
        pTgtTag:   pTgtTag,
        error:     msg, 
        exception: Exception(msg)
      );
    }
    return null;
  }
}
