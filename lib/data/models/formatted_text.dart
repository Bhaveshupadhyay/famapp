import 'package:fampay/data/models/text_entity.dart';

class FormattedText {
  final String text;
  final List<TextEntity> entities;

  FormattedText({
    required this.text,
    required this.entities,
  });

  factory FormattedText.fromJson(Map<String, dynamic> json) => FormattedText(
    text: json['text'],
    entities: List<TextEntity>.from(
        json['entities'].map((x) => TextEntity.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    'text': text,
    'entities': entities.map((x) => x.toJson()).toList(),
  };
}