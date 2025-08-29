import 'card.dart';

class CardGroup {
  final String name;
  final String designType;
  final List<ContextualCard> cards;
  final bool isScrollable;
  final num? height;

  CardGroup({
    required this.name,
    required this.designType,
    required this.cards,
    required this.isScrollable,
    this.height,
  });

  factory CardGroup.fromJson(Map<String, dynamic> json) => CardGroup(
    name: json['name'],
    designType: json['design_type'],
    cards: List<ContextualCard>.from(json['cards'].map((x) => ContextualCard.fromJson(x))),
    isScrollable: json['is_scrollable'],
    height: json['height'],
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'design_type': designType,
    'cards': cards.map((x) => x.toJson()).toList(),
    'is_scrollable': isScrollable,
    'height': height,
  };
}
