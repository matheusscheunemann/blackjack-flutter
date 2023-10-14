class DeckCard {
  final String image;
  final int value;

  DeckCard({
    required this.image,
    required this.value,
  });

  factory DeckCard.fromJson(Map<String, dynamic> json) {
    return DeckCard(
      image: json['image'] ?? '',
      value: defineValue(json['value'] ?? ''),
    );
  }
}

int defineValue(String value) {
  switch (value) {
    case 'ACE':
      return 11;
    case 'KING':
      return 10;
    case 'QUEEN':
      return 10;
    case 'JACK':
      return 10;
    default:
      return int.parse(value);
  }
}
