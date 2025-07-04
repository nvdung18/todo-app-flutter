import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/context_extension.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class FocusPage extends StatefulWidget {
  const FocusPage({super.key});

  @override
  State<FocusPage> createState() => _FocusPageState();
}

class _FocusTimeData {
  _FocusTimeData(this.day, this.focusTime);

  final String day;
  final double focusTime;
}

class _FocusPageState extends State<FocusPage> {
  static const int totalSeconds = 25 * 60; // 25 phút
  int secondsLeft = totalSeconds;
  Timer? _timer;
  bool isRunning = false;
  int? selectedBarIndex;

  void startTimer() {
    if (isRunning) return;
    setState(() => isRunning = true);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsLeft > 0) {
        setState(() => secondsLeft--);
      } else {
        timer.cancel();
        setState(() => isRunning = false);
      }
    });
  }

  void stopTimer() {
    if (!isRunning) return;
    setState(() => isRunning = false);
    _timer?.cancel();
  }

  void resetTimer() {
    stopTimer();
    setState(() => secondsLeft = totalSeconds);
  }

  void incrementTimer() {
    setState(() {
      secondsLeft += (25 * 60);
    });
  }

  void decrementTimer() {
    setState(() {
      secondsLeft -= (25 * 60);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<_FocusTimeData> data = [
      _FocusTimeData('Sun', 2.5),
      _FocusTimeData('Mon', 2.5),
      _FocusTimeData('Tue', 3.0),
      _FocusTimeData('Wed', 1.5),
      _FocusTimeData('Thu', 4.0),
      _FocusTimeData('Fri', 2.0),
      _FocusTimeData('Sat', 2.0),
    ];
    double progress = secondsLeft / totalSeconds;
    final int hours = secondsLeft ~/ 3600;
    final int minutes = (secondsLeft % 3600) ~/ 60;
    final int seconds = secondsLeft % 60;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacer(flex: 2),
                Flexible(
                  flex: 6,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 240,
                        height: 240,
                        child: Transform.rotate(
                          angle: 0, // Để progress bắt đầu từ trên
                          child: CircularProgressIndicator(
                            value: progress,
                            strokeWidth: 12,
                            backgroundColor: Colors.grey[300],
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.blue,
                            ),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
                            style: const TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 2),
                          const Text('hours : min : sec'),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () => isRunning
                            ? context.showErrorSnackBar(
                                'You have to stop focus mode to change the time',
                              )
                            : incrementTimer(),
                        icon: Icon(Icons.arrow_circle_up),
                      ),
                      const SizedBox(height: 10),
                      IconButton(
                        onPressed: () => isRunning
                            ? context.showErrorSnackBar(
                                'You have to stop focus mode to change the time',
                              )
                            : secondsLeft <= (25 * 60)
                            ? context.showErrorSnackBar(
                                'You cannot decrease the time below 25 minutes',
                              )
                            : decrementTimer(),
                        icon: Icon(Icons.arrow_circle_down),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Text(
                  'While your focus mode is on, all of your notifications will be off',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: isRunning ? stopTimer : startTimer,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                isRunning ? 'Stop Focus' : 'Start Focus',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: resetTimer,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Reset Focus',
                style: const TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(255, 52, 160, 249),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Overview',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  DropdownButton(
                    value: '1',
                    items: <DropdownMenuItem<String>>[
                      DropdownMenuItem(value: '1', child: Text('This week')),
                      DropdownMenuItem(value: '2', child: Text('Last week')),
                    ],
                    onChanged: (value) {},
                  ),
                ],
              ),
            ),
            SfCartesianChart(
              primaryXAxis: CategoryAxis(title: AxisTitle(text: '')),
              primaryYAxis: NumericAxis(
                title: AxisTitle(text: ''),
                axisLabelFormatter: (AxisLabelRenderDetails details) {
                  return ChartAxisLabel('${details.text}h', TextStyle());
                },
              ),
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <CartesianSeries<_FocusTimeData, String>>[
                ColumnSeries<_FocusTimeData, String>(
                  dataSource: data,
                  xValueMapper: (datum, _) => datum.day,
                  yValueMapper: (datum, _) => datum.focusTime,
                  pointColorMapper: (datum, idx) =>
                      selectedBarIndex == idx ? Colors.orange : Colors.blue,
                  dataLabelSettings: DataLabelSettings(isVisible: true),
                  dataLabelMapper: (datum, _) => '${datum.focusTime}h',
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(4),
                    bottom: Radius.circular(4),
                  ),
                  onPointTap: (ChartPointDetails details) {
                    setState(() {
                      if (selectedBarIndex == details.pointIndex) {
                        selectedBarIndex = null; // Deselect if already selected
                      } else {
                        selectedBarIndex = details.pointIndex;
                      }
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
