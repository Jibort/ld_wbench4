// Model d'usuari de proves per a la configuració dels streams.
// CreatedAt: 2025/03/22 ds. JIQ

// // Implementació actualitzada de LdTest01State.dart
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:ld_wbench4/01_views/test_01/ld_test_01_ctrl.dart';
// import 'package:ld_wbench4/03_core/ld_view_state.dart';
// import 'package:ld_wbench4/07_models/ld_model.dart';
// import 'package:ld_wbench4/07_models/ld_stream_envelope.dart';

// // Model de dades per representar un usuari
// class UserModel
// extends LdModel {
  

//   // 🧩 MEMBRES ------------------------
//   final String name;
//   final String email;
//   final String imageUrl;

//   // 🛠️ CONSTRUCTORS ------------------
//   UserModel({
//     required super.id,
//     required this.name,
//     required this.email,
//     required this.imageUrl,
//   });

//   factory UserModel.fromMap(Map<String, dynamic> pMap) {
//     return UserModel(
//       id: pMap[mfId],
//       name: pMap[mfName],
//       email: pMap[mfEmail],
//       imageUrl: pMap[mfImageUrl],
//     );
//   }

//   @override
//   void dispose() { }
  
//   // 🌥️ 'LdModel' ---------------------
//   Map<String, dynamic> toMap() => {
//     'id': id,
//     'name': name,
//     'email': email,
//     'imageUrl': imageUrl,
//   };

//   // 🌥️ FUNCIONS ABSTRACTES -----------

// }

// // Model de dades per la resposta de la API
// class UsersResponse {
//   final List<UserModel> users;

//   UsersResponse({required this.users});
// }
