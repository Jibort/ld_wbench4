// ld_stream_mixin.dart
// 
// Mixin per a l'administració d'streams.
//
//    Existeixen diferents tipus d'streams:
//    1. Notificació dels canvis als estats de l'aplicació i de les vistes.
//    2. Notificació dels canvis a l'estat dels processos de càrrega asíncrones.
//    3. Notificació de l'alternança entre tema clar i tema fosc.
// CreatedAt: 2025/08/21 dv. JIQ

import 'dart:async';
import 'package:flutter/material.dart';

import 'package:ld_wbench4/05_tools/debug.dart';
import 'package:ld_wbench4/07_models/ld_model.dart';
import 'package:ld_wbench4/07_models/ld_model_stream_entity.dart';
import 'package:ld_wbench4/07_models/stream_entity_states/ld_error_stream_entity.dart';
import 'package:ld_wbench4/07_models/stream_entity_states/ld_loaded_stream_entity.dart';
import 'package:ld_wbench4/07_models/stream_entity_states/ld_loading_stream_entity.dart';
import 'package:ld_wbench4/07_models/stream_entity_states/ld_reloading_stream_entity.dart';
import 'package:ld_wbench4/07_models/stream_entity_states/ld_theme_stream_entity.dart';
import 'package:ld_wbench4/08_streams/ld_stream_envelope.dart';
import 'package:ld_wbench4/08_streams/events/views/ld_preparing_view_stream_event.dart';

mixin LdStreamMixin<E extends LdStreamEnvelope> {
  // 📝 ESTÀTICS -----------------------
  
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
  StreamSubscription<E>? subscribe({
    required void Function(E) pLstn,
    Function? pOnError,
    void Function()? pOnDone,
    bool? cancelOnError })
    => (stream != null)
      ? stream!.listen(
          pLstn,
          onError: pOnError,
          onDone: pOnDone, 
          cancelOnError: cancelOnError
        )
      : null;
  
  /// Desubscriu un oidor de l'stream associat al controlador.
  void unsubscribe(StreamSubscription<E>? pLstn) {
    if (pLstn != null) {
      pLstn.cancel();
    }
  }

  // 🌥️ ESTATS -----------------------
  /// Emet que una estructura de dades.
  void emitData<T extends LdModel>({ required String pSrcTag, String? pTgtTag, T? pData }) {
    if (_streamCtrl == null || _streamCtrl.isClosed) return;
    _streamCtrl.add(LdModelStreamEntity<T>(pSrcTag: pSrcTag, pTgtTag: pTgtTag, pData: pData) as E);
  }

  /// Emet que s'està preparant la càrrega de dades
  void emitPreparing({ required String pSrcTag, String? pTgtTag, bool pIsVirgin = true}) {
    if (_streamCtrl == null || _streamCtrl.isClosed) return;
    _streamCtrl.add(LdPreparingViewStreamEvent(pSrcTag: pSrcTag, pTgtTag: pTgtTag, pIsVirgin: pIsVirgin) as E);
  }
  
  /// Emet que s'està carregant les dades
  void emitLoading({ required String pSrcTag, String? pTgtTag }) {
    if (_streamCtrl == null || _streamCtrl.isClosed) return;
    _streamCtrl.add(LdLoadingStreamEntity(pSrcTag: pSrcTag, pTgtTag: pTgtTag) as E);
  }
  
  /// Emet que les dades s'han carregat correctament
  void emitLoaded<D>({ required String pSrcTag, String? pTgtTag, required D data, bool pIsVirgin = true }) {
    if (_streamCtrl == null || _streamCtrl.isClosed) return;
    _streamCtrl.add(LdLoadedStreamEntity<D>(pSrcTag: pSrcTag, pTgtTag: pTgtTag, pData: data, pFirstTime: pIsVirgin) as E);
  }

  /// Emet que s'ha produït un error durant la càrrega
  void emitError({ required String pSrcTag, String? pTgtTag, required String error, Exception? exception }) {
    Debug.error(error, exception);
    
    if (_streamCtrl == null || _streamCtrl.isClosed) return;
    _streamCtrl.add(LdErrorStreamEntity(
      pSrcTag: pSrcTag,
      pTgtTag: pTgtTag,
      pError: error,
      pException: exception
    ) as E);
  }
  
  /// Emet que s'està tornant a carregar les dades
  void emitReloading({ required String pSrcTag, String? pTgtTag }) {
    if (_streamCtrl == null || _streamCtrl.isClosed) return;
    _streamCtrl.add(LdReLoadingStreamEntity(pSrcTag:  pSrcTag, pTgtTag: pTgtTag) as E);
  }
  
  /// Emet un canvi de tema
  void emitThemeUpdate({ required String pSrcTag, String? pTgtTag, required ThemeData pTData }) {
    if (_streamCtrl == null || _streamCtrl.isClosed) return;
    _streamCtrl.add(LdThemeStreamEntity(
      pSrcTag: pSrcTag,
      pTgtTag: pTgtTag, 
      pData:   pTData
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