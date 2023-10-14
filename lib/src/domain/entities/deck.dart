class Deck {
  final String id;
  final bool success;

  Deck({
    required this.id,
    required this.success,
  });

  static Deck fromJson(Map<String, dynamic> json) {
    return Deck(
      id: json['deck_id'] ?? '',
      success: json['success'] ?? false,
    );
  }
}
