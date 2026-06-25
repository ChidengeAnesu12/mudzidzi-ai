import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/models/chat_message_model.dart';

class MockAiTutorRepository {
  List<ChatMessageModel> getInitialMessages() {
    final now = DateTime.now();
    return [
      ChatMessageModel(
        id: 'm1',
        sender: MessageSender.ai,
        text: "Hi Anesu 👋\nAsk me anything about maths. I'm here to help you understand and improve.",
        timestamp: now,
      ),
    ];
  }

  /// Simulates an AI response. Real implementation will call an LLM API later.
  Future<ChatMessageModel> sendMessage(String userText) async {
    await Future.delayed(const Duration(milliseconds: 900));
    return ChatMessageModel(
      id: 'm_${DateTime.now().millisecondsSinceEpoch}',
      sender: MessageSender.ai,
      text: 'Great question! We divide by x because we want to isolate x on '
          'one side of the equation. This is allowed as long as x ≠ 0. '
          'It helps us find the value of x.',
      timestamp: DateTime.now(),
    );
  }
}

final mockAiTutorRepositoryProvider = Provider<MockAiTutorRepository>((ref) {
  return MockAiTutorRepository();
});