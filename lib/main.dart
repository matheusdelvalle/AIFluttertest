import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pregnancy Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const DateInputPage(),
    );
  }
}

class DateInputPage extends StatefulWidget {
  const DateInputPage({super.key});

  @override
  State<DateInputPage> createState() => _DateInputPageState();
}

class _DateInputPageState extends State<DateInputPage> {
  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      helpText: 'Select the date of your last period',
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void _navigateToResults() {
    if (selectedDate != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultsPage(lastPeriodDate: selectedDate!),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Pregnancy Calculator'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'When was your last period?',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => _selectDate(context),
              child: Text(
                selectedDate == null
                    ? 'Select Date'
                    : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                style: const TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: selectedDate != null ? _navigateToResults : null,
              child: const Text(
                'Ready',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ResultsPage extends StatelessWidget {
  final DateTime lastPeriodDate;

  const ResultsPage({super.key, required this.lastPeriodDate});

  String _getBabySize(int weeks) {
    if (weeks < 4) return "Poppy seed (1-2mm)";
    if (weeks < 5) return "Sesame seed (2-3mm)";
    if (weeks < 6) return "Lentil (4-5mm)";
    if (weeks < 7) return "Blueberry (7-9mm)";
    if (weeks < 8) return "Kidney bean (1.6cm)";
    if (weeks < 9) return "Grape (2.3cm)";
    if (weeks < 10) return "Cherry (2.5cm)";
    if (weeks < 11) return "Strawberry (3.1cm)";
    if (weeks < 12) return "Lime (4.1cm)";
    if (weeks < 13) return "Peach (5.4cm)";
    if (weeks < 14) return "Lemon (7.4cm)";
    if (weeks < 15) return "Apple (8.7cm)";
    if (weeks < 16) return "Avocado (10.1cm)";
    if (weeks < 17) return "Turnip (11.6cm)";
    if (weeks < 18) return "Bell pepper (12.5cm)";
    if (weeks < 19) return "Tomato (14.2cm)";
    if (weeks < 20) return "Banana (15.3cm)";
    if (weeks < 21) return "Carrot (16.4cm)";
    if (weeks < 22) return "Spaghetti squash (17.2cm)";
    if (weeks < 23) return "Large mango (19.0cm)";
    if (weeks < 24) return "Corn (20.3cm)";
    if (weeks < 25) return "Rutabaga (21.8cm)";
    if (weeks < 26) return "Scallion (23.0cm)";
    if (weeks < 27) return "Cauliflower (24.0cm)";
    if (weeks < 28) return "Eggplant (25.4cm)";
    if (weeks < 29) return "Butternut squash (26.7cm)";
    if (weeks < 30) return "Cabbage (27.9cm)";
    if (weeks < 31) return "Coconut (29.2cm)";
    if (weeks < 32) return "Jicama (30.5cm)";
    if (weeks < 33) return "Pineapple (31.8cm)";
    if (weeks < 34) return "Cantaloupe (33.0cm)";
    if (weeks < 35) return "Honeydew melon (34.3cm)";
    if (weeks < 36) return "Romaine lettuce (35.6cm)";
    if (weeks < 37) return "Swiss chard (36.8cm)";
    if (weeks < 38) return "Leek (38.1cm)";
    if (weeks < 39) return "Mini watermelon (39.4cm)";
    if (weeks < 40) return "Pumpkin (40.6cm)";
    return "Watermelon (41.9cm)";
  }

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final int daysSinceLastPeriod = now.difference(lastPeriodDate).inDays;
    final int weeks = daysSinceLastPeriod ~/ 7;
    final int days = daysSinceLastPeriod % 7;
    final DateTime expectedDueDate = lastPeriodDate.add(const Duration(days: 280));
    final String babySize = _getBabySize(weeks);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Pregnancy Results'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Pregnancy Information',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            Card(
              margin: const EdgeInsets.all(20),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      'You are $weeks weeks and $days days pregnant',
                      style: const TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Expected due date:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${expectedDueDate.day}/${expectedDueDate.month}/${expectedDueDate.year}',
                      style: const TextStyle(fontSize: 24, color: Colors.blue),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Baby size:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      babySize,
                      style: const TextStyle(fontSize: 20, color: Colors.green),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Back',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
