// ld_event_emitter_mixin.dart
// 
// Mixin per a la generalització en l’emissió d’events mitjançant l’stream.
// CreatedAt: 2025/03/31 dl. CLA[JIQ]

import 'package:ld_wbench4/03_core/Ld_event_bus.dart';
import 'package:ld_wbench4/03_core/ld_event.dart';

mixin LdEventEmitterMixin {
  // Emetre un event al bus central
  void emitEvent(LdEvent event) {
    LdEventBus.single.emit(event);
  }
}