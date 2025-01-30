class Movies {
  int? id;
  int? userId;
  String? title;
  String? description;
  String? createdAt;
  int? minAge;
  String? genre;

  Movies({this.id, this.userId, this.title, this.description, this.createdAt});

  Movies.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    title = json['title'];
    description = json['description'];
    createdAt = json['created_at'];
    minAge = json['min_age'];
    genre = json['genre'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['title'] = title;
    data['description'] = description;
    data['created_at'] = createdAt;
    data['min_age'] = minAge;
    data['genre'] = genre;
    return data;
  }

  static List<Movies> fromJsonList(List? data) {
    if (data == null || data.isEmpty) return [];
    return data.map((e) => Movies.fromJson(e)).toList();
  }
}
