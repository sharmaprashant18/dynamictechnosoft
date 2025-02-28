import 'package:dio/dio.dart';
import 'package:dynamictechnosoft/model/quotes_model.dart';

class QuotesServices {
  final Dio dio = Dio();
  Future<List<QuoteModel>> getQuotes() async {
    try {
      final response = await dio.get('https://type.fit/api/quotes');
      if (response.statusCode == 200) {
        final datas = response.data;
        final quotesData =
            (datas as List).map((e) => QuoteModel.formJson(e)).toList();
        return quotesData;
      } else {
        throw Exception('Unable to fetch quotes');
      }
    } catch (e) {
      throw Exception('Error:$e');
    }
  }
}
