// Mixin per a la creació dels identificadors universals dels objectes.
// CreatedAt: 2025/02/12 dc. JIQ

mixin LdTagMixin {
  // 📝 STATICS ------------------------
  
  // 🧩 MEMBRES ------------------------
  bool _isTagSetted = false;
  late final String _tag;

  // 📥 GETTERS/SETTERS ----------------
  String get tag => _tag;
  set tag(String pTag) {
    assert(!_isTagSetted && pTag.isNotEmpty);
    _isTagSetted = true;
    _tag         = pTag;
  }
} // mixin LdIdMixin
