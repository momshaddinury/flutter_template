import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'state_management_example.g.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class CounterModel {
  int count = 0;
  bool isEven = false;

  CounterModel copyWith({int? count, bool? isEven}) {
    return CounterModel()
      ..count = count ?? this.count
      ..isEven = isEven ?? this.isEven;
  }
}

@riverpod
class Counter extends _$Counter {
  @override
  CounterModel build() {
    return CounterModel();
  }

  void increment() {
    state = state.copyWith(
      count: state.count + 1,
      isEven: (state.count + 1) % 2 == 0,
    );
  }
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Counter App')),
        body: const Center(
          child: DefaultTextStyle(
            style: TextStyle(
              fontSize: 30,
              color: Colors.black,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _BuildText(),
                // _UnoptimizedBuildText(),
                SizedBox(height: 20),
                _BuildEvenText(),
                // _UnoptimizedBuildEvenText(),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            ref.read(counterProvider.notifier).increment();
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class _BuildText extends ConsumerWidget {
  const _BuildText();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    log('BuildText');
    return Text('${ref.watch(counterProvider.select((value) => value.count))}');
  }
}

class _UnoptimizedBuildText extends ConsumerWidget {
  const _UnoptimizedBuildText();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    log('UnoptimizedBuildText');
    return Text('${ref.watch(counterProvider).count}');
  }
}

class _BuildEvenText extends ConsumerWidget {
  const _BuildEvenText();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    log('BuildEvenText');
    final isEven = ref.watch(counterProvider.select((value) => value.isEven));
    return Text(
      '$isEven',
      style: TextStyle(
        color: isEven ? Colors.green : Colors.red,
      ),
    );
  }
}

class _UnoptimizedBuildEvenText extends ConsumerWidget {
  const _UnoptimizedBuildEvenText();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    log('UnoptimizedBuildEvenText');
    return Text('${ref.watch(counterProvider).isEven}');
  }
}

// buildWhen - Bloc
// select - Rirverpod
// selector - Provider

// Binding -> Controller
// View -> GetView<Controller>
// Get.put
// get.to (Navigator 1.0)
// context.push - go Router
// material.push -> Web -> Desktop (Go Router/ Navigator 2.0)