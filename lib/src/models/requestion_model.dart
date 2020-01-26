
import 'dart:convert';

Client clientFromJson(String str) => Client.fromJson(json.decode(str));

String clientToJson(Client data) => json.encode(data.toJson());

class Client {
    List<Requestion> data;

    Client({
        this.data,
    });

    factory Client.fromJson(Map<String, dynamic> json) => Client(
        data: List<Requestion>.from(json["data"].map((x) => Requestion.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Requestion {
    int id;
    DateTime createdAt;
    DateTime updatedAt;
    String title;
    DateTime fromDate;
    DateTime untilDate;
    String reason;
    String state;
    int publicationId;
    int requesterId;

    Requestion({
        this.id,
        this.createdAt,
        this.updatedAt,
        this.title,
        this.fromDate,
        this.untilDate,
        this.reason,
        this.state,
        this.publicationId,
        this.requesterId,
    });

    factory Requestion.fromJson(Map<String, dynamic> json) => Requestion(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        title: json["title"],
        fromDate: DateTime.parse(json["fromDate"]),
        untilDate: DateTime.parse(json["untilDate"]),
        reason: json["reason"],
        state: json["state"],
        publicationId: json["publication_id"],
        requesterId: json["requester_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "title": title,
        "fromDate": "${fromDate.year.toString().padLeft(4, '0')}-${fromDate.month.toString().padLeft(2, '0')}-${fromDate.day.toString().padLeft(2, '0')}",
        "untilDate": "${untilDate.year.toString().padLeft(4, '0')}-${untilDate.month.toString().padLeft(2, '0')}-${untilDate.day.toString().padLeft(2, '0')}",
        "reason": reason,
        "state": state,
        "publication_id": publicationId,
        "requester_id": requesterId,
    };
}
