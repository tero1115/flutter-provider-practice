import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Counter extends StateNotifier<int> {
  Counter(int num) : super(num);

   void increment(){
     state++;
   }
}

final counterProvider = StateNotifierProvider<Counter, int>((ref) {
  return Counter(0);
});

void main() {
  runApp(
    // 위젯에서 프로바이더를 사용하고 읽기위해
    // 앱 전체적으로 "ProviderScope" 위젯을 감싸줘야 합니다.
    // 여기에 프로바이더의 상태가 저장됩니다.
    ProviderScope(
      child: MyApp(),
    ),
  );
}

// StatelessWidget 대신에 Riverpod의 ConsumerWidget을 상속받아 사용합니다.
class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int value = ref.watch(counterProvider);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Example')),
        body: Center(
          child: Text("$value"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            ref.read(counterProvider.notifier).increment();
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
