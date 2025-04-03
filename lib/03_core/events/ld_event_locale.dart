// ld_event_locale_changed.dart
//
// Event que es produeix quan es requereix d'un canvi d'idioma.
// CreatedAt: 2025/04/01 dt. JIQ

import 'package:flutter/material.dart';
import 'package:ld_wbench4/03_core/events/ld_event.dart';

class   LdEventLocale 
extends LdEvent {
  // 🧩 MEMBRES ------------------------
  final Locale _locale;
  
  // 🛠️ CONSTRUCTOR/DISPOSE -----------
  LdEventLocale({ 
    required super.pSrcTag, 
    super.pTgtTags, 
    required Locale pLocale })
  : _locale = pLocale,
    super(pType: LdEvent.evtLocaleEvent);

  // 📥 GETTERS/SETTERS ----------------
  Locale get locale => _locale;
}


