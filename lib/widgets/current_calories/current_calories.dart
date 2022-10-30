import 'package:calorie_diff/health/health_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'data_card.dart';

class CurrentCalories extends ConsumerWidget {
  const CurrentCalories({Key? key}) : super(key: key);

  @override
  Widget build(context, ref) {
    final healthData = ref.watch(healthDataProvider);

    return healthData.when(
      data: (data) {
        final burned = data.active + data.rest;
        final dietary = data.dietary;
        final diff = burned - dietary;

        return Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: DataCard(
                    icon: const Icon(
                      Icons.run_circle_outlined,
                      color: Colors.orange,
                      size: 36,
                    ),
                    label: "Burned",
                    data: burned,
                  ),
                ),
                Expanded(
                  child: DataCard(
                    icon: const Icon(
                      Icons.fastfood_outlined,
                      color: Colors.lightGreen,
                      size: 26,
                    ),
                    label: "Consumed",
                    data: dietary,
                  ),
                )
              ],
            ),
            const SizedBox(height: 16),
            DataCard(
              icon: const Icon(
                Icons.difference_outlined,
                color: Colors.lightBlueAccent,
                size: 26,
              ),
              label: "Difference",
              data: diff,
            ),
          ],
        );
      },
      error: (e, s) => const SizedBox.shrink(key: Key("error")),
      loading: () => const CircularProgressIndicator(),
    );
  }
}
