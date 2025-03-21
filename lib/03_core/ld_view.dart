// Abstracció d'una vista de l'aplicació.
// CreatedAt: 2025/03/18 dt. JIQ

import 'package:ld_wbench4/03_core/ld_tag_mixin.dart';
import 'package:ld_wbench4/03_core/ld_view_ctrl.dart';
import 'package:ld_wbench4/03_core/ld_view_state.dart';
import 'package:ld_wbench4/04_manager/injection/ld_binding.dart';

export 'package:ld_wbench4/03_core/ld_view_ctrl.dart';
export 'package:ld_wbench4/03_core/ld_view_state.dart';

abstract class LdView
with LdTagMixin {
  // 📝 ESTÀTICS -----------------------
  static const String className = "LdView";

  // 🧩 MEMBRES ------------------------
  final LdViewState _state;
  final LdViewCtrl  _ctrl;
  
  // 📥 GETTERS/SETTERS ----------------
  LdViewState get state => _state;
  LdViewCtrl  get ctrl  => _ctrl;

  // 🛠️ CONSTRUCTOR/DISPOSE -----------
  LdView({ required String pTag, required LdViewState pState, required LdViewCtrl pCtrl })
  : _state = pState, _ctrl = pCtrl {
    LdBinding.single.add(tag, this);
  }

  void dispose() {
    LdBinding.single.remove(tag);
    _state.dispose();
    _ctrl.dispose();
  }
}