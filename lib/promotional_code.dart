import 'dart:math';
import 'package:flutter/material.dart';

class PromotionalCode extends StatefulWidget {
  const PromotionalCode({super.key});

  @override
  State<PromotionalCode> createState() => _PromotionalCodeState();
}

class _PromotionalCodeState extends State<PromotionalCode> {
  double _top = 0;
  double _left = 0;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: _top,
      left: _left,
      child: GestureDetector(
        onPanUpdate: (details) {
          _top = min(max(0, _top + details.delta.dy), 227);
          _left = min(max(0, _left + details.delta.dx), 93);
          setState(() {});
        },
        child: SizedBox(
          width: 242,
          height: 108,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset("assets/images/background_pc.png"),
              const RotationTransition(
                turns: AlwaysStoppedAnimation(9/360),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'NWH09',
                      style: TextStyle(
                        height: 1,
                        fontSize: 42,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      'Скидка 20% на первую поездку',
                      style: TextStyle(
                        height: 1,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(width: 5, height: 10,)
                  ]
                )
              )
            ],
          )
        )
      ),
    );
  }
}