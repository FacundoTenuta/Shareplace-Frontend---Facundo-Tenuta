
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

class Requestions{
  List<Requestion> items = new List();

  Requestions();

  Requestions.fromJsonList(List<dynamic> jsonList){

    if (jsonList == null) return;

    for (var item in jsonList) {
      final pelicula = new Requestion.fromJson(item);
      items.add(pelicula);
    }

  }
}

class Requestion {
    int id;
    DateTime createdAt;
    DateTime updatedAt;
    String title;
    DateTime fromDate;
    DateTime untilDate;
    String reason;
    bool active;
    bool isLoan;
    DateTime startDate;
    DateTime endDate;
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
        this.active,
        this.isLoan,
        this.startDate,
        this.endDate,
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
        active: json["active"] == 1,
        isLoan: json["isLoan"] == 1,
        startDate: DateTime.parse(json["startDate"]),
        endDate: DateTime.parse(json["endDate"]),
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
        "active": active,
        "isLoan": isLoan,
        "startDate": "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "endDate": "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        "publication_id": publicationId,
        "requester_id": requesterId,
    };

    @override
    bool operator ==(other) {
      return this.id == other.id;
    }

    @override
    int get hashCode => id.hashCode;
}
