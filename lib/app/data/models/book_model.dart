class Book {
  int? id;
  String? name;
  String? author;
  String? avatar;
  String? createdAt;

  Book({this.id, this.name, this.author, this.avatar, this.createdAt});

  factory Book.fromJson(Map<String, dynamic> json) => Book(
    id: int.tryParse(json['id'].toString()),
    name: json['name'],
    author: json['author'],
    avatar: json['avatar'],
    createdAt: json['createdAt'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'author': author,
    'avatar': avatar,
    'createdAt': createdAt,
  };
}
