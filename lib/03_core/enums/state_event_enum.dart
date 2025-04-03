// state_events_enum.dart
//
// Tipus d'estat event que pot contenir un Stream.
// CreatedAt: 2025/04/01 dt. JIQ


/// Estats on es pot trobar l'entitat.
enum StateEvent {
  // SECCIÓ "ESTATS DE LES VISTES" ----
  preparingView,     // Determina que l'entitat està sent preparada per a començar la càrrega.
  loadingView,       // Determina que l'entitat està en estat de càrrega.
  loadedView,        // Determina que l'entitat ha estat carregada.
  errorView,         // Determina que l'entitat no s'ha carregat degut a algun error.
  reloadingView;     // Determina que l'entitat està en estat de tornar a carregar-se.

  // Converteix l'enum a String per serialitzar
  String toValue() => name;
  
  // Mètode estàtic per convertir des d'un valor dinàmic a l'enum corresponent
  static StateEvent parseState(dynamic value) {
    if (value != null) {
      // Si és un índex numèric
      if (value is int && value >= 0 && value < StateEvent.values.length) {
        return StateEvent.values[value];
      }
      
      // Si és una cadena
      if (value is String) {
        // Primer provem si és només el nom de l'element
        try {
          return StateEvent.values.firstWhere(
            (e) => e.name == value || e.toString() == value,
            orElse: () => StateEvent.preparingView,
          );
        } catch (_) { } // Obviem els possibles errors
      }
    }
    
    // Valor per defecte
    return StateEvent.preparingView;
  }
}

