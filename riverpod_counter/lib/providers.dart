import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_counter/fake_websocket.dart';

// final counterProvider = StateProvider.autoDispose((ref) => 0);   

final websocketClientProvider = Provider<WebsocketClient>((ref) {
  return FakeWebsocketClient();
});

// final counterProvider = StreamProvider<int>((ref) {
//   final websocketClient = ref.watch(websocketClientProvider);
//   return websocketClient.getCounterStream();
// });

final counterProvider = StreamProvider.family.autoDispose<int, int>((ref, start) {
  final websocketClient = ref.watch(websocketClientProvider);
  return websocketClient.getCounterStream(start);
});
