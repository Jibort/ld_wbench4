// Eines de manipulació de DateTime's.
// CreatedAt: 2025/03/18 dt. JIQ

abstract class ToolsDT {
  static String? format(DateTime? pDateTime) {
    return pDateTime?.toIso8601String();
  }

  static DateTime parse(String? pFormatted) {
    DateTime? dt;

    dt = (pFormatted != null && pFormatted.isNotEmpty)
      ? DateTime.tryParse(pFormatted)
      : DateTime.now();

    if (dt == null) throw("ToolsDT.parse('$pFormatted'): Format de DateTime incorrecta!");
    return dt;
  }  
}
