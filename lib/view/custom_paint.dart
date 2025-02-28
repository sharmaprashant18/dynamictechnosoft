import 'package:dynamictechnosoft/view/on_boarding_page.dart';
import 'package:flutter/material.dart';

class CustomPaintPage extends StatelessWidget {
  final Widget child;
  const CustomPaintPage({required this.child});
  // Stream<String> getTimeStream() {
  //   return Stream.periodic(const Duration(seconds: 1), (_) {
  //     return DateFormat("h:mm").format(DateTime.now()); // HH:mm:ss format
  //   });
  // }

  // Stream<String> getDateStream() {
  //   return Stream.periodic(const Duration(minutes: 1), (_) {
  //     return DateFormat.yMMMd()
  //         .format(DateTime.now()); // e.g., February 9, 2025
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment(1, 1),
                    colors: [
                  Color(0xffEBD37C),
                  Color(0xffF3979D),
                  Color(0xffF3D1CF),
                  Color(0xffF6CECB),
                  Color(0xffF3979D),
                ])),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 550, right: 48),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // children: [
                //   StreamBuilder<String>(
                //     stream: getDateStream(),
                //     builder: (context, snapshot) {
                //       return Text(
                //         snapshot.data ??
                //             DateFormat('EEEE, d MMMM').format(DateTime.now()),
                //         style: const TextStyle(
                //           color: Colors.white,
                //           fontWeight: FontWeight.bold,
                //           fontSize: 30,
                //         ),
                //       );
                //     },
                //   ),
                //   const SizedBox(height: 10),
                //   StreamBuilder(
                //     stream: getTimeStream(),
                //     builder: (context, snapshot) {
                //       return Text(
                //         snapshot.data ?? DateFormat.Hm().format(DateTime.now()),
                //         style: const TextStyle(
                //           color: Colors.white,
                //           fontWeight: FontWeight.bold,
                //           fontSize: 100,
                //         ),
                //       );
                //     },
                //   )
                // ],
              ),
            ),
          ),
          CustomPaint(
            size: MediaQuery.of(context).size,
            painter: SecondCustomPaintPage(),
          ),
          Container(
            foregroundDecoration: BoxDecoration(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                      elevation: WidgetStatePropertyAll(10),
                      foregroundColor: WidgetStatePropertyAll(Colors.red),
                      backgroundColor: WidgetStatePropertyAll(Colors.blue)),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OnBoardingPage(),
                        ));
                  },
                  child: Text(
                    'Tap to unlock>>>',
                    style: TextStyle(fontSize: 20),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// class SecondCustomPaintPage extends CustomPainter {
//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return false;
//   }

//   @override
//   void paint(Canvas canvas, Size size) {
//     final box1 = Rect.fromLTWH(0, 0, size.width, size.height);
//     final Paint paint = Paint()
//       ..shader = LinearGradient(
//           begin: Alignment.topRight,
//           end: Alignment.bottomLeft,
//           colors: [
//             Color(0xff988A9D).withValues(alpha: 0150),
//             Color(0xffA1878E).withValues(alpha: 150),
//             Color(0xff2B829E).withValues(alpha: 90),
//             Color(0xff34819B),
//             Color(0xff1F7796),
//             Color(0xff042233).withValues(alpha: 10),
//             Color(0xff042233).withValues(alpha: 10),
//           ]).createShader(box1)
//       ..style = PaintingStyle.fill;
//     // Stroke paint
//     final Paint strokePaint = Paint()
//       ..shader = LinearGradient(
//           begin: Alignment.topRight,
//           end: Alignment.bottomLeft,
//           colors: [
//             Color(0xff1F7796),
//             Color(0xff042233),
//             Color(0xff042233),
//           ]).createShader(box1)
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 1.5;

//     final Path path_a = Path()
//       ..moveTo(420, size.height / 8)
//       ..cubicTo(size.width / 6, size.height / 4, 450, 500, -70, size.height)
//       ..lineTo(size.width, size.height)
//       // ..lineTo(size.width, size.height / 6)
//       ..close();

//     canvas.drawPath(path_a, paint);
//     canvas.drawPath(path_a, strokePaint);
//     final box2 = Rect.fromLTWH(0, 0, size.width, size.height);

//     final Paint paints = Paint()
//       ..shader = LinearGradient(
//         begin: Alignment.centerRight,
//         end: Alignment.bottomRight,
//         colors: [
//           Colors.white, // Increased alpha for more visibility
//           const Color.fromARGB(80, 150, 50, 50),
//           const Color.fromARGB(60, 200, 100, 100),
//           const Color.fromARGB(40, 242, 172, 172),
//           Colors.transparent,
//         ],
//       ).createShader(box2)
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 5
//       ..maskFilter = MaskFilter.blur(BlurStyle.inner, 12);

//     final Path path_b = Path()
//       ..moveTo(size.width, size.height / 3.5)
//       ..cubicTo(size.width / 3, size.height / 2, 350, 400, -190, 900);

//     canvas.drawPath(path_b, paints);
//   }
// }

class SecondCustomPaintPage extends CustomPainter {
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final box1 = Rect.fromLTWH(0, 0, size.width, size.height);
    final Paint paint = Paint()
      ..shader = LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            
            const Color(0xff988A9D)
                .withAlpha(150), 
            const Color(0xffA1878E).withAlpha(90),
            const Color(0xff2B829E).withAlpha(90),
            const Color(0xff34819B),
            const Color(0xff1F7796),
           
              const Color(0xff042233),
                  const Color(0xff042233),

          ]).createShader(box1)
      ..style = PaintingStyle.fill;

    final Paint strokePaint = Paint()
      ..shader = LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            const Color(0xff1F7796),
            const Color(0xff042233),
            const Color(0xff042233),
            const Color(0xff042233),
          ]).createShader(box1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.005; 
    final Path path_a = Path()
      ..moveTo(size.width * 1, size.height / 6) 
      ..cubicTo(size.width / 6, size.height / 4, size.width * 0.95,
          size.height * 0.6, -size.width * 0.2, size.height)
      ..lineTo(size.width, size.height)
      ..close();

    canvas.drawPath(path_a, paint);
    canvas.drawPath(path_a, strokePaint);

    final box2 = Rect.fromLTWH(0, 0, size.width, size.height);

    final Paint paints = Paint()
      ..shader = LinearGradient(
        begin: Alignment.centerRight,
        end: Alignment.bottomRight,
        colors: [
          Colors.white,
          const Color.fromARGB(80, 150, 50, 50),
          const Color.fromARGB(60, 200, 100, 100),
          const Color.fromARGB(40, 242, 172, 172),
        ],
      ).createShader(box2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.01 
      ..maskFilter = MaskFilter.blur(
          BlurStyle.inner, size.width * 0.02); 
    final Path path_b = Path()
      ..moveTo(size.width, size.height / 3.5)
      ..cubicTo(size.width / 2, size.height / 2, size.width * 0.75,
          size.height * 0.6, -size.width * 0.4, size.height);

    canvas.drawPath(path_b, paints);
  }
}
