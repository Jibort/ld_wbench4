// ld_event_listener_mixin.dart
// 
// Mixin per a la generalització en la recepció d’events a partir de 
// l’stream de l’aplicació.
// CreatedAt: 2025/03/31 dl. CLA[JIQ]

import 'dart:async';

import 'package:ld_wbench4/03_core/Ld_event_bus.dart';
import 'package:ld_wbench4/03_core/ld_event.dart';

mixin LdEventListenerMixin {
  StreamSubscription? _eventSubscription;

  // Escoltar tots els events
  void listenToAllEvents(void Function(LdEvent) onEvent) {
    _eventSubscription?.cancel();
    _eventSubscription = LdEventBus.single.stream.listen(onEvent);
  }

  // Escoltar només events d'un tipus específic
  void listenToEventType<T extends LdEvent>(void Function(T) onEvent) {
    _eventSubscription?.cancel();
    _eventSubscription = LdEventBus.single.stream
        .where((event) => event is T)
        .cast<T>()
        .listen(onEvent);
  }


  // Escoltar només events d'un emissor específic
  void listenToEventsFrom(String sourceTag, void Function(LdEvent) onEvent) {
    _eventSubscription?.cancel();
    _eventSubscription = LdEventBus.single.stream
        .where((event) => event.sourceTag == sourceTag)
        .listen(onEvent);
  }

  // Cancelar la subscripció
  void cancelSubscription() {
    _eventSubscription?.cancel();
    _eventSubscription = null;
  }
}