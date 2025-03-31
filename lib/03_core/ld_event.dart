// ld_event.dart
//
// Base abstracta per a tots els events de l'aplicació.
// CreatedAt: 2025/03/31 dl. CLA[JIQ]

import 'package:flutter/material.dart';

abstract class LdEvent {
  final String type;
  final String sourceTag;
  
  LdEvent(this.type, this.sourceTag);
}

// Events específics (exemples)
class LdThemeChangedEvent extends LdEvent {
  final ThemeData theme;
  
  LdThemeChangedEvent({required this.theme, required String sourceTag}) 
      : super('theme_changed', sourceTag);
}

class LdLocaleChangedEvent extends LdEvent {
  final Locale locale;
  
  LdLocaleChangedEvent({required this.locale, required String sourceTag}) 
      : super('locale_changed', sourceTag);
}

class LdStateChangedEvent extends LdEvent {
  final LdStateStreamEntity state;
  
  LdStateChangedEvent({required this.state, required String sourceTag}) 
      : super('state_changed', sourceTag);
}