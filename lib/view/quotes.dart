import 'package:dynamictechnosoft/model/quotes_model.dart';
import 'package:dynamictechnosoft/services/quotes_services.dart';
import 'package:flutter/material.dart';

class QuotesScreen extends StatefulWidget {
  const QuotesScreen({super.key});

  @override
  State<QuotesScreen> createState() => _QuotesScreenState();
}

class _QuotesScreenState extends State<QuotesScreen> {
  final QuotesServices quotesServices = QuotesServices();
  List<Quotes> quotes = [];
  bool isLoading = true;
  String error = '';
  @override
  void initState() {
    super.initState();
    fetchQuotes();
  }

  Future<void> fetchQuotes() async {
    try {
      final fetchedQuotes = await quotesServices.getQuotes();
      setState(() {
        quotes = fetchedQuotes;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Quotes',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueGrey.shade100,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                isLoading = true;
              });
              quotesServices.getQuotes().then((value) {
                setState(() {
                  quotes = value;
                  isLoading = false;
                });
              });
            },
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: quotes.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.only(bottom: 20.0),
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.red.shade200,
                          Colors.amber.shade50,
                          Colors.green.shade100,
                          Colors.blue.shade100,
                          Colors.purple.shade100
                        ],
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Quote mark icon
                          Icon(
                            Icons.format_quote,
                            color: Colors.cyan,
                            size: 32.0,
                          ),
                          SizedBox(height: 16.0),
                          // Quote text
                          Text(
                            quotes[index].quote,
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                              letterSpacing: 0.5,
                              height: 1.4,
                            ),
                          ),
                          SizedBox(height: 16.0),
                          // Author
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              '- ${quotes[index].author}',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontStyle: FontStyle.italic,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
