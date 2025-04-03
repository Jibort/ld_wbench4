// ld_event_theme_changed.dart
//
// Event que es produeix quan es requereix d'un canvi de tema.
// CreatedAt: 2025/04/01 dt. JIQ

import 'package:flutter/material.dart';
import 'package:ld_wbench4/03_core/events/ld_event.dart';

class   LdEventTheme
extends LdEvent {
  // 🧩 MEMBRES ------------------------
  final ThemeData _theme;
  
  // 🛠️ CONSTRUCTOR/DISPOSE -----------
  LdEventTheme({ 
    required super.pSrcTag, 
    super.pTgtTags, 
    required ThemeData pTheme })
  : _theme = pTheme,
    super(pType: LdEvent.evtThemeEvent);

  // 📥 GETTERS/SETTERS ----------------
  ThemeData get theme => _theme;
}


