// ld_event_listener_mixin.dart
// 
// Mixin per a la generalització en la recepció d’events a partir de 
// l’stream de l’aplicació.
// CreatedAt: 2025/03/31 dl. CLA[JIQ]

import 'dart:async';

import 'package:ld_wbench4/03_core/ld_event_bus.dart';
import 'package:ld_wbench4/03_core/events/ld_event.dart';

mixin LdEventListenerMixin {
  // 🧩 MEMBRES ------------------------
  StreamSubscription? _eventSubscription;

  // 🌥️ FUNCIONALITAT------------------
  /// Escoltar tots els events
  void listenToAllEvents(void Function(LdEvent) pOnEvent) {
    _eventSubscription?.cancel();
    _eventSubscription = LdEventBus.single.stream.listen(pOnEvent);
  }

  /// Escoltar només events d'un tipus específic
  void listenToEventType<T extends LdEvent>(void Function(T) pOnEvent) {
    _eventSubscription?.cancel();
    _eventSubscription = LdEventBus.single.stream
        .where((event) => event is T)
        .cast<T>()
        .listen(pOnEvent);
  }

  /// Escoltar només events d'un emissor específic
  void listenToEventsFrom(String pSrcTag, void Function(LdEvent) ppOnEvent) {
    _eventSubscription?.cancel();
    _eventSubscription = LdEventBus.single.stream
        .where((event) => event.srcTag == pSrcTag)
        .listen(ppOnEvent);
  }

  /// Cancelar la subscripció
  void cancelSubscription() {
    _eventSubscription?.cancel();
    _eventSubscription = null;
  }
}