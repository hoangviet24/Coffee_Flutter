class Product {
  final int id;
  final String name;
  final String path;
  final String title;
  final double money;
  bool isSelected;

  Product({
    required this.id,
    required this.name,
    required this.path,
    required this.title,
    required this.money,
    this.isSelected = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id, // Thêm id vào map
      'name': name,
      'path': path,
      'title': title,
      'money': money,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'], // Thêm id vào constructor
      name: map['name'],
      path: map['path'],
      title: map['title'],
      money: (map['money'] as int).toDouble(),
    );
  }

  Product copyWith({int? id, bool? isSelected}) {
    return Product(
      id: id ?? this.id,
      name: name,
      path: path,
      title: title,
      money: money,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
