import 'dart:convert';

class SavedCard {
  final int cardId;
  final bool isDismiss;
  final bool isRemind;
  final bool isShowed;
  final Map<String, dynamic> payload;

  SavedCard({
    required this.cardId,
    this.isDismiss = false,
    this.isRemind = false,
    this.isShowed = false,
    Map<String, dynamic>? payload,
  }) : payload = payload ?? <String, dynamic>{};

  Map<String, dynamic> toMap() {
    return {
      'card_id': cardId,
      'is_dismiss': isDismiss ? 1 : 0,
      'is_remind': isRemind ? 1 : 0,
      'is_showed': isShowed ? 1 : 0,
      'payload': jsonEncode(payload),
    };
  }

  factory SavedCard.fromMap(Map<String, dynamic> m) {
    return SavedCard(
      cardId: m['card_id'] as int,
      isDismiss: (m['is_dismiss'] as int) == 1,
      isRemind: (m['is_remind'] as int) == 1,
      isShowed: (m['is_showed'] as int) == 1,
      payload: m['payload'] != null && (m['payload'] as String).isNotEmpty
          ? jsonDecode(m['payload'] as String) as Map<String, dynamic>
          : <String, dynamic>{},
    );
  }
}