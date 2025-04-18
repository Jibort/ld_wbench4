// Classe abstracta base per a la comunicació d'entitats de dades a través de LdStream.
// CreatedAt: 2025/03/18 dt. JIQ

import 'package:ld_wbench4/05_tools/ld_map.dart';
import 'package:ld_wbench4/08_streams/ld_stream_envelope.dart';


// 🧩 Tipus de serialització i nom de camps.
const String mfState     = "mfState";
const String mfError     = "mfError";
const String mfException = "mfException";
const String mfData      = "mfData";

// Estats on es pot trobar l'entitat.
enum LdEntityState {
  preparing,     // Determina que l'entitat està sent preparada per a començar la càrrega.
  loading,       // Determina que l'entitat està en estat de càrrega.
  loaded,        // Determina que l'entitat ha estat carregada.
  error,         // Determina que l'entitat no s'ha carregat degut a algun error.
  reloading,     // Determina que l'entitat està en estat de tornar a carregar-se.
  updatingLang,  // Determina que s'està produïnt un canvi de llengua. 
  updatingTheme; // Determina que s'està produïnt un canvi el mode del tema.

  // Converteix l'enum a String per serialitzar
  String toValue() => name;
  
  // Mètode estàtic per convertir des d'un valor dinàmic a l'enum corresponent
  static LdEntityState parseState(dynamic value) {
    if (value != null) {
      // Si és un índex numèric
      if (value is int && value >= 0 && value < LdEntityState.values.length) {
        return LdEntityState.values[value];
      }
      
      // Si és una cadena
      if (value is String) {
        // Primer provem si és només el nom de l'element
        try {
          return LdEntityState.values.firstWhere(
            (e) => e.name == value || e.toString() == value,
            orElse: () => LdEntityState.preparing,
          );
        } catch (_) { } // Obviem els possibles errors
      }
    }
    
    // Valor per defecte
    return LdEntityState.preparing;
  }
}

abstract class LdStateStreamEntity 
extends LdStreamEnvelope {
  // 🧩 MEMBRES ------------------------
  late LdEntityState _state;

  // 📥 GETTERS/SETTERS ----------------
  LdEntityState get state        => _state;
  set state(LdEntityState value) => _state = value;

  // 🛠️ CONSTRUCTORS ------------------
  LdStateStreamEntity({
    super.pTimeStamp,
    required super.pSrcTag,
    List<String>? pTgtTags,
    required LdEntityState pState,
  }): _state = pState;

  LdStateStreamEntity.fromMap({ required LdMap pMap })
  : super.fromMap(pMap: pMap) {
    _state = pMap[mfState];
  }

  // 🌥️ FUNCIONS ABSTRACTES -----------
  @override
  LdMap toMap() {
    LdMap map = super.toMap();
    map[mfState] = _state;
    return map;
  }
}