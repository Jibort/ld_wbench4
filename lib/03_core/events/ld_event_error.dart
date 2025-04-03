// ld_event_error_changed.dart
//
// Event que s'emet quan es produeix un error.
// CreatedAt: 2025/04/01 dt. JIQ

import 'package:ld_wbench4/03_core/events/ld_event.dart';

class   LdEventError 
extends LdEvent {
  // 🧩 MEMBRES ------------------------
  final int _total, _current;
  final double? _percentage;
  
  // 🛠️ CONSTRUCTOR/DISPOSE -----------
  LdEventError({ 
    required super.pSrcTag, 
    super.pTgtTags, 
    required int pTotal, 
    required int pCurrent,
    double? pPercentage })
  : _total = pTotal,
    _current = pCurrent,
    _percentage = pPercentage,
    super(pType: LdEvent.evtErrorEvent);

  // 📥 GETTERS/SETTERS ----------------
  (int, int, double?) get stats => (_total, _current, _percentage);
}


