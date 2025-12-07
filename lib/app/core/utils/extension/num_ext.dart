extension ToDoubleSafe on Object? {
  /// JSON'dan gelen int/double/string/null değerleri güvenle double'a çevirir.
  double toDoubleSafe() {
    final v = this;
    if (v == null) return 0.0;
    if (v is double) return v;
    if (v is int) return v.toDouble();
    if (v is num) return v.toDouble();
    if (v is String) return double.tryParse(v) ?? 0.0;
    return 0.0;
  }
}