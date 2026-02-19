import 'package:flutter/material.dart';
import 'package:w4_practice/1_color_app/color_service.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: Home()),
    ),
  );
}

ColorService colorService = ColorService();

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentIndex == 0 ? ColorTapsScreen() : StatisticsScreen(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.tap_and_play),
            label: 'Taps',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Statistics',
          ),
        ],
      ),
    );
  }
}

class ColorTapsScreen extends StatelessWidget {
  const ColorTapsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: colorService,
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(title: Text('Color Taps')),
          body: ListView.builder(
            itemCount: CardType.values.length,
            itemBuilder: (context, index) {
              final CardType type = CardType.values[index];
              return ColorTap(type: type);
            }
          )
        );
      },
    );
  }
}

class ColorTap extends StatelessWidget {
  final CardType type;

  const ColorTap({super.key, required this.type});

  Color get backgroundColor => type.color;

  @override
  Widget build(BuildContext context) {
    int getTap = colorService.getTapCount(type);
    return GestureDetector(
      onTap: () {
        colorService.increaseTap(type);
      },
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        width: double.infinity,
        height: 100,
        child: Center(
          child: Text(
            'Taps: $getTap',
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: colorService,
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(title: Text('Statistics')),
          body: Center(
            child: ListView.builder(
              itemCount: CardType.values.length,
              itemBuilder: (context, index) {
                final CardType type = CardType.values[index];
                return Center(
                  child: Text(
                    '${type.name.toLowerCase()} Taps: ${colorService.getTapCount(type)}',
                    style: const TextStyle(fontSize: 24),
                  ),
                );
              },
            )
          ),
        );
      }
    );
  }
}
