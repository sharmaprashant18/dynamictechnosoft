import 'package:animate_do/animate_do.dart';
import 'package:dynamictechnosoft/model/quotes_model.dart';
import 'package:dynamictechnosoft/services/quotes_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

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
      this.error = e.toString();
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Quotes',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ).animate(autoPlay: true).shimmer(
            delay: Duration(milliseconds: 500),
            angle: 200,
            curve: Curves.bounceOut,
            duration: Duration(seconds: 10),
            colors: [
              Colors.red,
              Colors.blue,
              Colors.green,
              Colors.yellow,
              Colors.purple,
              Colors.cyan,
              Colors.white,
            ]).bounce(),
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
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: Card(
                    margin: EdgeInsets.only(bottom: 10),
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          end: Alignment.topLeft,
                          begin: Alignment.bottomRight,
                          colors: [
                            Colors.amber.shade50,
                            Colors.green.shade100,
                            Colors.blue.shade100,
                            Colors.green.shade100,
                            Colors.white
                          ],
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.format_quote,
                              color: Colors.cyan,
                              size: 25,
                            ),
                            SizedBox(height: 6),
                            Row(
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    ' ${quotes[index].id.toString()}' + ').',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontStyle: FontStyle.italic,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                Text(
                                  'Quote: ',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              quotes[index].quote,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                                height: 1.4,
                              ),
                            ),
                            SizedBox(height: 10),
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
                  ),
                );
              },
            ),
    );
  }
}
