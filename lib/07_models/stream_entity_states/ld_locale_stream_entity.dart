// Entitat tipus 'themeUpdate' per a informar a través d'Streams.
// CreatedAt: 2025/03/18 dt. JIQ

// ignore_for_file: use_super_parameters

import 'package:flutter/painting.dart';
import 'package:ld_wbench4/05_tools/ld_map.dart';
import 'package:ld_wbench4/07_models/models.dart';

class LdLocaleStreamEntity
extends LdStateStreamEntity {
  // 📝 ESTÀTICS -----------------------
  static const String mfLocale = "mfLocale";

  // 🧩 MEMBRES ------------------------
  final Locale _locale;
  
  // 📥 GETTERS/SETTERS ----------------
  Locale get locale => _locale;
  String get language => _locale.languageCode;

  // 🛠️ CONSTRUCTORS ------------------
  LdLocaleStreamEntity({
    super.pTimeStamp,
    required super.pSrcTag, 
    super.pTgtTags,
    required Locale pLocale, })
  : _locale = pLocale,
    super(pState: LdEntityState.updatingLang);
  
    LdLocaleStreamEntity.fromMap(LdMap pMap)
    : _locale = pMap[mfLocale],
      super.fromMap(pMap: pMap);

    // 🌥️ 'LdStreamEntity' --------------
  @override
  LdMap toMap() {
    LdMap map = super.toMap();
    map[mfLocale] = _locale;
    return map;
  }
}