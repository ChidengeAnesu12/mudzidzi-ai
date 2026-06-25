import 'package:flutter/material.dart';
import '../../shared/models/topic_model.dart';
import 'app_colors.dart';

extension TopicUiX on TopicId {
  Color get color {
    switch (this) {
      case TopicId.numbers:
        return AppColors.topicNumbers;
      case TopicId.algebra:
        return AppColors.topicAlgebra;
      case TopicId.functions:
        return AppColors.topicFunctions;
      case TopicId.geometry:
        return AppColors.topicGeometry;
      case TopicId.trigonometry:
        return AppColors.topicTrigonometry;
      case TopicId.statistics:
        return AppColors.topicStatistics;
    }
  }

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