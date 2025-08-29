class TextEntity {
  final String text;
  final String? color;
  final String? url;
  final String? fontStyle;
  final num? fontSize;

  TextEntity({
    required this.text,
    this.color,
    this.url,
    required this.fontStyle,
    this.fontSize,
  });

  factory TextEntity.fromJson(Map<String, dynamic> json) => TextEntity(
    text: json['text'] ?? '',
    color: json['color'],
    url: json['url'],
    fontStyle: json['font_style'],
    fontSize: json['font_size'],
  );

  Map<String, dynamic> toJson() => {
    'text': text,
    'color': color,
    'url': url,
    'font_style': fontStyle,
    'font_size': fontSize,
  };
}