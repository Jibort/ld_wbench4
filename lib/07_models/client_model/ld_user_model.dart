// Model d'usuari de proves per a la configuració dels streams.
// CreatedAt: 2025/03/22 ds. JIQ

import 'package:ld_wbench4/05_tools/ld_map.dart';
import 'package:ld_wbench4/07_models/ld_model.dart';

// Model de dades per representar un usuari
class UserModel
extends LdModel {
  // 📝 ESTÀTICS -----------------------
  static const String mfId       = "mfUserId";
  static const String mfName     = "mfUserName";
  static const String mfEmail    = "mfUserEmail";
  static const String mfImageUrl = "mfUserImageUrl";
  static const String mfUsers    = "mfUsers";
  static const String mfList     = "mfList";
  
  // 🧩 MEMBRES ------------------------
  final String name;
  final String email;
  final String imageUrl;

  // 🛠️ CONSTRUCTORS ------------------
  UserModel({
    super.pId,
    required this.name,
    required this.email,
    required this.imageUrl,
  });

  factory UserModel.fromMap(LdMap pMap) 
    => UserModel(
      pId: pMap[mfId],
      name: pMap[UserModel.mfName],
      email: pMap[mfEmail],
      imageUrl: pMap[mfImageUrl],
    );
    
  @override
  void dispose() {
    // No és necessari alliberar cap estructura.
  }
        
  // 📥 GETTERS/SETTERS ----------------
  
  // 🌥️ FUNCIONS ABSTRACTES -----------
  @override
  LdMap toMap() {
    LdMap map = super.toMap();

    map.addAll({
      mfName:     name,
      mfEmail:    email,
      mfImageUrl: imageUrl,
    });
    return map;
  }
  
  // 🌥️ 'LdTagIntf' -------------------
  @override
  String get baseTag => "UserModel";
}

// Model de dades per la resposta de la API
class UsersResponse 
extends LdModel {
  final List<UserModel> users;

  UsersResponse({ required this.users })
  : super();
  
  @override // Arrel
  void dispose() {
    users.clear();
  }
  
  @override
  LdMap toMap() {
    LdMap map = super.toMap();
    map.addAll({
      UserModel.mfUsers: users,
    });
    return map;
  }

  // 🌥️ 'LdTagIntf' -------------------
  @override
  String get baseTag => "UserResponse";
}

