import 'package:church_clicker/extensions/int_extension.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class WinDialog extends StatefulWidget {
  final double v;
  const WinDialog({super.key, required this.v});

  @override
  State<WinDialog> createState() => _WinDialogState();
}

class _WinDialogState extends State<WinDialog>
    with SingleTickerProviderStateMixin {
  final confettiController = ConfettiController();
  late AnimationController animationController;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    scaleAnimation = CurvedAnimation(
        parent: animationController, curve: Curves.elasticInOut);
    animationController.addListener(() {
      setState(() {});
    });
    animationController.forward();
    confettiController.play();
  }

  @override
  void dispose() {
    animationController.dispose();
    confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      ScaleTransition(
        scale: animationController,
        child: Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Text(
            '+ ${widget.v.toInt().toShortenedString()}',
            style: const TextStyle(color: Colors.amber, fontSize: 64),
          ),
        ),
      ),
      Align(
        alignment: Alignment.topCenter,
        child: ConfettiWidget(
          blastDirectionality: BlastDirectionality.explosive,
          confettiController: confettiController,
          colors: const [Colors.amber, Color(0xFFE10032)],
          shouldLoop: true,
          emissionFrequency: 0.1,
          gravity: 0.1,
        ),
      ),
    ]);
  }
}
