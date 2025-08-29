import 'card_image.dart';
import 'bg_gradient.dart';
import 'cta.dart';
import 'formatted_text.dart';

class ContextualCard {
  final int id;
  final String name;
  final String? title;
  final FormattedText? formattedTitle;
  final String? description;
  final FormattedText? formattedDescription;
  final String? url;
  final CardImage? bgImage;
  final String? bgColor;
  final List<Cta>? cta;
  final BgGradient? bgGradient;
  final CardImage? icon;

  ContextualCard({
    required this.id,
    required this.name,
    this.title,
    this.formattedTitle,
    this.description,
    this.formattedDescription,
    this.url,
    this.bgImage,
    this.bgColor,
    this.cta,
    this.bgGradient,
    this.icon,
  });

  factory ContextualCard.fromJson(Map<String, dynamic> json) => ContextualCard(
    id: json['id']??-1,
    name: json['name'],
    title: json['title'],
    formattedTitle: json['formatted_title'] != null
        ? FormattedText.fromJson(json['formatted_title'])
        : null,
    description: json['description'],
    formattedDescription: json['formatted_description'] != null
        ? FormattedText.fromJson(json['formatted_description'])
        : null,
    url: json['url'],
    bgImage: json['bg_image'] != null
        ? CardImage.fromJson(json['bg_image'])
        : null,
    bgColor: json['bg_color'],
    cta: json['cta'] != null
        ? List<Cta>.from(json['cta'].map((x) => Cta.fromJson(x)))
        : null,
    bgGradient: json['bg_gradient'] != null
        ? BgGradient.fromJson(json['bg_gradient'])
        : null,
    icon: json['icon'] != null ? CardImage.fromJson(json['icon']) : null,
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'title': title,
    'formatted_title': formattedTitle?.toJson(),
    'description': description,
    'formatted_description': formattedDescription?.toJson(),
    'url': url,
    'bg_image': bgImage?.toJson(),
    'bg_color': bgColor,
    'cta': cta?.map((x) => x.toJson()).toList(),
    'bg_gradient': bgGradient?.toJson(),
    'icon': icon?.toJson(),
  };
}