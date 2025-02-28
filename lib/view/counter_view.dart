import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class Counter extends ValueNotifier<int> {
  Counter() : super(0);

  int get counter => value;

  void increment() {
    value++;
  }

  void decrement() {
    value--;
  }

  void setValue(int newValue) {
    value = newValue;
  }
}

class Counters extends StatefulWidget {
  const Counters({super.key});

  @override
  State<Counters> createState() => _CountersState();
}

class _CountersState extends State<Counters> {
  final Counter count = Counter();
  late Box counterBox;
  List counterData = [];

  @override
  void initState() {
    super.initState();
    openBox();
  }

  Future<void> openBox() async {
    counterBox = await Hive.openBox('counterBox');
    loadData();
    // Restore the last counter value
    if (counterBox.containsKey('currentValue')) {
      count.setValue(counterBox.get('currentValue'));
    }
  }

  void loadData() {
    setState(() {
      counterData = counterBox.get('history', defaultValue: []) ?? [];
    });
  }

  void updateCounter(int newValue) {
    // Save current value
    counterBox.put('currentValue', newValue);

    // Update history
    List history = counterBox.get('history', defaultValue: []) ?? [];
    history.add(newValue);
    counterBox.put('history', history);

    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter Page'),
      ),
      body: Column(
        children: [
          Container(
            child: ValueListenableBuilder(
              valueListenable: count,
              builder: (context, value, child) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${count.counter}',
                        style: const TextStyle(fontSize: 70),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                count.increment();
                                updateCounter(count.counter);
                              },
                              child: const Icon(Icons.add)),
                          ElevatedButton(
                              onPressed: () {
                                counterBox.clear();
                                count.setValue(0);
                                loadData();
                              },
                              child: const Icon(Icons.clear)),
                          ElevatedButton(
                              onPressed: () {
                                count.decrement();
                                updateCounter(count.counter);
                              },
                              child: const Icon(Icons.minimize_outlined))
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: counterData.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(counterData[index].toString()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
