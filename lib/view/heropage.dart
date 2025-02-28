import 'package:dynamictechnosoft/view/home_page.dart';
import 'package:flutter/material.dart';

class Heropagefirst extends StatelessWidget {
  const Heropagefirst({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder:(context) {
            return HeropageSecond();
          },));
        },
        child: Hero(tag: 'hero_page', child: Image.asset('assets/loadingpage.png')),
      ),
    );
  }
}
class HeropageSecond extends StatelessWidget {
  const HeropageSecond({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder:(context) {
            return HomePage();
          },));
        },
        child: Hero(tag: 'hero_page', 
        child: Center(child: Text('This is a example of the hero page',maxLines: 20,style: TextStyle(fontWeight: FontWeight.bold),))),
      ),
    );
  }
}