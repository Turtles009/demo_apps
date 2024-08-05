import 'package:demo_app/helper/time_helper.dart';
import 'package:demo_app/theme/theme.dart';
import 'package:demo_app/widgets/decorated_container.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class WorkingHourChart extends StatefulWidget {
  const WorkingHourChart({super.key, required this.hours});
  final List<double> hours;

  @override
  State<WorkingHourChart> createState() => _WorkingHourChartState();
}

class _WorkingHourChartState extends State<WorkingHourChart> {
  late int _selectedBarIndex;
  late List<double> _weeklyData;
  String _viewType = 'Weekly'; // Default view type

  @override
  void initState() {
    super.initState();
    _weeklyData = widget.hours;
    _selectedBarIndex = DateTime.now().weekday;
    // print(DateTime.now().weekday);
  }

  void _onBarTapped(int index) {
    setState(() {
      _selectedBarIndex = index;
    });
  }

  void _onViewTypeChanged(String viewType) {
    setState(() {
      _viewType = viewType;
      _weeklyData =
          viewType == 'Weekly' ? widget.hours : [30.0, 25.0, 28.0, 27.0];
      _selectedBarIndex = viewType == 'Weekly'
          ? DateTime.now().weekday
          : DateTime.now().day ~/ 7;
    });
  }

  void _showViewTypeMenu(BuildContext context) {
    showMenu<String>(
      context: context,
      position: const RelativeRect.fromLTRB(100, 100, 0, 0),
      items: [
        const PopupMenuItem<String>(
          value: 'Weekly',
          child: Text('Weekly'),
        ),
        const PopupMenuItem<String>(
          value: 'Monthly',
          child: Text('Monthly'),
        ),
      ],
    ).then((String? result) {
      if (result != null) {
        _onViewTypeChanged(result);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedContainer(
      titleRow: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            _viewType == 'Weekly' ? 'Working Hours' : 'Monthly Working Hours',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          GestureDetector(
            onTap: () => _showViewTypeMenu(context),
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.black26,
                  ),
                ),
              ),
              child: const Row(
                children: [
                  Text(
                    'Today',
                    style: TextStyle(
                      color: Colors.black45,
                    ),
                  ),
                  SizedBox(width: 12),
                  Icon(
                    Icons.calendar_month_outlined,
                    color: Colors.black45,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      child: Column(
        children: [
          _weeklyData.isNotEmpty
              ? Column(
                  children: [
                    Text(
                      _weeklyData[_selectedBarIndex].convertToHoursAndMinutes(),
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _viewType == 'Weekly' ? 'Today' : 'This Week',
                      style: const TextStyle(color: Colors.black45),
                    )
                  ],
                )
              : const SizedBox(),
          const SizedBox(height: 20),
          Expanded(
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceBetween,
                gridData: FlGridData(
                  drawVerticalLine: false,
                  checkToShowHorizontalLine: (value) {
                    return value % 2 == 0;
                  },
                ),
                barGroups: _weeklyData.asMap().entries.map((entry) {
                  int index = entry.key;
                  double value = entry.value;
                  return BarChartGroupData(
                    x: index,
                    barRods: [
                      BarChartRodData(
                        toY: value,
                        color: index == _selectedBarIndex
                            ? color
                            : const Color.fromARGB(155, 144, 202, 249),
                        width: 20,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4),
                          topRight: Radius.circular(4),
                        ),
                      ),
                    ],
                  );
                }).toList(),
                barTouchData: BarTouchData(
                  touchCallback: (touchEvent, response) {
                    if (response != null && response.spot != null) {
                      _onBarTapped(response.spot!.touchedBarGroupIndex);
                    }
                  },
                  touchTooltipData: BarTouchTooltipData(
                    tooltipPadding: EdgeInsets.zero,
                    getTooltipItem: (group, groupIndex, rod, rodIndex) =>
                        BarTooltipItem(
                      ' ${rod.toY.convertToHoursAndMinutes()} ',
                      const TextStyle(
                        color: Colors.white54,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                titlesData: FlTitlesData(
                  leftTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, titleMeta) {
                        // print(value);
                        switch (_viewType) {
                          case 'Weekly':
                            const weekDays = [
                              'Sun',
                              'Mon',
                              'Tue',
                              'Wed',
                              'Thu',
                              'Fri',
                              'Sat'
                            ];
                            return Text(
                              weekDays[value.toInt()].substring(0, 1),
                              style: const TextStyle(color: Colors.black45),
                            );
                          case 'Monthly':
                            return Text('Week ${value.toInt() + 1}');
                          default:
                            return const Text('');
                        }
                      },
                    ),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      getTitlesWidget: (value, meta) {
                        if (_viewType == 'Monthly') {
                          return SideTitleWidget(
                            axisSide: AxisSide.top,
                            child: Text(
                              value % 10 == 0 ? '${value.toInt()}h' : '',
                              style: const TextStyle(color: Colors.black45),
                            ),
                          );
                        } else if (_viewType == 'Weekly') {
                          return SideTitleWidget(
                            axisSide: AxisSide.top,
                            child: Text(
                              value % 2 == 0 ? '${value.toInt()}h' : '',
                              style: const TextStyle(color: Colors.black45),
                            ),
                          );
                        }
                        return const Text('');
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(
                  show: true,
                  border: const Border(
                    bottom: BorderSide(color: Colors.black12),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    //  Material(
    //   elevation: 2,
    //   shadowColor: Colors.black26,
    //   borderRadius: const BorderRadius.all(
    //     Radius.circular(24),
    //   ),
    //   child: Container(
    //     decoration: const BoxDecoration(
    //       borderRadius: BorderRadius.all(
    //         Radius.circular(32),
    //       ),
    //       color: Color.fromARGB(255, 248, 248, 248),
    //     ),
    //     child: Column(
    //       children: [
    //         Padding(
    //           padding:
    //               const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: [
    //               Text(
    //                 _viewType == 'Weekly'
    //                     ? 'Working Hours'
    //                     : 'Monthly Working Hours',
    //                 style: const TextStyle(
    //                   fontSize: 18,
    //                   fontWeight: FontWeight.bold,
    //                 ),
    //               ),
    //               GestureDetector(
    //                 onTap: () => _showViewTypeMenu(context),
    //                 child: const Row(
    //                   children: [
    //                     Text('Today'),
    //                     Icon(Icons.arrow_drop_down),
    //                   ],
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //         Expanded(
    //           child: Container(
    //             padding: const EdgeInsets.all(30.0),
    //             decoration: const BoxDecoration(
    //               borderRadius: BorderRadius.all(
    //                 Radius.circular(24),
    //               ),
    //               color: Colors.white,
    //             ),
    //             child: Column(
    //               children: [
    //                 Column(
    //                   children: [
    //                     Text(
    //                       _weeklyData[_selectedBarIndex]
    //                           .convertToHoursAndMinutes(),
    //                       style: const TextStyle(
    //                         fontSize: 24,
    //                         fontWeight: FontWeight.bold,
    //                       ),
    //                     ),
    //                     const SizedBox(height: 4),
    //                     const Text(
    //                       'Today',
    //                       style: TextStyle(color: Colors.black45),
    //                     )
    //                   ],
    //                 ),
    //                 const SizedBox(height: 20),
    //                 Expanded(
    //                   child: BarChart(
    //                     BarChartData(
    //                       alignment: BarChartAlignment.spaceBetween,
    //                       gridData: FlGridData(
    //                         drawVerticalLine: false,
    //                         checkToShowHorizontalLine: (value) {
    //                           return value % 2 == 0;
    //                         },
    //                       ),
    //                       barGroups: _weeklyData.asMap().entries.map((entry) {
    //                         int index = entry.key;
    //                         double value = entry.value;
    //                         return BarChartGroupData(
    //                           x: index,
    //                           barRods: [
    //                             BarChartRodData(
    //                               toY: value,
    //                               color: index == _selectedBarIndex
    //                                   ? color
    //                                   : const Color.fromARGB(
    //                                       155, 144, 202, 249),
    //                               width: 20,
    //                               borderRadius: const BorderRadius.only(
    //                                 topLeft: Radius.circular(4),
    //                                 topRight: Radius.circular(4),
    //                               ),
    //                             ),
    //                           ],
    //                         );
    //                       }).toList(),
    //                       barTouchData: BarTouchData(
    //                         touchCallback: (touchEvent, response) {
    //                           if (response != null && response.spot != null) {
    //                             _onBarTapped(
    //                                 response.spot!.touchedBarGroupIndex);
    //                           }
    //                         },
    //                         touchTooltipData: BarTouchTooltipData(
    //                           tooltipPadding: EdgeInsets.zero,
    //                           getTooltipItem:
    //                               (group, groupIndex, rod, rodIndex) =>
    //                                   BarTooltipItem(
    //                             ' ${rod.toY.convertToHoursAndMinutes()} ',
    //                             const TextStyle(
    //                               color: Colors.white54,
    //                               fontWeight: FontWeight.bold,
    //                             ),
    //                           ),
    //                         ),
    //                       ),
    //                       titlesData: FlTitlesData(
    //                         leftTitles: const AxisTitles(
    //                           sideTitles: SideTitles(showTitles: false),
    //                         ),
    //                         topTitles: const AxisTitles(
    //                           sideTitles: SideTitles(showTitles: false),
    //                         ),
    //                         bottomTitles: AxisTitles(
    //                           sideTitles: SideTitles(
    //                             showTitles: true,
    //                             getTitlesWidget: (value, titleMeta) {
    //                               // print(value);
    //                               switch (_viewType) {
    //                                 case 'Weekly':
    //                                   const weekDays = [
    //                                     'Sun',
    //                                     'Mon',
    //                                     'Tue',
    //                                     'Wed',
    //                                     'Thu',
    //                                     'Fri',
    //                                     'Sat'
    //                                   ];
    //                                   return Text(
    //                                     weekDays[value.toInt()].substring(0, 1),
    //                                     style: const TextStyle(
    //                                         color: Colors.black45),
    //                                   );
    //                                 case 'Monthly':
    //                                   return Text('Week ${value.toInt() + 1}');
    //                                 default:
    //                                   return const Text('');
    //                               }
    //                             },
    //                           ),
    //                         ),
    //                         rightTitles: AxisTitles(
    //                           sideTitles: SideTitles(
    //                             showTitles: true,
    //                             reservedSize: 40,
    //                             getTitlesWidget: (value, meta) {
    //                               if (_viewType == 'Monthly') {
    //                                 return SideTitleWidget(
    //                                   axisSide: AxisSide.top,
    //                                   child: Text(
    //                                     value % 10 == 0
    //                                         ? '${value.toInt()}h'
    //                                         : '',
    //                                     style: const TextStyle(
    //                                         color: Colors.black45),
    //                                   ),
    //                                 );
    //                               } else if (_viewType == 'Weekly') {
    //                                 return SideTitleWidget(
    //                                   axisSide: AxisSide.top,
    //                                   child: Text(
    //                                     value % 2 == 0
    //                                         ? '${value.toInt()}h'
    //                                         : '',
    //                                     style: const TextStyle(
    //                                         color: Colors.black45),
    //                                   ),
    //                                 );
    //                               }
    //                               return const Text('');
    //                             },
    //                           ),
    //                         ),
    //                       ),
    //                       borderData: FlBorderData(
    //                         show: true,
    //                         border: const Border(
    //                           bottom: BorderSide(color: Colors.black12),
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
