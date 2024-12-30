import 'dart:convert';

// To parse this JSON data, do
//
//     final trackResponse = trackResponseFromJson(jsonString);

TrackResponse trackResponseFromJson(String str) =>
    TrackResponse.fromJson(json.decode(str));

String trackResponseToJson(TrackResponse data) => json.encode(data.toJson());

class TrackResponse {
  final int? success;
  final String? message;
  final Data? data;

  TrackResponse({
    this.success,
    this.message,
    this.data,
  });

  factory TrackResponse.fromJson(Map<String, dynamic> json) => TrackResponse(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  final String? trackingid;
  final String? courier;
  final List<Timeline>? timeline;

  Data({
    this.trackingid,
    this.courier,
    this.timeline,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        trackingid: json["trackingid"],
        courier: json["courier"],
        timeline: json["timeline"] == null
            ? []
            : List<Timeline>.from(
                json["timeline"]!.map((x) => Timeline.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
        "trackingid": trackingid,
        "courier": courier,
        "timeline": timeline == null
            ? []
            : List<dynamic>.from(timeline!.map((x) => x.toJson())),
      };
}

class Timeline {
  final int? id;
  final int? trackId;
  final int? timelineId;
  final String? timelineStatus;
  final String? description;
  final int? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Statushistory? statushistory;
  final List<dynamic>? trackingstatus;

  Timeline({
    this.id,
    this.trackId,
    this.timelineId,
    this.timelineStatus,
    this.description,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.statushistory,
    this.trackingstatus,
  });

  factory Timeline.fromJson(Map<dynamic, dynamic> json) => Timeline(
        id: json["id"],
        trackId: json["track_id"],
        timelineId: json["timeline_id"],
        timelineStatus: json["timeline_status"],
        description: json["description"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        statushistory: json["statushistory"] == null
            ? null
            : Statushistory.fromJson(json["statushistory"]),
        trackingstatus: json["trackingstatus"] == null
            ? []
            : List<dynamic>.from(json["trackingstatus"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "track_id": trackId,
        "timeline_id": timelineId,
        "timeline_status": timelineStatus,
        "description": description,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "statushistory": statushistory?.toJson(),
        "trackingstatus": trackingstatus == null
            ? []
            : List<dynamic>.from(trackingstatus!.map((x) => x)),
      };
}

class Statushistory {
  final int? id;
  final int? orderStatusId;
  final int? languageId;
  final String? statusText;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Statushistory({
    this.id,
    this.orderStatusId,
    this.languageId,
    this.statusText,
    this.createdAt,
    this.updatedAt,
  });

  factory Statushistory.fromJson(Map<String, dynamic> json) => Statushistory(
        id: json["id"],
        orderStatusId: json["order_status_id"],
        languageId: json["language_id"],
        statusText: json["status_text"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_status_id": orderStatusId,
        "language_id": languageId,
        "status_text": statusText,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
