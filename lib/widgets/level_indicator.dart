import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LevelIndicator extends StatelessWidget {
  final int currentExp;
  final int nextLvlExp;

  const LevelIndicator({
    super.key,
    required this.currentExp,
    required this.nextLvlExp,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
          width: double.infinity,
          height: 60,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
            child: Stack(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Container(
                      width: double.infinity,
                      height: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  child: SizedBox(
                    width: 40,
                    height: 40,
                    child: SvgPicture.asset(
                      'assets/images/svg/general/bar_left.svg',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  child: SizedBox(
                    width: 40,
                    height: 40,
                    child: SvgPicture.asset(
                      'assets/images/svg/general/bar_right.svg',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Positioned(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0),
                      child: Row(
                        children: [
                          AnimatedContainer(
                            height: 10,
                            width: 150,
                            duration: Duration(milliseconds: 300),
                            color: Colors.amber,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
          //  Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 64),
          //   child: Stack(
          //     children: [
          //       Positioned(
          //         top: 2,
          //         child: Container(
          //           color: Colors.white,
          //           width: double.infinity,
          //           padding: EdgeInsets.symmetric(horizontal: 20),
          //           child: Container(
          //             height: 10,
          //             decoration: BoxDecoration(
          //               color: Colors.amber,
          //               borderRadius: BorderRadius.only(
          //                 topRight: Radius.circular(8),
          //                 bottomRight: Radius.circular(8),
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //       Positioned(
          //         left: 0,
          //         top: 0,
          //         child: SizedBox(
          //             width: 20,
          //             height: 20,
          //             child: SvgPicture.asset(
          //                 'assets/images/svg/general/bar_left.svg')),
          //       ),
          //       Positioned(
          //         right: 0,
          //         top: 0,
          //         child: SizedBox(
          //             width: 20,
          //             height: 20,
          //             child: SvgPicture.asset(
          //                 'assets/images/svg/general/bar_right.svg')),
          //       )
          //     ],
          //   ),
          // ),
          ),
    );
  }
}
