import 'package:flutter/material.dart';

class CardData {
  final String cardName;
  final Color cardColor;
  final VoidCallback? callBackHandler;

  CardData({
    required this.cardName,
    required this.cardColor,
    this.callBackHandler,
  });
}
