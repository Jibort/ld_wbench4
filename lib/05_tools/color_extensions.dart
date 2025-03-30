// Eines d'extensió per a la gestió de colors.
// CreatedAt: 2025/03/23 dg. CLA[JIQ]

import 'package:flutter/material.dart';

/// Extensions per facilitar la manipulació de colors
extension ColorExtensions on Color {
  /// Aplica un percentatge d'opacitat al color
  /// [percentage] ha de ser un valor entre 0.0 i 1.0
  Color withPercentOpacity(double percentage) {
    assert(percentage >= 0.0 && percentage <= 1.0, 
      'El percentatge ha de ser entre 0.0 i 1.0');
    return withAlpha((percentage * 255.0).round());
  }
  
  /// Retorna una versió més clara del color
  Color lighter(double amount) {
    assert(amount >= 0.0 && amount <= 1.0);
    return Color.lerp(this, Colors.white, amount)!;
  }
  
  /// Retorna una versió més fosca del color
  Color darker(double amount) {
    assert(amount >= 0.0 && amount <= 1.0);
    return Color.lerp(this, Colors.black, amount)!;
  }
}