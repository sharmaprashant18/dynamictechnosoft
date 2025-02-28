class QuoteModel {
  List<Quotes> quotes;
  QuoteModel({required this.quotes});
  QuoteModel copyWith({List<Quotes>? quotes}) {
    return QuoteModel(quotes: quotes ?? this.quotes);
  }
}

class Quotes {
  int id;
  String quote;
  String author;
  Quotes({required this.id, required this.quote, required this.author});
  Quotes copyWith({int? id, String? quote, String? author}) {
    return Quotes(
      id: id ?? this.id,
      quote: quote ?? this.quote,
      author: author ?? this.author,
    );
  }
}
