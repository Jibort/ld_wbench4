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
import 'package:ld_wbench4/07_models/stream_entity_states/ld_locale_stream_entity.dart';
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
  void emitData<T extends LdModel>({ required String pSrcTag, List<String>? pTgtTags, T? pData }) {
    if (_streamCtrl == null || _streamCtrl.isClosed) return;
    _streamCtrl.add(LdModelStreamEntity<T>(pSrcTag: pSrcTag, pTgtTags: pTgtTags, pData: pData) as E);
  }

  /// Emet que s'està preparant la càrrega de dades
  void emitPreparing({ required String pSrcTag, List<String>? pTgtTags, bool pIsVirgin = true}) {
    if (_streamCtrl == null || _streamCtrl.isClosed) return;
    _streamCtrl.add(LdPreparingViewStreamEvent(pSrcTag: pSrcTag, pTgtTags: pTgtTags, pIsVirgin: pIsVirgin) as E);
  }
  
  /// Emet que s'està carregant les dades
  void emitLoading({ required String pSrcTag, List<String>? pTgtTags }) {
    if (_streamCtrl == null || _streamCtrl.isClosed) return;
    _streamCtrl.add(LdLoadingStreamEntity(pSrcTag: pSrcTag, pTgtTags: pTgtTags) as E);
  }
  
  /// Emet que les dades s'han carregat correctament
  void emitLoaded<D>({ required String pSrcTag, List<String>? pTgtTags, required D data, bool pIsVirgin = true }) {
    if (_streamCtrl == null || _streamCtrl.isClosed) return;
    _streamCtrl.add(LdLoadedStreamEntity<D>(pSrcTag: pSrcTag, pTgtTags: pTgtTags, pData: data, pFirstTime: pIsVirgin) as E);
  }

  /// Emet que s'ha produït un error durant la càrrega
  void emitError({ required String pSrcTag, List<String>? pTgtTags, required String error, Exception? exception }) {
    Debug.error(error, exception);
    
    if (_streamCtrl == null || _streamCtrl.isClosed) return;
    _streamCtrl.add(LdErrorStreamEntity(
      pSrcTag: pSrcTag,
      pTgtTags: pTgtTags,
      pError: error,
      pException: exception
    ) as E);
  }
  
  /// Emet que s'està tornant a carregar les dades
  void emitReloading({ required String pSrcTag, List<String>? pTgtTags }) {
    if (_streamCtrl == null || _streamCtrl.isClosed) return;
    _streamCtrl.add(LdReLoadingStreamEntity(pSrcTag:  pSrcTag, pTgtTags: pTgtTags) as E);
  }
  
  /// Emet un canvi de tema
  void emitThemeUpdate({ required String pSrcTag, List<String>? pTgtTags, required ThemeData pTData }) {
    if (_streamCtrl == null || _streamCtrl.isClosed) return;
    _streamCtrl.add(LdThemeStreamEntity(
      pSrcTag:  pSrcTag,
      pTgtTags: pTgtTags, 
      pData:    pTData
    ) as E);
  }

  /// Emet un canvi de llengua
  void emitLocaleUpdate({ required String pSrcTag, List<String>? pTgtTags, required Locale pLocale }) {
    if (_streamCtrl == null || _streamCtrl.isClosed) return;
    _streamCtrl.add(LdLocaleStreamEntity(
      pSrcTag:  pSrcTag,
      pTgtTags: pTgtTags, 
      pLocale:    pLocale
    ) as E);
  }
}