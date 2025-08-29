import 'card_group.dart';
import 'formatted_text.dart';

class FamxPayPage {
  final String? title;
  final FormattedText? formattedTitle;
  final String? description;
  final FormattedText? formattedDescription;
  final List<dynamic>? assets;
  final List<CardGroup> hcGroups;

  FamxPayPage({
    this.title,
    this.formattedTitle,
    this.description,
    this.formattedDescription,
    this.assets,
    required this.hcGroups,
  });

  factory FamxPayPage.fromJson(Map<String, dynamic> json) => FamxPayPage(
    title: json['title'],
    formattedTitle: json['formatted_title'] != null
        ? FormattedText.fromJson(json['formatted_title'])
        : null,
    description: json['description'],
    formattedDescription: json['formatted_description'] != null
        ? FormattedText.fromJson(json['formatted_description'])
        : null,
    assets: json['assets'],
    hcGroups: List<CardGroup>.from(
        json['hc_groups'].map((x) => CardGroup.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    'title': title,
    'formatted_title': formattedTitle?.toJson(),
    'description': description,
    'formatted_description': formattedDescription?.toJson(),
    'assets': assets,
    'hc_groups': hcGroups.map((x) => x.toJson()).toList(),
  };
}