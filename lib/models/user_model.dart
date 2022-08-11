class UserModel {
  User? user;

  UserModel({this.user});

  UserModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  int? companyId;
  String? name;
  String? surname;
  String? email;
  String? pictureThumb;

  User(
      {this.id,
      this.companyId,
      this.name,
      this.surname,
      this.email,
      this.pictureThumb});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyId = json['company_id'];
    name = json['name'];
    surname = json['surname'];
    email = json['email'];
    pictureThumb = json['picture_thumb'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['company_id'] = companyId;
    data['name'] = name;
    data['surname'] = surname;
    data['email'] = email;
    data['picture_thumb'] = pictureThumb;
    return data;
  }
}
