
import 'dart:convert';

Client clientFromJson(String str) => Client.fromJson(json.decode(str));

String clientToJson(Client data) => json.encode(data.toJson());

class Client {
    List<User> data;

    Client({
        this.data,
    });

    factory Client.fromJson(Map<String, dynamic> json) => Client(
        data: List<User>.from(json["data"].map((x) => User.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class User {
    int id;
    String name;
    String lastName;
    String email;
    int phone;
    String image;
    int dni;
    DateTime birthDate;
    int enabled;
    int admin;
    DateTime createdAt;
    DateTime updatedAt;
    String description;
    List<Ability> links;
    List<Ability> abilities;

    User({
        this.id,
        this.name,
        this.lastName,
        this.email,
        this.phone,
        this.image,
        this.dni,
        this.birthDate,
        this.enabled,
        this.admin,
        this.createdAt,
        this.updatedAt,
        this.description,
        this.links,
        this.abilities,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        lastName: json["lastName"],
        email: json["email"],
        phone: json["phone"],
        image: json["image"],
        dni: json["dni"],
        birthDate: json["birthDate"] == null ? null : DateTime.parse(json["birthDate"]),
        enabled: json["enabled"],
        admin: json["admin"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        description: json["description"] == null ? null : json["description"],
        links: List<Ability>.from(json["links"].map((x) => Ability.fromJson(x))),
        abilities: List<Ability>.from(json["abilities"].map((x) => Ability.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "lastName": lastName,
        "email": email,
        "phone": phone,
        "image": image,
        "dni": dni,
        "birthDate": birthDate == null ? null : "${birthDate.year.toString().padLeft(4, '0')}-${birthDate.month.toString().padLeft(2, '0')}-${birthDate.day.toString().padLeft(2, '0')}",
        "enabled": enabled,
        "admin": admin,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "description": description == null ? null : description,
        "links": List<dynamic>.from(links.map((x) => x.toJson())),
        "abilities": List<dynamic>.from(abilities.map((x) => x.toJson())),
    };

    @override
  bool operator ==(other) {
    return this.id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}

class Ability {
    int id;
    String name;
    DateTime createdAt;
    DateTime updatedAt;
    Pivot pivot;
    int userId;

    Ability({
        this.id,
        this.name,
        this.createdAt,
        this.updatedAt,
        this.pivot,
        this.userId,
    });

    factory Ability.fromJson(Map<String, dynamic> json) => Ability(
        id: json["id"],
        name: json["name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        pivot: json["pivot"] == null ? null : Pivot.fromJson(json["pivot"]),
        userId: json["user_id"] == null ? null : json["user_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "pivot": pivot == null ? null : pivot.toJson(),
        "user_id": userId == null ? null : userId,
    };
}

class Pivot {
    int userId;
    int abilityId;

    Pivot({
        this.userId,
        this.abilityId,
    });

    factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
        userId: json["user_id"],
        abilityId: json["ability_id"],
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId,
        "ability_id": abilityId,
    };
}
