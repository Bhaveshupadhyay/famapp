class CardImage {
  final String imageType;
  final String? assetType;
  final String? imageUrl;
  final num? aspectRatio;

  CardImage({
    required this.imageType,
    this.assetType,
    this.imageUrl,
    this.aspectRatio,
  });

  factory CardImage.fromJson(Map<String, dynamic> json) =>
      CardImage(
        imageType: json['image_type'],
        assetType: (json['image_type']=='asset')?json['asset_type'] : null,
        imageUrl: json['image_url'],
        aspectRatio: json['aspect_ratio']
      );

  Map<String, dynamic> toJson() => {
    'image_type': imageType,
    'asset_type' : assetType,
    'image_url': imageUrl,
    'aspect_ratio': aspectRatio
  };
}