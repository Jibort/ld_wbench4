// Diccionari de traduccions.
// CreatedAt: 2025/02/17 dl. JIQ

import 'dart:ui';

import 'package:ld_wbench4/03_core/ld_event_emitter_mixin.dart';
import 'package:ld_wbench4/08_streams/ld_stream_mixin.dart';

import 'ca.dart';
import 'en.dart';
import 'es.dart';
import 'fr.dart';
import 'pt.dart';

const Locale _defLocale = Locale('es');

class L 
with  LdEventEmitterMixin {
  // Singleton
  static final tr = L();
  
  // Dades
  static const Map<String, Map<String, String>> _keys = {
    'ca': caMap,
    'en': enMap,
    'es': esMap,
    'fr': frMap,
    'pt': ptMap,
  };
  
  static Locale _locale = _defLocale;
  static Map<String, String> _current = _keys[_defLocale.languageCode]!;
  
  // Getter per traduir
  static String tx(String pKey) => _current[pKey] ?? "!?";
  
  // Claus constants
  static const String sabinaApp = "sabinaApp";
  static const String sabinaWelcome = "sabinaWelcome";
  static const String loading = "loading";
  static const String reload = "reload";
  static const String of = "of";

  // Canviar l'idioma
  void changeLanguage({required String pSrcTag, required String? pLangCode}) {
    String old = _locale.languageCode;
    String newLang = pLangCode ?? 'es';
    
    if (old != newLang) {
      _locale = Locale(newLang);
      _current = _keys[newLang] ?? _keys['es']!;
      
      // Emetre event de canvi d'idioma
      emitEvent(LdLocaleChangedEvent(
        locale: _locale,
        sourceTag: pSrcTag
      ));
    }
  }
}

// Extensió per a strings
extension TxString on String {
  String get tx => L.tx(this);
}