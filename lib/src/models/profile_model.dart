// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) =>
    ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  ProfileModel({
    this.id,
    this.type,
    this.attributes,
  });

  String id;
  String type;
  Attributes attributes;

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        id: json["id"],
        type: json["type"],
        attributes: Attributes.fromJson(json["attributes"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "attributes": attributes.toJson(),
      };
}

class Attributes {
  Attributes({
    this.name,
    this.fullName,
    this.photo,
    this.enrollment,
  });

  String name;
  String fullName;
  Photo photo;
  String enrollment;

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
        name: json["name"],
        fullName: json["full_name"],
        photo: Photo.fromJson(json["photo"]),
        enrollment: json["enrollment"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "full_name": fullName,
        "photo": photo.toJson(),
        "enrollment": enrollment,
      };
}

class Photo {
  Photo({
    this.url,
    this.large,
    this.normal,
    this.thumb,
  });

  String url;
  Large large;
  Large normal;
  Large thumb;

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        url: json["url"],
        large: Large.fromJson(json["large"]),
        normal: Large.fromJson(json["normal"]),
        thumb: Large.fromJson(json["thumb"]),
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "large": large.toJson(),
        "normal": normal.toJson(),
        "thumb": thumb.toJson(),
      };
}

class Large {
  Large({
    this.url,
  });

  String url;

  factory Large.fromJson(Map<String, dynamic> json) => Large(
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
      };
}
