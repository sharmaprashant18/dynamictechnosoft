class QuoteModel {
  List<Quotes> quotes;
  QuoteModel({required this.quotes});

//Factory constructor
  factory QuoteModel.formJson(Map<String, dynamic> json) {
    return QuoteModel(
      quotes: json['quotes'].map<Quotes>((e) => Quotes.fromJson(e)).toList(),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'quotes': quotes.map((e) => e.toJson()).toList(),
    };
  }

//copyWith method
  QuoteModel copyWith({List<Quotes>? quotes}) {
    return QuoteModel(quotes: quotes ?? this.quotes);
  }
}

class Quotes {
  int id;
  String quote;
  String author;
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
