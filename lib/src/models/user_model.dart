



class User{

  int     id;
  String  name;
  String  lastName;
  String  email;
  String  image;
  int     dni;
  String  birthDate;
  int     enabled;
  int     admin;
  String  created_at;
  String  updated_at;
  String  description;

  User({
    this.id,
    this.name,
    this.lastName,
    this.email,
    this.image,
    this.dni,
    this.birthDate,
    this.enabled,
    this.admin,
    this.created_at,
    this.updated_at,
    this.description,
  });

  factory User.fromJson(Map<String, dynamic> json){
    return User(
      id:           json['id'],
      name:         json['name'],
      lastName:     json['lastName'],
      email:        json['email'],
      image:        json['image'],
      dni:          json['dni'],
      birthDate:    json['birthDate'],
      enabled:      json['enabled'],
      admin:        json['admin'],
      created_at:   json['created_at'],
      updated_at:   json['updated_at'],
      description:  json['description'],
    );
  }

}