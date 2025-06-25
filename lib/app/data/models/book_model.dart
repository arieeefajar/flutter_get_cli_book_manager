class Book {
  int? id;
  String? name;
  String? author;
  String? createdAt;

  Book({this.id, this.name, this.author, this.createdAt});

  factory Book.fromJson(Map<String, dynamic> json) => Book(
    id: int.tryParse(json['id'].toString()),
    name: json['name'],
    author: json['author'],
    createdAt: json['createdAt'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'author': author,
    'createdAt': createdAt,
  };
}
