// ld_event.dart
//
// Base abstracta per a tots els events de l'aplicació.
// CreatedAt: 2025/03/31 dl. CLA[JIQ]

export 'ld_event_data.dart';
export 'ld_event_locale.dart';
export 'ld_event_map.dart';
export 'ld_event_state.dart';
export 'ld_event_stats.dart';
export 'ld_event_theme.dart';

abstract class LdEvent {
  // 📝 ESTÀTICS -----------------------
  static const evtErrorEvent  = "error_event";
  static const evtDataEvent   = "data_event";
  static const evtLocaleEvent = "locale_event";
  static const evtMapEvent    = "map_event";
  static const evtStateEvent  = "state_event";
  static const evtStatsEvent  = "stats_event";
  static const evtThemeEvent  = "theme_event";

  // 🧩 MEMBRES ------------------------
  final String       _type;
  final String?      _subType;
  final String       _srcTag;
  final List<String> _tgtTags;
  final bool         _isVirgin;

  // 🛠️ CONSTRUCTOR/DISPOSE -----------
  LdEvent({ 
    required String pType,
    String?         pSubType,
    bool?           pIsVirgin,
    required String pSrcTag, 
    List<String>?   pTgtTags })
  : _type     = pType,
    _subType  = pSubType,
    _isVirgin = pIsVirgin?? true,
    _srcTag   = pSrcTag,
    _tgtTags  = pTgtTags?? [];

  // 📥 GETTERS/SETTERS ----------------
  String        get type     => _type;
  String?       get subType  => _subType;
  bool          get isVirgin => _isVirgin;
  String        get srcTag   => _srcTag;
  List<String>? get tgtTags  => _tgtTags;
}
