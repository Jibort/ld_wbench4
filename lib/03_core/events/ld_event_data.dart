// ld_event_data_changed.dart
//
// Event que es produeix quan es requereix d'un canvi de dades.
// CreatedAt: 2025/04/01 dt. JIQ

import 'package:ld_wbench4/03_core/events/ld_event.dart';
import 'package:ld_wbench4/03_core/enums/state_event_enum.dart';
import 'package:ld_wbench4/07_models/ld_model.dart';

class   LdEventData<M extends LdModel>
extends LdEvent {
  // 🧩 MEMBRES ------------------------
  final M _data;
  final StateEvent _state;
  
  // 🛠️ CONSTRUCTOR/DISPOSE -----------
  LdEventData({ 
    super.pSubType,
    required super.pSrcTag, 
    super.pTgtTags, 
    super.pIsVirgin,
    StateEvent pState = StateEvent.loadedView,
    required M pData })
  : _data = pData,
    _state = pState,
    super(pType: LdEvent.evtDataEvent);

  // 📥 GETTERS/SETTERS ----------------
  M          get data        => _data;
  StateEvent get state       => _state;
  String     get getDataType => _data.baseTag;
}


