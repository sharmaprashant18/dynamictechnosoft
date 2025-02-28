import 'package:dynamictechnosoft/model/singleton_pattern.dart';
import 'package:flutter/material.dart';

class SingletonPattern extends StatelessWidget {
  SingletonPattern({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: SingleTonExample().books.length,
            itemBuilder: (context, index) {
              final book = SingleTonExample().books[index];
              return InkWell(
                onTap: () {
                  showAdaptiveDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text(book['summary']!),
                      );
                    },
                  );
                },
                child: Card(
                  margin: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        book['imageUrl']!,
                        fit: BoxFit.fitWidth,
                      ),
                      Row(
                        children: [
                          // Text(book['']!),

                          Text(book['name']!),
                          SizedBox(width: 9,),
                          Text(book['rating']!),
                                 SizedBox(width: 9,),

                          Text(book['genre']!)
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        )
      ],
    ));
  }
}
