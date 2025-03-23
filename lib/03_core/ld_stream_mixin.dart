// Mixim per a l'administració d'streams.
// CreatedAt: 2025/08/21 dv. JIQ

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ld_wbench4/05_tools/debug.dart';
import 'package:ld_wbench4/07_models/ld_model.dart';
import 'package:ld_wbench4/07_models/ld_model_stream_entity.dart';
import 'package:ld_wbench4/07_models/ld_stream_envelope.dart';

mixin LdStreamMixin<
  E extends LdStreamEnvelope
> {
  // 📝 ESTÀTICS -----------------------
  static const String className = "LdStreamMixin";
  
  // 🧩 MEMBRES ------------------------
  late final StreamController<E>? _streamCtrl;

  // 🛠️ LIFE CYCLE --------------------
  /// Inicialitza el controladors d'streams.
  void initStream() {
    _streamCtrl = StreamController<E>.broadcast();
  }

  /// Allibera els recursos associats al controlador d'streams.
  void disposeStream() {
    if (_streamCtrl != null && !_streamCtrl.isClosed) {
       _streamCtrl.close();
    }
  }

  /// Retorna l'stream associat al controlador.
  Stream<E>? get stream => _streamCtrl?.stream;

  /// Subscriu un oidor a l'stream associat al controlador.
  StreamSubscription<E>? subscribe(
    void Function(E) pLstn,
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,)
    => (stream != null)
      ? stream!.listen(
          pLstn,
          onError: onError,
          onDone: onDone, 
          cancelOnError: cancelOnError
        )
      : null;
  
  // 🌥️ ESTATS -----------------------
  /// Emet que una estructura de dades.
  void emitData<T extends LdModel>({ required String pTag, required T pData }) {
    if (_streamCtrl == null || _streamCtrl.isClosed) return;
    _streamCtrl.add(LdModelStreamEntity<T>(pTag: pTag, pData: pData) as E);
  }

  /// Emet que s'està preparant la càrrega de dades
  void emitPreparing({ required String pTag, bool pIsVirgin = true}) {
    if (_streamCtrl == null || _streamCtrl.isClosed) return;
    _streamCtrl.add(LdPreparingStreamEntity(pTag: pTag, pIsVirgin: pIsVirgin) as E);
  }
  
  /// Emet que s'està carregant les dades
  void emitLoading({ required String pTag }) {
    if (_streamCtrl == null || _streamCtrl.isClosed) return;
    _streamCtrl.add(LdLoadingStreamEntity(pTag: pTag) as E);
  }
  
  /// Emet que les dades s'han carregat correctament
  void emitLoaded<D>({ required String pTag, required D data, bool pIsVirgin = true }) {
    if (_streamCtrl == null || _streamCtrl.isClosed) return;
    _streamCtrl.add(LdLoadedStreamEntity<D>(pTag: pTag, pData: data, pFirstTime: pIsVirgin) as E);
  }

  /// Emet que s'ha produït un error durant la càrrega
  void emitError({ required String pTag, required String error, Exception? exception }) {
    Debug.error(error, exception);
    
    if (_streamCtrl == null || _streamCtrl.isClosed) return;
    _streamCtrl.add(LdErrorStreamEntity(
      pTag: pTag, 
      pError: error, 
      pException: exception
    ) as E);
  }
  
  /// Emet que s'està tornant a carregar les dades
  void emitReloading({ required String pTag }) {
    if (_streamCtrl == null || _streamCtrl.isClosed) return;
    _streamCtrl.add(LdReLoadingStreamEntity(pTag: pTag) as E);
  }
  
  /// Emet un canvi de tema
  void emitThemeUpdate({ required String pTag, required ThemeData pTData }) {
    if (_streamCtrl == null || _streamCtrl.isClosed) return;
    _streamCtrl.add(LdThemeStreamEntity(
      pTag: pTag, 
      pData: pTData
    ) as E);
  }

  // 🎭 HOOKS (JA NO SÓN NECESSARIS) ---
  // /// Invocada quan es vol transmetre una estructura de dades.
  // void onData({ String? pTag, required T pData });

  // /// Invocada quan s'està preparant la càrrega
  // void onPreparing({ String? pTag });
  
  // /// Invocada quan s'està carregant
  // void onLoading({ String? pTag });
  
  // /// Invocada quan les dades s'han carregat
  // void onLoaded({ String? pTag, T? pData });
  
  // /// Invocada quan s'ha produït un error
  // void onError({ String? pTag, required String pError, Exception? pExc });
  
  // /// Invocada quan s'està recarregant
  // void onReloading({ String? pTag });
  
  // /// Invocada quan es canvia el tema
  // void onThemeUpdate({ String? pTag, ThemeData pTData });
}