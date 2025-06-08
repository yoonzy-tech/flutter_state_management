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

// Provider to manage the start value for the counter
final startValueProvider = StateProvider<int>((ref) => 0);

// failmy.autoDispose: this will auto dispose the provider when the widget is disposed
final counterProvider = StreamProvider.family<int, int>((
  ref,
  start,
) {
  final websocketClient = ref.watch(websocketClientProvider);
  return websocketClient.getCounterStream(start);
});
