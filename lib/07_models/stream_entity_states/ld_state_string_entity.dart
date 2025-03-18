// Classe abstracta base per a la comunicació d'entitats de dades a través de LdStream.
// CreatedAt: 2025/03/18 dt. JIQ

// ignore_for_file: unnecessary_getters_setters

import 'package:ld_wbench4/07_models/ld_stream_entity.dart';


// 🧩 Tipus de serialització i nom de camps.
const String mapState = "mapState";
const String mapError = "mapError";
const String mapException = "mapException";
const String mapData = "mapData";

// Estats on es pot trobar l'entitat.
enum LdEntityState {
  preparing,    // Determina que l'entitat està sent preparada per a començar la càrrega.
  loading,      // Determina que l'entitat està en estat de càrrega.
  loaded,       // Determina que l'entitat ha estat carregada.
  error,        // Determina que l'entitat no s'ha carregat degut a algun error.
  reloading;    // Determina que l'entitat està en estat de tornar a carregar-se.

  // Converteix l'enum a String per serialitzar
  String toValue() => name;
  
  // Mètode estàtic per convertir des d'un valor dinàmic a l'enum corresponent
  static LdEntityState parseState(dynamic value) {
    if (value == null) {
      return LdEntityState.preparing;
    }
    
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
    
    // Valor per defecte
    return LdEntityState.preparing;
  }
}

abstract class LdStateStreamEntity 
extends LdStreamEntity {
  // 🧩 MEMBRES ------------------------
  late LdEntityState _state;


  // 📥 GETTERS/SETTERS ----------------
  LdEntityState get state => _state;
  set state(LdEntityState value) => _state = value;

  // 🛠️ CONSTRUCTORS ------------------
  LdStateStreamEntity({
    super.pTimeStamp,
    required super.pTag,
    required LdEntityState pState,
  }): _state = pState;

  LdStateStreamEntity.fromMap(EntityMap pMap)
  : super.fromMap(pMap) {
    _state = pMap[mapState];
  }

  // 🌥️ FUNCIONS ABSTRACTES -----------
  @override
  EntityMap toMap() {
    EntityMap map = super.toMap();
    map[mapState] = _state;
    return map;
  }
}