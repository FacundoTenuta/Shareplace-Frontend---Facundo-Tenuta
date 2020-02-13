

import 'dart:convert';

Client clientFromJson(String str) => Client.fromJson(json.decode(str));

String clientToJson(Client data) => json.encode(data.toJson());

class Client {
    List<Publication> data;

    Client({
        this.data,
    });

    factory Client.fromJson(Map<String, dynamic> json) => Client(
        data: List<Publication>.from(json["data"].map((x) => Publication.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Publications{
  List<Publication> items = new List();

  Publications();

  Publications.fromJsonList(List<dynamic> jsonList){

    if (jsonList == null) return;

    for (var item in jsonList) {
      final pelicula = new Publication.fromJson(item);
      items.add(pelicula);
    }

  }
}

class Publication {
    int id;
    DateTime createdAt;
    DateTime updatedAt;
    String title;
    String description;
    DateTime createDate;
    bool state;
    int userId;
    String principalImage;
    List<Image> images;
    List<Condition> conditions;
    List<Category> categories;

    Publication({
        this.id,
        this.createdAt,
        this.updatedAt,
        this.title,
        this.description,
        this.createDate,
        this.state,
        this.userId,
        this.principalImage,
        this.images,
        this.conditions,
        this.categories,
    });

    factory Publication.fromJson(Map<String, dynamic> json) => Publication(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        title: json["title"],
        description: json["description"],
        createDate: DateTime.parse(json["createDate"]),
        state: json["state"] == 1,
        userId: json["user_id"],
        principalImage: json["principalImage"],
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
        conditions: List<Condition>.from(json["conditions"].map((x) => Condition.fromJson(x))),
        categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "title": titleValues.reverse[title],
        "description": description,
        "createDate": "${createDate.year.toString().padLeft(4, '0')}-${createDate.month.toString().padLeft(2, '0')}-${createDate.day.toString().padLeft(2, '0')}",
        "state": state,
        "user_id": userId,
        "principalImage": principalImage,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "conditions": List<dynamic>.from(conditions.map((x) => x.toJson())),
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
    };

  @override
  bool operator ==(other) {
    return this.id == other.id;
  }

  @override
  int get hashCode => id.hashCode;

}

class Category {
    int id;
    String name;
    DateTime createdAt;
    DateTime updatedAt;
    CategoryPivot pivot;

    Category({
        this.id,
        this.name,
        this.createdAt,
        this.updatedAt,
        this.pivot,
    });

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        pivot: CategoryPivot.fromJson(json["pivot"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "pivot": pivot.toJson(),
    };
}

class CategoryPivot {
    int publicationId;
    int categoryId;

    CategoryPivot({
        this.publicationId,
        this.categoryId,
    });

    factory CategoryPivot.fromJson(Map<String, dynamic> json) => CategoryPivot(
        publicationId: json["publication_id"],
        categoryId: json["category_id"],
    );

    Map<String, dynamic> toJson() => {
        "publication_id": publicationId,
        "category_id": categoryId,
    };
}

class Condition {
    int id;
    String name;
    DateTime createdAt;
    DateTime updatedAt;
    ConditionPivot pivot;

    Condition({
        this.id,
        this.name,
        this.createdAt,
        this.updatedAt,
        this.pivot,
    });

    factory Condition.fromJson(Map<String, dynamic> json) => Condition(
        id: json["id"],
        name: json["name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        pivot: ConditionPivot.fromJson(json["pivot"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "pivot": pivot.toJson(),
    };
}

class ConditionPivot {
    int publicationId;
    int conditionId;

    ConditionPivot({
        this.publicationId,
        this.conditionId,
    });

    factory ConditionPivot.fromJson(Map<String, dynamic> json) => ConditionPivot(
        publicationId: json["publication_id"],
        conditionId: json["condition_id"],
    );

    Map<String, dynamic> toJson() => {
        "publication_id": publicationId,
        "condition_id": conditionId,
    };
}

class Image {
    int id;
    DateTime createdAt;
    DateTime updatedAt;
    DateTime date;
    String path;
    int publicationId;

    Image({
        this.id,
        this.createdAt,
        this.updatedAt,
        this.date,
        this.path,
        this.publicationId,
    });

    factory Image.fromJson(Map<String, dynamic> json) => Image(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        date: DateTime.parse(json["date"]),
        path: json["path"],
        publicationId: json["publication_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "path": path,
        "publication_id": publicationId,
    };
}

enum Title { TITULO_DE_PUBLICACION }

final titleValues = EnumValues({
    "titulo de publicacion": Title.TITULO_DE_PUBLICACION
});

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}
