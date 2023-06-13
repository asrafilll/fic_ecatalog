import 'dart:convert';

import 'package:flutter/foundation.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
// {
//     "title": "Change title",
//     "price": 100,
//     "images": [
//         "https://placeimg.com/640/480/any"
//     ]
// }

class EditProductRequestModel {
  final String title;
  final int price;
  final List<String> images;
  EditProductRequestModel({
    required this.title,
    required this.price,
    this.images = const ['https://placeimg.com/640/480/any'],
  });

  EditProductRequestModel copyWith({
    String? title,
    int? price,
    List<String>? images,
  }) {
    return EditProductRequestModel(
      title: title ?? this.title,
      price: price ?? this.price,
      images: images ?? this.images,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'price': price,
      'images': images,
    };
  }

  factory EditProductRequestModel.fromMap(Map<String, dynamic> map) {
    return EditProductRequestModel(
        title: map['title'] as String,
        price: map['price'] as int,
        images: List<String>.from(
          (map['images'] as List<String>),
        ));
  }

  String toJson() => json.encode(toMap());

  factory EditProductRequestModel.fromJson(String source) =>
      EditProductRequestModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'EditProductRequestModel(title: $title, price: $price, images: $images)';

  @override
  bool operator ==(covariant EditProductRequestModel other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        other.price == price &&
        listEquals(other.images, images);
  }

  @override
  int get hashCode => title.hashCode ^ price.hashCode ^ images.hashCode;
}
