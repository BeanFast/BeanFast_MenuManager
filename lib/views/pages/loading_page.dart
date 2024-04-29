import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingView extends StatelessWidget {
  final Future<dynamic> Function() future;
  final Widget child;

  const LoadingView({super.key, required this.future, required this.child});

  @override
  Widget build(BuildContext context) {
    //double progress = 1;
    return FutureBuilder(
      future: future(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Lottie.asset(
              '/images/loading.json',
              width: 150,
              height: 150,
              fit: BoxFit.contain,
            ),
          );
          //   Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Container(
          //         margin: const EdgeInsets.only(bottom: 100),
          //         child: Column(
          //           children: [
          //             Container(
          //               decoration: const BoxDecoration(
          //                 shape: BoxShape.circle,
          //               ),
          //               child: const Icon(
          //                 Icons.check_circle,
          //                 size: 100,
          //                 color: Colors.white,
          //               ),
          //             ),
          //             const SizedBox(height: 20),
          //             const SizedBox(
          //               child: Text(
          //                 'Lịch sử giao dịch',
          //                 style: TextStyle(fontSize: 16, color: Colors.white),
          //               ),
          //             )
          //           ],
          //         ),
          //       ),
          //       Stack(
          //         children: [
          //           Container(
          //             alignment: Alignment.center,
          //             height: 20,
          //             width: Get.width * 0.7,
          //             decoration: BoxDecoration(
          //               gradient: const LinearGradient(
          //                 colors: [Colors.grey, Colors.white],
          //                 begin: Alignment.centerLeft,
          //                 end: Alignment.centerRight,
          //               ),
          //               borderRadius: BorderRadius.circular(10),
          //             ),
          //           ),
          //           Container(
          //             alignment: Alignment.center,
          //             height: 20,
          //             width: Get.width * 0.7 * progress,
          //             decoration: BoxDecoration(
          //               gradient: const LinearGradient(
          //                 colors: [Colors.pink, Colors.white, Colors.purple],
          //                 begin: Alignment.centerLeft,
          //                 end: Alignment.centerRight,
          //               ),
          //               borderRadius: BorderRadius.circular(10),
          //             ),
          //           ),
          //           Positioned(
          //             left: (progress == 0
          //                     ? progress - 0.0001
          //                     : (progress == 1
          //                         ? progress - 0.07
          //                         : progress - 0.06)) *
          //                 (MediaQuery.of(context).size.width * 0.7),
          //             top: 0,
          //             bottom: 0,
          //             child: Container(
          //               width: 20,
          //               height: 20,
          //               decoration: BoxDecoration(
          //                 color: Colors.pink.shade200,
          //                 shape: BoxShape.circle,
          //                 border: Border.all(
          //                   color: Colors.red,
          //                   width: 4,
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ],
          //       )
          //     ],
          //   ),
        } else if (snapshot.hasError) {
          // return Center(child: Text('Error: ${snapshot.error}', style: TextStyle(color: Colors.blue),));
          return Center(
              child: Text(
            'Error: ${snapshot.error}',
            style: const TextStyle(color: Colors.blue),
          ));
        } else {
          return child; // Return empty container when the data is loaded
        }
      },
    );
  }
}
