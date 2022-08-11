class MenuModel {
  int? id;
  int? ordering;
  String? name;
  String? description;
  List<Menus>? menus;

  @override
  String toString() {
    return "$name";
  }

  MenuModel({this.id, this.ordering, this.name, this.description, this.menus});

  MenuModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ordering = json['ordering'];
    name = json['name'];
    description = json['description'];
    if (json['menus'] != null) {
      menus = <Menus>[];
      json['menus'].forEach((v) {
        menus!.add(Menus.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['ordering'] = ordering;
    data['name'] = name;
    data['description'] = description;
    if (menus != null) {
      data['menus'] = menus!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

// class Menus {
//   int? id;
//   int? ordering;
//   String? name;
//   String? description;
//   int? price;
//   String? image;
//   String? imageThumb;

//   Menus(
//       {this.id,
//       this.ordering,
//       this.name,
//       this.description,
//       this.price,
//       this.image,
//       this.imageThumb});

//   Menus.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     ordering = json['ordering'];
//     name = json['name'];
//     description = json['description'];
//     price = json['price'];
//     image = json['image'];
//     imageThumb = json['image_thumb'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['ordering'] = ordering;
//     data['name'] = name;
//     data['description'] = description;
//     data['price'] = price;
//     data['image'] = image;
//     data['image_thumb'] = imageThumb;
//     return data;
//   }
// }

class Menus {
  int? id;
  int? ordering;
  String? name;
  String? description;
  int? price;
  String? image;
  String? imageThumb;
  List<MenuOptions>? options;

  Menus(
      {this.id,
      this.ordering,
      this.name,
      this.description,
      this.price,
      this.image,
      this.imageThumb,
      this.options});

  Menus.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ordering = json['ordering'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    image = json['image'];
    imageThumb = json['image_thumb'];
    if (json['options'] != null) {
      options = <MenuOptions>[];
      json['options'].forEach((v) {
        options!.add(MenuOptions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['ordering'] = ordering;
    data['name'] = name;
    data['description'] = description;
    data['price'] = price;
    data['image'] = image;
    data['image_thumb'] = imageThumb;
    if (options != null) {
      data['options'] = options!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MenuOptions {
  int? id;
  String? type;
  String? name;
  String? subitems;

  MenuOptions({this.id, this.type, this.name, this.subitems});

  MenuOptions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    name = json['name'];
    subitems = json['subitems'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['name'] = name;
    data['subitems'] = subitems;
    return data;
  }
}
