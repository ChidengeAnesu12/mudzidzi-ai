import 'package:flutter/material.dart';
import '../../shared/models/topic_model.dart';

extension TopicUiX on TopicId {
  IconData get icon {
    switch (this) {
      case TopicId.numbers:
        return Icons.pin_outlined;
      case TopicId.algebra:
        return Icons.functions;
      case TopicId.functions:
        return Icons.show_chart;
      case TopicId.geometry:
        return Icons.change_history_outlined;
      case TopicId.trigonometry:
        return Icons.architecture_outlined;
      case TopicId.statistics:
        return Icons.bar_chart;
    }
  }
}