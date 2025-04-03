// ld_event_locale_changed.dart
//
// Event que es produeix quan es requereix d'un canvi d'idioma.
// CreatedAt: 2025/04/01 dt. JIQ

import 'package:ld_wbench4/03_core/events/ld_event.dart';

class   LdEventStats 
extends LdEvent {
  // 🧩 MEMBRES ------------------------
  final int _total, _current;
  final double? _percentage;
  
  // 🛠️ CONSTRUCTOR/DISPOSE -----------
  LdEventStats({ 
    required super.pSrcTag, 
    super.pTgtTags, 
    required int pTotal, 
    required int pCurrent,
    double? pPercentage })
  : _total = pTotal,
    _current = pCurrent,
    _percentage = pPercentage,
    super(pType: LdEvent.evtStatsEvent);

  // 📥 GETTERS/SETTERS ----------------
  (int, int, double?) get stats => (_total, _current, _percentage);
}


