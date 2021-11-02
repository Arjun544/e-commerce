// To parse this JSON data, do
//
//     final paymentModel = paymentModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

PaymentModel paymentModelFromJson(String str) =>
    PaymentModel.fromJson(json.decode(str));

String paymentModelToJson(PaymentModel data) => json.encode(data.toJson());

class PaymentModel {
  PaymentModel({
    required this.card,
  });

  PaymentModelCard card;

  factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
        card: PaymentModelCard.fromJson(json['card']),
      );

  Map<String, dynamic> toJson() => {
        'card': card.toJson(),
      };
}

class PaymentModelCard {
  PaymentModelCard({
    required this.object,
    required this.data,
    required this.hasMore,
    required this.url,
  });

  String object;
  List<Datum> data;
  bool hasMore;
  String url;

  factory PaymentModelCard.fromJson(Map<String, dynamic> json) =>
      PaymentModelCard(
        object: json['object'],
        data: List<Datum>.from(json['data'].map((x) => Datum.fromJson(x))),
        hasMore: json['has_more'],
        url: json['url'],
      );

  Map<String, dynamic> toJson() => {
        'object': object,
        'data': List<dynamic>.from(data.map((x) => x.toJson())),
        'has_more': hasMore,
        'url': url,
      };
}

class Datum {
  Datum({
    required this.id,
    required this.object,
    required this.billingDetails,
    required this.card,
    required this.created,
    required this.customer,
    required this.livemode,
    required this.metadata,
    required this.type,
  });

  String id;
  String object;
  BillingDetails billingDetails;
  DatumCard card;
  int created;
  String customer;
  bool livemode;
  Metadata metadata;
  String type;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json['id'],
        object: json['object'],
        billingDetails: BillingDetails.fromJson(json['billing_details']),
        card: DatumCard.fromJson(json['card']),
        created: json['created'],
        customer: json['customer'],
        livemode: json['livemode'],
        metadata: Metadata.fromJson(json['metadata']),
        type: json['type'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'object': object,
        'billing_details': billingDetails.toJson(),
        'card': card.toJson(),
        'created': created,
        'customer': customer,
        'livemode': livemode,
        'metadata': metadata.toJson(),
        'type': type,
      };
}

class BillingDetails {
  BillingDetails({
    required this.address,
    required this.email,
    required this.name,
    required this.phone,
  });

  Address address;
  dynamic email;
  dynamic name;
  dynamic phone;

  factory BillingDetails.fromJson(Map<String, dynamic> json) => BillingDetails(
        address: Address.fromJson(json['address']),
        email: json['email'],
        name: json['name'],
        phone: json['phone'],
      );

  Map<String, dynamic> toJson() => {
        'address': address.toJson(),
        'email': email,
        'name': name,
        'phone': phone,
      };
}

class Address {
  Address({
    required this.city,
    required this.country,
    required this.line1,
    required this.line2,
    required this.postalCode,
    required this.state,
  });

  dynamic city;
  dynamic country;
  dynamic line1;
  dynamic line2;
  dynamic postalCode;
  dynamic state;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        city: json['city'],
        country: json['country'],
        line1: json['line1'],
        line2: json['line2'],
        postalCode: json['postal_code'],
        state: json['state'],
      );

  Map<String, dynamic> toJson() => {
        'city': city,
        'country': country,
        'line1': line1,
        'line2': line2,
        'postal_code': postalCode,
        'state': state,
      };
}

class DatumCard {
  DatumCard({
    required this.brand,
    required this.checks,
    required this.country,
    required this.expMonth,
    required this.expYear,
    required this.fingerprint,
    required this.funding,
    required this.generatedFrom,
    required this.last4,
    required this.networks,
    required this.threeDSecureUsage,
    required this.wallet,
  });

  String brand;
  Checks checks;
  String country;
  int expMonth;
  int expYear;
  String fingerprint;
  String funding;
  dynamic generatedFrom;
  String last4;
  Networks networks;
  ThreeDSecureUsage threeDSecureUsage;
  dynamic wallet;

  factory DatumCard.fromJson(Map<String, dynamic> json) => DatumCard(
        brand: json['brand'],
        checks: Checks.fromJson(json['checks']),
        country: json['country'],
        expMonth: json['exp_month'],
        expYear: json['exp_year'],
        fingerprint: json['fingerprint'],
        funding: json['funding'],
        generatedFrom: json['generated_from'],
        last4: json['last4'],
        networks: Networks.fromJson(json['networks']),
        threeDSecureUsage:
            ThreeDSecureUsage.fromJson(json['three_d_secure_usage']),
        wallet: json['wallet'],
      );

  Map<String, dynamic> toJson() => {
        'brand': brand,
        'checks': checks.toJson(),
        'country': country,
        'exp_month': expMonth,
        'exp_year': expYear,
        'fingerprint': fingerprint,
        'funding': funding,
        'generated_from': generatedFrom,
        'last4': last4,
        'networks': networks.toJson(),
        'three_d_secure_usage': threeDSecureUsage.toJson(),
        'wallet': wallet,
      };
}

class Checks {
  Checks({
    required this.addressLine1Check,
    required this.addressPostalCodeCheck,
    required this.cvcCheck,
  });

  dynamic addressLine1Check;
  dynamic addressPostalCodeCheck;
  String cvcCheck;

  factory Checks.fromJson(Map<String, dynamic> json) => Checks(
        addressLine1Check: json['address_line1_check'],
        addressPostalCodeCheck: json['address_postal_code_check'],
        cvcCheck: json['cvc_check'],
      );

  Map<String, dynamic> toJson() => {
        'address_line1_check': addressLine1Check,
        'address_postal_code_check': addressPostalCodeCheck,
        'cvc_check': cvcCheck,
      };
}

class Networks {
  Networks({
    required this.available,
    required this.preferred,
  });

  List<String> available;
  dynamic preferred;

  factory Networks.fromJson(Map<String, dynamic> json) => Networks(
        available: List<String>.from(json['available'].map((x) => x)),
        preferred: json['preferred'],
      );

  Map<String, dynamic> toJson() => {
        'available': List<dynamic>.from(available.map((x) => x)),
        'preferred': preferred,
      };
}

class ThreeDSecureUsage {
  ThreeDSecureUsage({
    required this.supported,
  });

  bool supported;

  factory ThreeDSecureUsage.fromJson(Map<String, dynamic> json) =>
      ThreeDSecureUsage(
        supported: json['supported'],
      );

  Map<String, dynamic> toJson() => {
        'supported': supported,
      };
}

class Metadata {
  Metadata();

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata();

  Map<String, dynamic> toJson() => {};
}
