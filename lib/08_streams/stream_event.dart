// stream_events.dart
//
//
// CreatedAt: 2025/03/26 dc. JIQ


// Estats on es pot trobar l'entitat.
enum StreamEvent {
  // SECCIÓ "ESTATS DE LES VISTES" ----
  preparingView,     // Determina que l'entitat està sent preparada per a començar la càrrega.
  loadingView,       // Determina que l'entitat està en estat de càrrega.
  loadedView,        // Determina que l'entitat ha estat carregada.
  errorView,         // Determina que l'entitat no s'ha carregat degut a algun error.
  reloadingView,     // Determina que l'entitat està en estat de tornar a carregar-se.

  // SECCIÓ "CANVIS EN EL THEME" ------
  updatingThemeMode; // Determina que s'està actualitzant el tema.

  // Converteix l'enum a String per serialitzar
  String toValue() => name;
  
  // Mètode estàtic per convertir des d'un valor dinàmic a l'enum corresponent
  static StreamEvent parseState(dynamic value) {
    if (value != null) {
      // Si és un índex numèric
      if (value is int && value >= 0 && value < StreamEvent.values.length) {
        return StreamEvent.values[value];
      }
      
      // Si és una cadena
      if (value is String) {
        // Primer provem si és només el nom de l'element
        try {
          return StreamEvent.values.firstWhere(
            (e) => e.name == value || e.toString() == value,
            orElse: () => StreamEvent.preparingView,
          );
        } catch (_) { } // Obviem els possibles errors
      }
    }
    
    // Valor per defecte
    return StreamEvent.preparingView;
  }
}

