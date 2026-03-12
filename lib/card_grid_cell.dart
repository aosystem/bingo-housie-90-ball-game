import 'dart:async';
import 'package:flutter/material.dart';

import 'package:bingogamehousie/model.dart';

class CardGridCell extends StatefulWidget {
  final bool isOpen;
  final String label;
  final Color background;
  final Color textColor;

  const CardGridCell({
    super.key,
    required this.isOpen,
    required this.label,
    required this.background,
    required this.textColor,
  });

  @override
  State<CardGridCell> createState() => _CardGridCellState();
}

class _CardGridCellState extends State<CardGridCell> {
  double _scale = 1.0;

  @override
  void didUpdateWidget(CardGridCell oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (!oldWidget.isOpen && widget.isOpen) {
      setState(() => _scale = 3);
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          setState(() => _scale = 1.0);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: _scale,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      child: Container(
        decoration: BoxDecoration(
          color: widget.background,
          borderRadius: BorderRadius.circular(6),
        ),
        alignment: Alignment.center,
        child: Text(
          widget.label,
          style: TextStyle(
            fontSize: Model.textSizeCard.toDouble(),
            fontWeight: FontWeight.bold,
            color: widget.textColor,
          ),
        ),
      ),
    );
  }
}
