class Cta {
  final String text;
  final String? bgColor;
  final String? textColor;
  final String? url;

  Cta({
    required this.text,
    this.bgColor,
    this.textColor,
    this.url,
  });

  factory Cta.fromJson(Map<String, dynamic> json) => Cta(
    text: json['text']??'',
    bgColor: json['bg_color'],
    textColor: json['text_color'],
    url: json['url'],
  );

  Map<String, dynamic> toJson() => {
    'text': text,
    'bg_color': bgColor,
    'text_color': textColor,
    'url': url,
  };
}