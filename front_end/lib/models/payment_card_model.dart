// To parse this JSON data, do
//
//     final paymentCardModel = paymentCardModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

PaymentCardModel paymentCardModelFromJson(String str) =>
    PaymentCardModel.fromJson(json.decode(str));

String paymentCardModelToJson(PaymentCardModel data) =>
    json.encode(data.toJson());

class PaymentCardModel {
  PaymentCardModel({
    required this.card,
  });

  Card card;

  factory PaymentCardModel.fromJson(Map<String, dynamic> json) =>
      PaymentCardModel(
        card: Card.fromJson(json['card']),
      );

  Map<String, dynamic> toJson() => {
        'card': card.toJson(),
      };
}

class Card {
  Card({
    required this.id,
    required this.object,
    required this.addressCity,
    required this.addressCountry,
    required this.addressLine1,
    required this.addressLine1Check,
    required this.addressLine2,
    required this.addressState,
    required this.addressZip,
    required this.addressZipCheck,
    required this.brand,
    required this.country,
    required this.customer,
    required this.cvcCheck,
    required this.dynamicLast4,
    required this.expMonth,
    required this.expYear,
    required this.fingerprint,
    required this.funding,
    required this.last4,
    required this.metadata,
    required this.name,
    required this.tokenizationMethod,
  });

  String id;
  String object;
  dynamic addressCity;
  dynamic addressCountry;
  dynamic addressLine1;
  dynamic addressLine1Check;
  dynamic addressLine2;
  dynamic addressState;
  dynamic addressZip;
  dynamic addressZipCheck;
  String brand;
  String country;
  String customer;
  String cvcCheck;
  dynamic dynamicLast4;
  int expMonth;
  int expYear;
  String fingerprint;
  String funding;
  String last4;
  Metadata metadata;
  dynamic name;
  dynamic tokenizationMethod;

  factory Card.fromJson(Map<String, dynamic> json) => Card(
        id: json['id'],
        object: json['object'],
        addressCity: json['address_city'],
        addressCountry: json['address_country'],
        addressLine1: json['address_line1'],
        addressLine1Check: json['address_line1_check'],
        addressLine2: json['address_line2'],
        addressState: json['address_state'],
        addressZip: json['address_zip'],
        addressZipCheck: json['address_zip_check'],
        brand: json['brand'],
        country: json['country'],
        customer: json['customer'],
        cvcCheck: json['cvc_check'],
        dynamicLast4: json['dynamic_last4'],
        expMonth: json['exp_month'],
        expYear: json['exp_year'],
        fingerprint: json['fingerprint'],
        funding: json['funding'],
        last4: json['last4'],
        metadata: Metadata.fromJson(json['metadata']),
        name: json['name'],
        tokenizationMethod: json['tokenization_method'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'object': object,
        'address_city': addressCity,
        'address_country': addressCountry,
        'address_line1': addressLine1,
        'address_line1_check': addressLine1Check,
        'address_line2': addressLine2,
        'address_state': addressState,
        'address_zip': addressZip,
        'address_zip_check': addressZipCheck,
        'brand': brand,
        'country': country,
        'customer': customer,
        'cvc_check': cvcCheck,
        'dynamic_last4': dynamicLast4,
        'exp_month': expMonth,
        'exp_year': expYear,
        'fingerprint': fingerprint,
        'funding': funding,
        'last4': last4,
        'metadata': metadata.toJson(),
        'name': name,
        'tokenization_method': tokenizationMethod,
      };
}

class Metadata {
  Metadata();

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata();

  Map<String, dynamic> toJson() => {};
}
