
abstract class WebsocketClient {
  Stream<int> getCounterStream(int start);
}

class FakeWebsocketClient implements WebsocketClient {
  @override
  Stream<int> getCounterStream(int start) async* {
    int i = start;
    while (true) {
      await Future.delayed(const Duration(milliseconds: 500));
      yield i++;
    }
  }
}