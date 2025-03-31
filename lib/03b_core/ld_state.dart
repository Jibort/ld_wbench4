// Abstracció d'un estat general de l'aplicació.
// CreatedAt: 2025/08/18 dt. JIQ

import 'dart:async';
import 'package:flutter/scheduler.dart';

import 'package:ld_wbench4/03b_core/ld_ctrl.dart';
import 'package:ld_wbench4/03_core/ld_tag_interface.dart';
import 'package:ld_wbench4/03_core/ld_tag_mixin.dart';
import 'package:ld_wbench4/04_manager/injection/ld_binding.dart';
import 'package:ld_wbench4/07_models/ld_model.dart';
import 'package:ld_wbench4/08_streams/ld_stream_envelope.dart';
import 'package:ld_wbench4/08_streams/ld_stream_mixin.dart';

abstract class LdState<T extends LdStreamEnvelope<LdModel>>
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
  Future<T?> dataProcess({ String? pSrcTag, List<String>? pTgtTags });

  /// Executa la càrrega completa de dades
  /// Segueix el flux: Preparant -> Carregant -> Carregat/Error
  Future<T?> loadData({ String? pSrcTag, List<String>? pTgtTags }) async {
    T? result;

    emitPreparing(pSrcTag: pSrcTag?? tag, pTgtTags: pTgtTags, pIsVirgin: _isVirgin);
    
    // Donem un petit temps perquè la UI mostri l'estat "preparant" abans de canviar a "carregant"
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      (_isVirgin)
        ? emitLoading(pSrcTag: pSrcTag?? tag, pTgtTags: pTgtTags)
        : emitReloading(pSrcTag: pSrcTag?? tag, pTgtTags: pTgtTags);
      
      try {
        result = await dataProcess(pSrcTag: pSrcTag,  pTgtTags: pTgtTags);
        _isVirgin = false;
        emitLoaded(pSrcTag: pSrcTag?? tag, pTgtTags: pTgtTags, data: result);

      } on Exception catch (exc) {
        String msg = "$baseTag.loadData(): ${exc.toString()}";
        emitError(
          pSrcTag:   pSrcTag?? tag,
          pTgtTags:   pTgtTags,
          error:     msg, 
          exception: Exception(msg)
        );
      } on Error catch (err) {
        String msg = "$baseTag.loadData(): ${err.toString()}";
        emitError(
          pSrcTag:   pSrcTag?? tag,
          pTgtTags:   pTgtTags,
          error:     msg, 
          exception: Exception(msg)
        );
      }
    });

    return result;
  }
  
  /// Executa una funció i captura errors
  /// Útil per operacions que no afecten l'estat principal però poden fallar
  Future<R?> safeExecute<R>({ String? pSrcTag, List<String>? pTgtTags, required Future<R> Function() pCBack }) async {
    try {
      return await pCBack();
    } on Exception catch (exc) {
      String msg = "$baseTag.safeExecute(pSrcpTag: ${pSrcTag?? tag}, pTgtTag: $pTgtTags}, EXC): ${exc.toString()}";
      emitError(
        pSrcTag:   pSrcTag?? tag,
        pTgtTags:  pTgtTags,
        error:     msg, 
        exception: Exception(msg)
      );
    } on Error catch (err) {
      String msg = "$baseTag.safeExecute(pTag: ${pSrcTag?? tag}, pTgtTag: $pTgtTags}, ERR): ${err.toString()}";
      emitError(
        pSrcTag:   pSrcTag?? tag,
        pTgtTags:   pTgtTags,
        error:     msg, 
        exception: Exception(msg)
      );
    }
    return null;
  }
}
