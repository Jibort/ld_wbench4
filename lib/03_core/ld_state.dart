// Abstracció d'un estat general de l'aplicació.
// CreatedAt: 2025/08/18 dt. JIQ

import 'dart:async';
import 'package:flutter/scheduler.dart';
import 'package:ld_wbench4/03_core/ld_stream_mixin.dart';

import 'package:ld_wbench4/03_core/ld_tag_mixin.dart';
import 'package:ld_wbench4/04_manager/injection/ld_binding.dart';
import 'package:ld_wbench4/07_models/ld_stream_envelope.dart';

abstract class LdState<
  T extends LdStreamEnvelope,
  LdCtrl
>
with LdTagMixin, LdStreamMixin<T>  {
  // 📝 ESTÀTICS -----------------------
  static const String className = "LdState";
  
  // 🧩 MEMBRES ------------------------
  bool _isVirgin = true;
  bool _isCtrlSet = false;
  late LdCtrl _ctrl;

  // 🛠️ CONSTRUCTOR/DISPOSE -----------
  LdState({ required String pTag, bool pCreateStream = true }) {
    LdBinding.single.add(pTag, this);
    initStream();
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
  Future<T?> dataProcess(String? pTag);

  /// Executa la càrrega completa de dades
  /// Segueix el flux: Preparant -> Carregant -> Carregat/Error
  Future<T?> loadData({ String? pTag }) async { // , required Future<T> Function() pDataCBack }) async {
    T? result;

    emitPreparing(pTag: pTag?? tag, pIsVirgin: _isVirgin);
    
    // Donem un petit temps perquè la UI mostri l'estat "preparant" abans de canviar a "carregant"
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      (_isVirgin)
        ? emitLoading(pTag: pTag?? tag)
        : emitReloading(pTag: pTag?? tag);
      
      try {
        // result = await pDataCBack();
        result = await dataProcess(pTag);
        _isVirgin = false;
        emitLoaded(pTag: pTag?? tag, data: result);

      } on Exception catch (exc) {
        String msg = "${runtimeType.toString()}.loadData(): ${exc.toString()}";
        emitError(
          pTag: pTag?? tag,
          error: msg, 
          exception: Exception(msg)
        );
      } on Error catch (err) {
        String msg = "${runtimeType.toString()}.loadData(): ${err.toString()}";
        emitError(
          pTag: pTag?? tag,
          error: msg, 
          exception: Exception(msg)
        );
      }
    });

    return result;
  }
  
  /// Executa una funció i captura errors
  /// Útil per operacions que no afecten l'estat principal però poden fallar
  Future<R?> safeExecute<R>({ String? pTag, required Future<R> Function() pCBack }) async {
    try {
      return await pCBack();
    } on Exception catch (exc) {
      String msg = "${runtimeType.toString()}.safeExecute(pTag: ${pTag?? tag}, EXC): ${exc.toString()}";
      emitError(
        pTag: pTag?? tag,
        error: msg, 
        exception: Exception(msg)
      );
    } on Error catch (err) {
      String msg = "${runtimeType.toString()}.safeExecute(pTag: ${pTag?? tag}, ERR): ${err.toString()}";
      emitError(
        pTag: pTag?? tag,
        error: msg, 
        exception: Exception(msg)
      );
    }
    return null;
  }
}
