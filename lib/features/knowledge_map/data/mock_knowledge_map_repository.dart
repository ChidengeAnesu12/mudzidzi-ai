import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/models/knowledge_node_model.dart';

class MockKnowledgeMapRepository {
  Future<List<KnowledgeNodeModel>> getKnowledgeMap() async {
    await Future.delayed(const Duration(milliseconds: 500));

    return const [
      KnowledgeNodeModel(
        id: 'numbers', title: 'Numbers', status: NodeStatus.completed,
        prerequisiteIds: [], x: 0.5, y: 0.05,
      ),
      KnowledgeNodeModel(
        id: 'fractions', title: 'Fractions', status: NodeStatus.completed,
        prerequisiteIds: ['numbers'], x: 0.5, y: 0.20,
      ),
      KnowledgeNodeModel(
        id: 'algebra', title: 'Algebra', status: NodeStatus.completed,
        prerequisiteIds: ['fractions'], x: 0.5, y: 0.35,
      ),
      KnowledgeNodeModel(
        id: 'linear_equations', title: 'Linear Equations', status: NodeStatus.inProgress,
        prerequisiteIds: ['algebra'], x: 0.28, y: 0.50,
      ),
      KnowledgeNodeModel(
        id: 'geometry', title: 'Geometry', status: NodeStatus.completed,
        prerequisiteIds: ['numbers'], x: 0.72, y: 0.50,
      ),
      KnowledgeNodeModel(
        id: 'functions', title: 'Functions', status: NodeStatus.locked,
        prerequisiteIds: ['linear_equations'], x: 0.28, y: 0.65,
      ),
      KnowledgeNodeModel(
        id: 'trigonometry', title: 'Trigonometry', status: NodeStatus.locked,
        prerequisiteIds: ['geometry'], x: 0.72, y: 0.65,
      ),
      KnowledgeNodeModel(
        id: 'quadratics', title: 'Quadratics', status: NodeStatus.locked,
        prerequisiteIds: ['functions'], x: 0.28, y: 0.80,
      ),
      KnowledgeNodeModel(
        id: 'statistics', title: 'Statistics', status: NodeStatus.inProgress,
        prerequisiteIds: ['numbers'], x: 0.72, y: 0.80,
      ),
    ];
  }
}

final mockKnowledgeMapRepositoryProvider = Provider<MockKnowledgeMapRepository>((ref) {
  return MockKnowledgeMapRepository();
});

final knowledgeMapProvider = FutureProvider<List<KnowledgeNodeModel>>((ref) {
  return ref.watch(mockKnowledgeMapRepositoryProvider).getKnowledgeMap();
});