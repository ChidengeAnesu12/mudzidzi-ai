import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/models/knowledge_node_model.dart';

/// Fixed virtual canvas height the normalized (0.0–1.0) node `y`
/// coordinates are scaled against. Tall enough to comfortably fit the
/// full prerequisite chain with breathing room above/below.
const double knowledgeMapCanvasHeight = 720;

/// Renders the full node graph: connecting lines drawn first (so nodes
/// sit on top), then each node positioned absolutely from its
/// normalized x/y coordinates.
class KnowledgeMapCanvas extends StatelessWidget {
  const KnowledgeMapCanvas({
    super.key,
    required this.nodes,
    required this.onNodeTap,
  });

  final List<KnowledgeNodeModel> nodes;
  final void Function(KnowledgeNodeModel node) onNodeTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final unlockedColor = AppColors.primary.withValues(alpha: 0.5);
    final lockedColor = isDark ? AppColors.darkBorder : AppColors.lightBorder;

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        return SizedBox(
          width: width,
          height: knowledgeMapCanvasHeight,
          child: Stack(
            children: [
              Positioned.fill(
                child: CustomPaint(
                  painter: _KnowledgeMapEdgePainter(
                    nodes: nodes,
                    unlockedColor: unlockedColor,
                    lockedColor: lockedColor,
                  ),
                ),
              ),
              for (final node in nodes)
                Positioned(
                  left: node.x * width - 45,
                  top: node.y * knowledgeMapCanvasHeight - _KnowledgeNodeWidget.circleSize / 2,
                  width: 90,
                  child: _KnowledgeNodeWidget(node: node, onTap: () => onNodeTap(node)),
                ),
            ],
          ),
        );
      },
    );
  }
}

class _KnowledgeMapEdgePainter extends CustomPainter {
  _KnowledgeMapEdgePainter({
    required this.nodes,
    required this.unlockedColor,
    required this.lockedColor,
  });

  final List<KnowledgeNodeModel> nodes;
  final Color unlockedColor;
  final Color lockedColor;

  @override
  void paint(Canvas canvas, Size size) {
    final nodeById = {for (final n in nodes) n.id: n};

    for (final node in nodes) {
      final to = Offset(node.x * size.width, node.y * size.height);
      for (final prereqId in node.prerequisiteIds) {
        final prereq = nodeById[prereqId];
        if (prereq == null) continue;
        final from = Offset(prereq.x * size.width, prereq.y * size.height);
        final isUnlocked = node.status != NodeStatus.locked;

        final paint = Paint()
          ..color = isUnlocked ? unlockedColor : lockedColor
          ..strokeWidth = 2.4
          ..style = PaintingStyle.stroke;

        if (isUnlocked) {
          canvas.drawLine(from, to, paint);
        } else {
          _drawDashedLine(canvas, from, to, paint);
        }
      }
    }
  }

  void _drawDashedLine(Canvas canvas, Offset start, Offset end, Paint paint) {
    const dashWidth = 6.0;
    const dashSpace = 5.0;
    final totalDistance = (end - start).distance;
    if (totalDistance == 0) return;

    final direction = (end - start) / totalDistance;
    final dashCount = (totalDistance / (dashWidth + dashSpace)).floor();

    var current = start;
    for (var i = 0; i < dashCount; i++) {
      final dashEnd = current + direction * dashWidth;
      canvas.drawLine(current, dashEnd, paint);
      current = dashEnd + direction * dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant _KnowledgeMapEdgePainter oldDelegate) {
    return oldDelegate.nodes != nodes;
  }
}

class _KnowledgeNodeWidget extends StatelessWidget {
  const _KnowledgeNodeWidget({required this.node, required this.onTap});

  final KnowledgeNodeModel node;
  final VoidCallback onTap;

  static const double circleSize = 64;

  IconData get _icon {
    switch (node.status) {
      case NodeStatus.completed:
        return Icons.check;
      case NodeStatus.inProgress:
        return Icons.play_arrow_rounded;
      case NodeStatus.locked:
        return Icons.lock_outline;
    }
  }

  Color _borderColor(bool isDark) {
    switch (node.status) {
      case NodeStatus.completed:
        return AppColors.success;
      case NodeStatus.inProgress:
        return AppColors.primary;
      case NodeStatus.locked:
        return isDark ? AppColors.darkBorder : AppColors.lightBorder;
    }
  }

  Color _iconColor(bool isDark) {
    switch (node.status) {
      case NodeStatus.completed:
        return AppColors.success;
      case NodeStatus.inProgress:
        return AppColors.primary;
      case NodeStatus.locked:
        return isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;
    }
  }

  Color _bgColor(bool isDark) {
    switch (node.status) {
      case NodeStatus.completed:
        return AppColors.success.withValues(alpha: 0.15);
      case NodeStatus.inProgress:
        return AppColors.primary.withValues(alpha: 0.15);
      case NodeStatus.locked:
        return isDark ? AppColors.darkCard : AppColors.lightBackground;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = Theme.of(context).textTheme.bodyMedium?.color;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: circleSize,
            height: circleSize,
            decoration: BoxDecoration(
              color: _bgColor(isDark),
              shape: BoxShape.circle,
              border: Border.all(color: _borderColor(isDark), width: 2),
            ),
            child: Icon(_icon, color: _iconColor(isDark), size: 26),
          ),
          const SizedBox(height: 6),
          Text(
            node.title,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.labelMedium(color: textColor),
          ),
        ],
      ),
    );
  }
}