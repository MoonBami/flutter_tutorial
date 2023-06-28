import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const twentyFiveMinutes = 1500;
  int totalSeconds = twentyFiveMinutes;
  bool isRunning = false;
  late Timer timer;
  int totalPomodoros = 0;

  void onTick(Timer timer) {
    if (totalSeconds == 0) {
      setState(() {
        totalPomodoros += 1;
        isRunning = false;
        totalSeconds = twentyFiveMinutes;
      });
      timer.cancel();
    } else {
      setState(() {
        totalSeconds -= 1;
      });
    }
  }

  void onStartPressed() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      onTick,
    );
    setState(() {
      isRunning = true;
    });
  }

  void onPausePressed() {
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }

  void onRestartPressed() {
    setState(() {
      totalSeconds = twentyFiveMinutes;
      isRunning = false;
    });
    timer.cancel();
  }

  String format(int seconds) {
    var duration = Duration(seconds: seconds);
    return duration.toString().split('.').first.substring(2, 7);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Text(
                format(totalSeconds),
                style: TextStyle(
                  color: Theme.of(context).cardColor,
                  fontSize: 89,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    iconSize: 120,
                    color: Theme.of(context).cardColor,
                    onPressed: isRunning ? onPausePressed : onStartPressed,
                    icon: Icon(isRunning
                        ? Icons.pause_circle_outline_sharp
                        : Icons.play_circle_outline_sharp),
                  ),
                  IconButton(
                    iconSize: 80,
                    color: Theme.of(context).cardColor,
                    onPressed: onRestartPressed,
                    icon: const Icon(Icons.restore_sharp),
                  )
                ],
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Pomodoros",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color:
                                Theme.of(context).textTheme.labelLarge!.color,
                          ),
                        ),
                        Text(
                          "$totalPomodoros",
                          style: TextStyle(
                            fontSize: 58,
                            fontWeight: FontWeight.w600,
                            color:
                                Theme.of(context).textTheme.labelLarge!.color,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
