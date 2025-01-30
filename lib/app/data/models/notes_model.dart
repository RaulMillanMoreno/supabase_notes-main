class Movies {
  int? id;
  int? userId;
  String? title;
  String? description;
  String? createdAt;
  int? minAge;
  String? genre;

  // Constructor de la classe Movies
  Movies({this.id, this.userId, this.title, this.description, this.createdAt});

  // Constructor per convertir un JSON en un objecte Movies
  Movies.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    title = json['title'];
    description = json['description'];
    createdAt = json['created_at'];
    minAge = json['min_age'];
    genre = json['genre'];
  }

  // Mètode per convertir un objecte Movies en un JSON
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

  // Mètode estàtic per convertir una llista de JSON en una llista d'objectes Movies
  static List<Movies> fromJsonList(List? data) {
    if (data == null || data.isEmpty) return [];
    return data.map((e) => Movies.fromJson(e)).toList();
  }
}