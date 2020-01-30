
import 'dart:convert';

Client clientFromJson(String str) => Client.fromJson(json.decode(str));

String clientToJson(Client data) => json.encode(data.toJson());

class Client {
    List<Condition> data;

    Client({
        this.data,
    });

    factory Client.fromJson(Map<String, dynamic> json) => Client(
        data: List<Condition>.from(json["data"].map((x) => Condition.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Condition {
    int id;
    String name;
    DateTime createdAt;
    DateTime updatedAt;

    Condition({
        this.id,
        this.name,
        this.createdAt,
        this.updatedAt,
    });

    factory Condition.fromJson(Map<String, dynamic> json) => Condition(
        id: json["id"],
        name: json["name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
