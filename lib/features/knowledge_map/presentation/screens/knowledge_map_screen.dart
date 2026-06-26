import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/async_value_widget.dart';
import '../../../../core/widgets/badge_chip.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/responsive_center.dart';
import '../../../../shared/models/topic_model.dart';
import '../../data/mock_knowledge_map_repository.dart';
import '../../domain/models/knowledge_node_model.dart';
import '../widgets/knowledge_map_canvas.dart';
import '../widgets/status_legend.dart';

class KnowledgeMapScreen extends ConsumerWidget {
  const KnowledgeMapScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapAsync = ref.watch(knowledgeMapProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Knowledge Map')),
      body: SafeArea(
        child: AsyncValueWidget<List<KnowledgeNodeModel>>(
          value: mapAsync,
          onRetry: () => ref.invalidate(knowledgeMapProvider),
          data: (nodes) => Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                child: KnowledgeMapLegend(),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: ResponsiveCenter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: KnowledgeMapCanvas(
                        nodes: nodes,
                        onNodeTap: (node) => _showNodeDetailsSheet(context, node, nodes),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String? _findTitle(List<KnowledgeNodeModel> nodes, String id) {
  for (final n in nodes) {
    if (n.id == id) return n.title;
  }
  return null;
}

/// Best-effort mapping from a Knowledge Map node to the TopicId enum
/// used by the Learning Session screen. Some nodes (e.g. "Fractions")
/// are sub-topics that roll up into a broader TopicId.
TopicId? _mapNodeIdToTopic(String nodeId) {
  switch (nodeId) {
    case 'numbers':
    case 'fractions':
      return TopicId.numbers;
    case 'algebra':
    case 'linear_equations':
      return TopicId.algebra;
    case 'functions':
    case 'quadratics':
      return TopicId.functions;
    case 'geometry':
      return TopicId.geometry;
    case 'trigonometry':
      return TopicId.trigonometry;
    case 'statistics':
      return TopicId.statistics;
    default:
      return null;
  }
}

String _statusLabel(NodeStatus status) {
  switch (status) {
    case NodeStatus.completed:
      return 'Completed';
    case NodeStatus.inProgress:
      return 'In Progress';
    case NodeStatus.locked:
      return 'Locked';
  }
}

AppBadgeTone _statusTone(NodeStatus status) {
  switch (status) {
    case NodeStatus.completed:
      return AppBadgeTone.success;
    case NodeStatus.inProgress:
      return AppBadgeTone.info;
    case NodeStatus.locked:
      return AppBadgeTone.neutral;
  }
}

void _showNodeDetailsSheet(
  BuildContext context,
  KnowledgeNodeModel node,
  List<KnowledgeNodeModel> allNodes,
) {
  final prereqTitles = node.prerequisiteIds
      .map((id) => _findTitle(allNodes, id))
      .whereType<String>()
      .toList();

  showModalBottomSheet(
    context: context,
    showDragHandle: true,
    builder: (sheetContext) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              node.title,
              style: AppTextStyles.headlineMedium(
                color: Theme.of(sheetContext).textTheme.headlineMedium?.color,
              ),
            ),
            const SizedBox(height: 10),
            AppBadgeChip(label: _statusLabel(node.status), tone: _statusTone(node.status)),
            const SizedBox(height: 18),
            if (node.status == NodeStatus.locked)
              Text(
                prereqTitles.isEmpty
                    ? 'Complete earlier topics first to unlock this.'
                    : 'Complete ${prereqTitles.join(' and ')} first to unlock this topic.',
                style: AppTextStyles.bodyMedium(
                  color: Theme.of(sheetContext).textTheme.bodyMedium?.color,
                ),
              )
            else
              PrimaryButton(
                label: node.status == NodeStatus.completed ? 'Review Topic' : 'Continue Topic',
                onPressed: () {
                  Navigator.of(sheetContext).pop();
                  final topicId = _mapNodeIdToTopic(node.id);
                  if (topicId != null) {
                    context.pushNamed(RouteNames.learningSession, extra: topicId);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Practice content for this topic is coming soon.'),
                      ),
                    );
                  }
                },
              ),
          ],
        ),
      );
    },
  );
}