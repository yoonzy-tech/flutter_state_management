import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_counter/providers.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Riverpod Counter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Home'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Go to Counter'),
          onPressed: () {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (context) => CounterPage()));
          },
        ),
      ),
    );
  }
}

class CounterPage extends ConsumerWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController controller = TextEditingController();
    final startValue = ref.watch(startValueProvider);
    final AsyncValue<int> counter = ref.watch(counterProvider(startValue));

    // ref.listen(counterProvider, (previous, next) {
    //   if (next >= 5) {
    //     showDialog(
    //       context: context,
    //       builder: (context) {
    //         return AlertDialog(
    //           title: Text('Warning'),
    //           content: Text('Counter dangerously high. Consider resetting it.'),
    //           actions: [TextButton(onPressed: () {}, child: Text('OK'))],
    //         );
    //       },
    //     );
    //   }
    // });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Riverpod Counter'),
        actions: [
          // IconButton(
          //   onPressed: () => ref.invalidate(counterProvider),
          //   icon: const Icon(Icons.refresh),
          // ),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Reset Counter'),
                    content: TextField(
                      controller: controller,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: 'Enter starting counter value',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          final value = int.tryParse(controller.text);
                          if (value != null) {
                            ref.read(startValueProvider.notifier).state = value;
                            controller.clear();
                          }
                          Navigator.of(context).pop();
                        },
                        child: const Text('Start'),
                      ),
                    ],
                  );
                },
              );
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              counter
                  .when(
                    data: (int data) => data.toString(),
                    error:
                        (Object error, StackTrace stackTrace) =>
                            error.toString(),
                    loading: () => const CircularProgressIndicator(),
                  )
                  .toString(),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => ref.read(counterProvider.notifier).state++,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
