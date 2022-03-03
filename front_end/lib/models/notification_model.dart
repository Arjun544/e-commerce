// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

NotificationModel notificationModelFromJson(String str) =>
    NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) =>
    json.encode(data.toJson());

class NotificationModel {
  NotificationModel({
    required this.success,
    required this.notifications,
  });

  final bool success;
  final List<Notification> notifications;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        success: json['success'],
        notifications: List<Notification>.from(
            json['notifications'].map((x) => Notification.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'notifications':
            List<dynamic>.from(notifications.map((x) => x.toJson())),
      };
}

class Notification {
  Notification({
    required this.hasRead,
    required this.id,
    required this.title,
    required this.body,
    required this.type,
    required this.user,
    required this.createdAt,
    required this.v,
    required this.notificationId,
  });

  final bool hasRead;
  final String id;
  final String title;
  final String body;
  final String type;
  final String user;
  final DateTime createdAt;
  final int v;
  final String notificationId;

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        hasRead: json['hasRead'],
        id: json['_id'],
        title: json['title'],
        body: json['body'],
        type: json['type'],
        user: json['user'],
        createdAt: DateTime.parse(json['createdAt']),
        v: json['__v'],
        notificationId: json['id'],
      );

  Map<String, dynamic> toJson() => {
        'hasRead': hasRead,
        '_id': id,
        'title': title,
        'body': body,
        'type': type,
        'user': user,
        'createdAt': createdAt.toIso8601String(),
        '__v': v,
        'id': notificationId,
      };
}
