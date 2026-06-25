enum NodeStatus { completed, inProgress, locked }

class KnowledgeNodeModel {
  final String id;
  final String title;
  final NodeStatus status;
  final List<String> prerequisiteIds;

  /// Normalized layout position (0.0–1.0) so the screen can scale this
  /// to any canvas size when drawing nodes + connecting lines.
  final double x;
  final double y;

  const KnowledgeNodeModel({
    required this.id,
    required this.title,
    required this.status,
    required this.prerequisiteIds,
    required this.x,
    required this.y,
  });
}