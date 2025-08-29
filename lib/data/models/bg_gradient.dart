class BgGradient {
  final int angle;
  final List<String> colors;

  BgGradient({
    required this.angle,
    required this.colors,
  });

  factory BgGradient.fromJson(Map<String, dynamic> json) => BgGradient(
    angle: json['angle']??0,
    colors: List<String>.from(json['colors']),
  );

  Map<String, dynamic> toJson() => {
    'angle': angle,
    'colors': colors,
  };
}