class Postit {
  final int? id;
  final String title;
  final String description;
  final String date;

  Postit({
    this.id,
    required this.title,
    required this.description,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date,
    };
  }

  factory Postit.fromMap(Map<String, dynamic> map) {
    return Postit(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      date: map['date'],
    );
  }
}
