// ld_event_bus.dart
//
// El nucli de l'arquitectura és un bus d'events centralitzat que proporciona
// un únic punt d'accés per a la comunicació entre components.
// CreatedAt: 2025/03/31 dl. CLA[JIQ]

import 'dart:async';

import 'package:ld_wbench4/03_core/ld_event.dart';

class LdEventBus {
  // Singleton
  static final LdEventBus _single = LdEventBus._internal();
  factory LdEventBus() => _single;
  LdEventBus._internal();

  static LdEventBus get single => _single;

  // Un únic StreamController per a tota l'aplicació
  final StreamController<LdEvent> _eventController = 
      StreamController<LdEvent>.broadcast();

  // Stream públic
  Stream<LdEvent> get stream => _eventController.stream;

  // Mètode per emetre events
  void emit(LdEvent event) {
    if (!_eventController.isClosed) {
      _eventController.add(event);
    }
  }

  // Tancar el stream quan ja no es necessiti (normalment al finalitzar l'aplicació)
  void dispose() {
    _eventController.close();
  }
}