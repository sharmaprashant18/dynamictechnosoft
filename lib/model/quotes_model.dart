class Quotes {
  final int id;
  final String quote;
  final String author;
  Quotes({required this.id, required this.quote, required this.author});

//factory constructor
  factory Quotes.fromJson(Map<String, dynamic> json) {
    return Quotes(
      id: json['id'],
      quote: json['quote'],
      author: json['author'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'quote': quote,
      'author': author,
    };
  }

//copyWith method
  Quotes copyWith({int? id, String? quote, String? author}) {
    return Quotes(
      id: id ?? this.id,
      quote: quote ?? this.quote,
      author: author ?? this.author,
    );
  }
}
