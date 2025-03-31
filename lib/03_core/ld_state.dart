// ld_state.dart
// 
// Estat general d'un controlador.
// CreatedAt: 2025/03/31 dl. CLA[JIQ]

import 'package:ld_wbench4/03_core/ld_event_emitter_mixin.dart';
import 'package:ld_wbench4/03_core/ld_tag_interface.dart';
import 'package:ld_wbench4/03_core/ld_tag_mixin.dart';
import 'package:ld_wbench4/04_manager/injection/ld_binding.dart';
import 'package:ld_wbench4/07_models/ld_model.dart';

abstract   class LdState<T extends LdModel>
with       LdTagMixin, LdEventEmitterMixin
implements LdTagIntf {
  bool _isVirgin = true, _isCtrlSet = false;
  late LdCtrl _ctrl;
  bool _isLoading = false, _isError = false;
  String? _errorMessage;
  (int, int, double?) _stats = (0, 0, null);
  String? _loadingElement;

  LdState({String? pTag}) {
    LdBinding bind = LdBinding.single;
    tag = bind.newStateTag(pTag ?? baseTag);
    bind.add(tag, this);
  }

  void dispose() {
    LdBinding.single.remove(tag);
  }

  // Getters
  LdCtrl get ctrl => _ctrl;
  bool get isLoading => _isLoading;
  bool get isError => _isError;
  String? get errorMessage => _errorMessage;
  (int, int, double?) get stats => _stats;
  String? get loadingElement => _loadingElement;
  String? get title => null;
  String? get subtitle => null;

  // Setter per al controlador
  set ctrl(LdCtrl pCtrl) {
    assert(!_isCtrlSet);
    _isCtrlSet = true;
    _ctrl = pCtrl;
  }

  // Mètodes per emetre diferents estats
  void emitPreparing({ required String pSrcTag, List<String>? pTgtTags,
                      required bool pIsVirgin }) {
    _isLoading = true;
    _isError = false;
    
    emitEvent(LdStateChangedEvent(
      state: LdPreparingStreamEntity(),
      sourceTag: tag
    ));
  }

  void emitLoading({required String pSrcTag, List<String>? pTgtTags, String? element}) {
    _isLoading = true;
    _isError = false;
    _loadingElement = element;
    
    emitEvent(LdStateChangedEvent(
      state: LdLoadingStreamEntity(),
      sourceTag: tag
    ));
  }

  void emitReloading({required String pSrcTag, List<String>? pTgtTags}) {
    _isLoading = true;
    _isError = false;
    
    emitEvent(LdStateChangedEvent(
      state: LdReloadingStreamEntity(),
      sourceTag: tag
    ));
  }

  void emitLoaded({required String pSrcTag, List<String>? pTgtTags, T? data}) {
    _isLoading = false;
    _isError = false;
    
    emitEvent(LdStateChangedEvent(
      state: LdLoadedStreamEntity<T>(data: data),
      sourceTag: tag
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
    
    emitEvent(LdStateChangedEvent(
      state: LdErrorStreamEntity(error: error, exception: exception),
      sourceTag: tag
    ));
  }

  void updateStats(int total, int current, [double? percentage]) {
    _stats = (total, current, percentage);
    
    // Opcional: emetre un event específic per a actualització d'estadístiques
    emitEvent(LdStatsUpdatedEvent(
      stats: _stats,
      sourceTag: tag
    ));
  }

  // Cicle de càrrega
  Future<T?> dataProcess({String? pSrcTag, List<String>? pTgtTags});

  Future<T?> loadData({String? pSrcTag, List<String>? pTgtTags}) async {
    T? result;

    emitPreparing(pSrcTag: pSrcTag ?? tag, pTgtTags: pTgtTags, pIsVirgin: _isVirgin);
    
    // Donem un petit temps perquè la UI mostri l'estat "preparant" abans de 
    // canviar a "carregant"
    await Future.delayed(Duration(milliseconds: 50));
    
    (_isVirgin)
      ? emitLoading(pSrcTag: pSrcTag ?? tag, pTgtTags: pTgtTags)
      : emitReloading(pSrcTag: pSrcTag ?? tag, pTgtTags: pTgtTags);
    
    try {
      result = await dataProcess(pSrcTag: pSrcTag, pTgtTags: pTgtTags);
      _isVirgin = false;
      emitLoaded(pSrcTag: pSrcTag ?? tag, pTgtTags: pTgtTags, data: result);
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
}