// ignore_for_file: file_names

class Product {
  final String name;
  final String path;
  final String title;
  final double money;

  Product(
      {required this.name,
      required this.path,
      required this.title,
      required this.money});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'path': path,
      'title': title,
      'money': money,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      name: map['name'],
      path: map['path'],
      title: map['title'],
      money: map['money'],
    );
  }
}
