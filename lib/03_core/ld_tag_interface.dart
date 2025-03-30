// ld_tag_interface.dart
// 
// Interfície en forma de classe abstracta per a establir un nom clar a cada
// classe que apliqui amb 'LdTagMixin'.
// CreatedAt: 2025/03/26 dc. JIQ

abstract class LdTagIntf {
  /// Retorna el nom base de la classe per a utilitzar com a prefix de tag quan 
  /// aquest no s'especifica a partir dels constructors.
  String get baseTag;
}