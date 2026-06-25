import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/mock_ai_tutor_repository.dart';
import '../../domain/models/chat_message_model.dart';

class AiTutorState {
  final List<ChatMessageModel> messages;
  final bool isSending;

  const AiTutorState({required this.messages, this.isSending = false});

  AiTutorState copyWith({List<ChatMessageModel>? messages, bool? isSending}) {
    return AiTutorState(
      messages: messages ?? this.messages,
      isSending: isSending ?? this.isSending,
    );
  }
}

/// Drives the AI Tutor chat: seeds the initial greeting, appends the
/// user's message immediately, then appends the (mock) AI reply once
/// it resolves. [isSending] gates the input bar and shows the typing
/// indicator while waiting.
class AiTutorController extends StateNotifier<AiTutorState> {
  AiTutorController(this._repository)
      : super(AiTutorState(messages: _repository.getInitialMessages()));

  final MockAiTutorRepository _repository;

  Future<void> sendMessage(String text) async {
    final trimmed = text.trim();
    if (trimmed.isEmpty || state.isSending) return;

    final userMessage = ChatMessageModel(
      id: 'm_${DateTime.now().millisecondsSinceEpoch}',
      sender: MessageSender.user,
      text: trimmed,
      timestamp: DateTime.now(),
    );

    state = state.copyWith(messages: [...state.messages, userMessage], isSending: true);

    final aiReply = await _repository.sendMessage(trimmed);

    state = state.copyWith(messages: [...state.messages, aiReply], isSending: false);
  }
}

final aiTutorControllerProvider =
    StateNotifierProvider.autoDispose<AiTutorController, AiTutorState>((ref) {
  return AiTutorController(ref.watch(mockAiTutorRepositoryProvider));
});