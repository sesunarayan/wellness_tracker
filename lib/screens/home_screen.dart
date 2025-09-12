import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../widgets/custom_card.dart';
import 'active_log_screen.dart';
import 'progress_screen.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Hi, ${state.name}"),
        actions: [
          IconButton(
            icon: Icon(state.isDarkMode ? Icons.dark_mode : Icons.light_mode),
            onPressed: () => state.toggleDarkMode(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: CustomCard(
                    title: "Water",
                    image: "water.png",
                    value:
                        "${state.waterGlasses} ${state.waterGlasses > 1 ? 'glasses' : 'glass'}",
                    onIncrement: () =>
                        state.updateToday(water: state.waterGlasses + 1),
                    onDecrement: () {
                      if (state.waterGlasses > 0) {
                        state.updateToday(water: state.waterGlasses - 1);
                      }
                    },
                  ),
                ),
                Expanded(
                  child: CustomCard(
                    title: "Steps",
                    image: "steps.png",
                    color: Colors.red,
                    value: "${state.steps}",
                    onIncrement: () =>
                        state.updateToday(steps: state.steps + 100),
                    onDecrement: () {
                      if (state.steps >= 100) {
                        state.updateToday(steps: state.steps - 100);
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            CustomCard(
              title: "Sleep",
              image: "sleep.png",
              value:
                  "${state.sleepHours.toStringAsFixed(1)} ${state.sleepHours > 1 ? 'hrs' : 'hr'}",
              onIncrement: () =>
                  state.updateToday(sleep: state.sleepHours + 0.5),
              onDecrement: () {
                if (state.sleepHours >= 0.5) {
                  state.updateToday(sleep: state.sleepHours - 0.5);
                }
              },
            ),
            const Spacer(),
            SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.list),
                      label: const Text("Activity Log"),
                      onPressed: () => Navigator.pushNamed(
                        context,
                        ActivityLogScreen.routeName,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.show_chart),
                      label: const Text("Progress"),
                      onPressed: () => Navigator.pushNamed(
                        context,
                        ProgressScreen.routeName,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
