
import 'dart:convert';

Client clientFromJson(String str) => Client.fromJson(json.decode(str));

String clientToJson(Client data) => json.encode(data.toJson());

class Client {
    List<Loan> data;

    Client({
        this.data,
    });

    factory Client.fromJson(Map<String, dynamic> json) => Client(
        data: List<Loan>.from(json["data"].map((x) => Loan.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Loan {
    int id;
    DateTime createdAt;
    DateTime updatedAt;
    DateTime startDate;
    DateTime endDate;
    int requestionId;

    Loan({
        this.id,
        this.createdAt,
        this.updatedAt,
        this.startDate,
        this.endDate,
        this.requestionId,
    });

    factory Loan.fromJson(Map<String, dynamic> json) => Loan(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        startDate: DateTime.parse(json["startDate"]),
        endDate: DateTime.parse(json["endDate"]),
        requestionId: json["requestion_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "startDate": "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "endDate": "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        "requestion_id": requestionId,
    };
}
