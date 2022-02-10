// // To parse this JSON data, do
// //
// //     final searchModel = searchModelFromJson(jsonString);

// import 'package:meta/meta.dart';
// import 'dart:convert';

// SearchModel searchModelFromJson(String str) =>
//     SearchModel.fromJson(json.decode(str));

// String searchModelToJson(SearchModel data) => json.encode(data.toJson());

// class SearchModel {
//   SearchModel({
//     required this.page,
//     required this.hasNextPage,
//     required this.hasPrevPage,
//     required this.totalPages,
//     required this.totalResults,
//     required this.results,
//   });

//   final int page;
//   final bool hasNextPage;
//   final bool hasPrevPage;
//   final int totalPages;
//   final int totalResults;
//   final List<Result> results;

//   factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
//         page: json['page'],
//         hasNextPage: json['hasNextPage'],
//         hasPrevPage: json['hasPrevPage'],
//         totalPages: json['total_pages'],
//         totalResults: json['total_results'],
//         results:
//             List<Result>.from(json['results'].map((x) => Result.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         'page': page,
//         'hasNextPage': hasNextPage,
//         'hasPrevPage': hasPrevPage,
//         'total_pages': totalPages,
//         'total_results': totalResults,
//         'results': List<dynamic>.from(results.map((x) => x.toJson())),
//       };
// }

// class Result {
//   Result({
//     required this.id,
//     required this.quantity,
//     required this.fullDescription,
//     required this.images,
//     required this.price,
//     required this.onSale,
//     required this.totalPrice,
//     required this.discount,
//     required this.totalReviews,
//     required this.reviews,
//     required this.isReviewed,
//     required this.isFeatured,
//     required this.status,
//     required this.nameFuzzy,
//     required this.name,
//     required this.description,
//     required this.thumbnail,
//     required this.thumbnailId,
//     required this.category,
//     required this.subCategory,
//     required this.countInStock,
//     required this.dateCreated,
//     required this.v,
//   });

//   final String id;
//   final int quantity;
//   final FullDescription fullDescription;
//   final List<Image> images;
//   final int price;
//   final bool onSale;
//   final int totalPrice;
//   final int discount;
//   final int totalReviews;
//   final List<Review> reviews;
//   final bool isReviewed;
//   final bool isFeatured;
//   final bool status;
//   final List<String> nameFuzzy;
//   final String name;
//   final Description description;
//   final String thumbnail;
//   final ThumbnailId thumbnailId;
//   final List<dynamic> category;
//   final SubCategory subCategory;
//   final int countInStock;
//   final DateTime dateCreated;
//   final int v;

//   factory Result.fromJson(Map<String, dynamic> json) => Result(
//         id: json['_id'],
//         quantity: json['quantity'],
//         fullDescription: fullDescriptionValues.map[json['fullDescription']],
//         images: List<Image>.from(json['images'].map((x) => Image.fromJson(x))),
//         price: json['price'],
//         onSale: json['onSale'],
//         totalPrice: json['totalPrice'],
//         discount: json['discount'],
//         totalReviews: json['totalReviews'],
//         reviews:
//             List<Review>.from(json['reviews'].map((x) => Review.fromJson(x))),
//         isReviewed: json['isReviewed'],
//         isFeatured: json['isFeatured'],
//         status: json['status'],
//         nameFuzzy: List<String>.from(json['name_fuzzy'].map((x) => x)),
//         name: json['name'],
//         description: descriptionValues.map[json['description']],
//         thumbnail: json['thumbnail'],
//         thumbnailId: thumbnailIdValues.map[json['thumbnailId']],
//         category: List<dynamic>.from(json['category'].map((x) => x)),
//         subCategory: subCategoryValues.map[json['subCategory']],
//         countInStock: json['countInStock'],
//         dateCreated: DateTime.parse(json['dateCreated']),
//         v: json['__v'],
//       );

//   Map<String, dynamic> toJson() => {
//         '_id': id,
//         'quantity': quantity,
//         'fullDescription': fullDescriptionValues.reverse[fullDescription],
//         'images': List<dynamic>.from(images.map((x) => x.toJson())),
//         'price': price,
//         'onSale': onSale,
//         'totalPrice': totalPrice,
//         'discount': discount,
//         'totalReviews': totalReviews,
//         'reviews': List<dynamic>.from(reviews.map((x) => x.toJson())),
//         'isReviewed': isReviewed,
//         'isFeatured': isFeatured,
//         'status': status,
//         'name_fuzzy': List<dynamic>.from(nameFuzzy.map((x) => x)),
//         'name': name,
//         'description': descriptionValues.reverse[description],
//         'thumbnail': thumbnail,
//         'thumbnailId': thumbnailIdValues.reverse[thumbnailId],
//         'category': List<dynamic>.from(category.map((x) => x)),
//         'subCategory': subCategoryValues.reverse[subCategory],
//         'countInStock': countInStock,
//         'dateCreated': dateCreated.toIso8601String(),
//         '__v': v,
//       };
// }

// enum Description { CONFRONT_JEANS_FOR_MEN, TEST_DESC }

// final descriptionValues = EnumValues({
//   'Confront jeans for men': Description.CONFRONT_JEANS_FOR_MEN,
//   'test desc': Description.TEST_DESC
// });

// enum FullDescription { TEST }

// final fullDescriptionValues = EnumValues({'test': FullDescription.TEST});

// class Image {
//   Image({
//     required this.id,
//     required this.url,
//   });

//   final String id;
//   final String url;

//   factory Image.fromJson(Map<String, dynamic> json) => Image(
//         id: json['id'],
//         url: json['url'],
//       );

//   Map<String, dynamic> toJson() => {
//         'id': id,
//         'url': url,
//       };
// }

// class Review {
//   Review({
//     required this.id,
//     required this.user,
//     required this.review,
//     required this.rating,
//     required this.product,
//     required this.addedAt,
//     required this.v,
//   });

//   final String id;
//   final User user;
//   final String review;
//   final int rating;
//   final Product product;
//   final DateTime addedAt;
//   final int v;

//   factory Review.fromJson(Map<String, dynamic> json) => Review(
//         id: json['_id'],
//         user: User.fromJson(json['user']),
//         review: json['review'],
//         rating: json['rating'],
//         product: Product.fromJson(json['product']),
//         addedAt: DateTime.parse(json['addedAt']),
//         v: json['__v'],
//       );

//   Map<String, dynamic> toJson() => {
//         '_id': id,
//         'user': user.toJson(),
//         'review': review,
//         'rating': rating,
//         'product': product.toJson(),
//         'addedAt': addedAt.toIso8601String(),
//         '__v': v,
//       };
// }

// class Product {
//   Product({
//     required this.quantity,
//     required this.fullDescription,
//     required this.images,
//     required this.price,
//     required this.onSale,
//     required this.totalPrice,
//     required this.discount,
//     required this.totalReviews,
//     required this.reviews,
//     required this.isReviewed,
//     required this.isFeatured,
//     required this.status,
//     required this.id,
//     required this.name,
//     required this.description,
//     required this.thumbnail,
//     required this.thumbnailId,
//     required this.category,
//     required this.subCategory,
//     required this.countInStock,
//     required this.dateCreated,
//     required this.v,
//   });

//   final int quantity;
//   final FullDescription fullDescription;
//   final List<dynamic> images;
//   final int price;
//   final bool onSale;
//   final int totalPrice;
//   final int discount;
//   final int totalReviews;
//   final List<dynamic> reviews;
//   final bool isReviewed;
//   final bool isFeatured;
//   final bool status;
//   final String id;
//   final String name;
//   final Description description;
//   final String thumbnail;
//   final ThumbnailId thumbnailId;
//   final String category;
//   final SubCategory subCategory;
//   final int countInStock;
//   final DateTime dateCreated;
//   final int v;

//   factory Product.fromJson(Map<String, dynamic> json) => Product(
//         quantity: json['quantity'],
//         fullDescription: fullDescriptionValues.map[json['fullDescription']],
//         images: List<dynamic>.from(json['images'].map((x) => x)),
//         price: json['price'],
//         onSale: json['onSale'],
//         totalPrice: json['totalPrice'],
//         discount: json['discount'],
//         totalReviews: json['totalReviews'],
//         reviews: List<dynamic>.from(json['reviews'].map((x) => x)),
//         isReviewed: json['isReviewed'],
//         isFeatured: json['isFeatured'],
//         status: json['status'],
//         id: json['_id'],
//         name: json['name'],
//         description: descriptionValues.map[json['description']],
//         thumbnail: json['thumbnail'],
//         thumbnailId: thumbnailIdValues.map[json['thumbnailId']],
//         category: json['category'],
//         subCategory: subCategoryValues.map[json['subCategory']],
//         countInStock: json['countInStock'],
//         dateCreated: DateTime.parse(json['dateCreated']),
//         v: json['__v'],
//       );

//   Map<String, dynamic> toJson() => {
//         'quantity': quantity,
//         'fullDescription': fullDescriptionValues.reverse[fullDescription],
//         'images': List<dynamic>.from(images.map((x) => x)),
//         'price': price,
//         'onSale': onSale,
//         'totalPrice': totalPrice,
//         'discount': discount,
//         'totalReviews': totalReviews,
//         'reviews': List<dynamic>.from(reviews.map((x) => x)),
//         'isReviewed': isReviewed,
//         'isFeatured': isFeatured,
//         'status': status,
//         '_id': id,
//         'name': name,
//         'description': descriptionValues.reverse[description],
//         'thumbnail': thumbnail,
//         'thumbnailId': thumbnailIdValues.reverse[thumbnailId],
//         'category': category,
//         'subCategory': subCategoryValues.reverse[subCategory],
//         'countInStock': countInStock,
//         'dateCreated': dateCreated.toIso8601String(),
//         '__v': v,
//       };
// }

// enum SubCategory { JEANS, NEW_CATEGORY }

// final subCategoryValues = EnumValues(
//     {'Jeans': SubCategory.JEANS, 'new category': SubCategory.NEW_CATEGORY});

// enum ThumbnailId { BDUAOTPAI08_P3_OMVJ2_YG, SAYKPVDHEFNMR7_NLNYI8 }

// final thumbnailIdValues = EnumValues({
//   'bduaotpai08p3omvj2yg': ThumbnailId.BDUAOTPAI08_P3_OMVJ2_YG,
//   'saykpvdhefnmr7nlnyi8': ThumbnailId.SAYKPVDHEFNMR7_NLNYI8
// });

// class User {
//   User({
//     required this.profile,
//     required this.isAdmin,
//     required this.street,
//     required this.shippingAddress,
//     required this.zip,
//     required this.city,
//     required this.country,
//     required this.customerId,
//     required this.active,
//     required this.id,
//     required this.username,
//     required this.email,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.v,
//   });

//   final String profile;
//   final bool isAdmin;
//   final String street;
//   final List<ShippingAddress> shippingAddress;
//   final String zip;
//   final String city;
//   final String country;
//   final String customerId;
//   final bool active;
//   final String id;
//   final String username;
//   final String email;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   final int v;

//   factory User.fromJson(Map<String, dynamic> json) => User(
//         profile: json['profile'],
//         isAdmin: json['isAdmin'],
//         street: json['street'],
//         shippingAddress: List<ShippingAddress>.from(
//             json['ShippingAddress'].map((x) => ShippingAddress.fromJson(x))),
//         zip: json['zip'],
//         city: json['city'],
//         country: json['country'],
//         customerId: json['customerId'],
//         active: json['active'],
//         id: json['_id'],
//         username: json['username'],
//         email: json['email'],
//         createdAt: DateTime.parse(json['createdAt']),
//         updatedAt: DateTime.parse(json['updatedAt']),
//         v: json['__v'],
//       );

//   Map<String, dynamic> toJson() => {
//         'profile': profile,
//         'isAdmin': isAdmin,
//         'street': street,
//         'ShippingAddress':
//             List<dynamic>.from(shippingAddress.map((x) => x.toJson())),
//         'zip': zip,
//         'city': city,
//         'country': country,
//         'customerId': customerId,
//         'active': active,
//         '_id': id,
//         'username': username,
//         'email': email,
//         'createdAt': createdAt.toIso8601String(),
//         'updatedAt': updatedAt.toIso8601String(),
//         '__v': v,
//       };
// }

// class ShippingAddress {
//   ShippingAddress({
//     required this.id,
//     required this.address,
//     required this.city,
//     required this.country,
//     required this.phone,
//     required this.type,
//   });

//   final String id;
//   final String address;
//   final String city;
//   final String country;
//   final String phone;
//   final String type;

//   factory ShippingAddress.fromJson(Map<String, dynamic> json) =>
//       ShippingAddress(
//         id: json['id'],
//         address: json['address'],
//         city: json['city'],
//         country: json['country'],
//         phone: json['phone'],
//         type: json['type'],
//       );

//   Map<String, dynamic> toJson() => {
//         'id': id,
//         'address': address,
//         'city': city,
//         'country': country,
//         'phone': phone,
//         'type': type,
//       };
// }

// class EnumValues<T> {
//   Map<String, T> map;
//   Map<T, String> reverseMap;

//   EnumValues(this.map);

//   Map<T, String> get reverse {
//     if (reverseMap == null) {
//       reverseMap = map.map((k, v) => new MapEntry(v, k));
//     }
//     return reverseMap;
//   }
// }
