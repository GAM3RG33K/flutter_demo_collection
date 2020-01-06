import 'package:flutter/material.dart';
import 'package:property_change_notifier/property_change_notifier.dart';
import 'package:property_change_notifier_demo/src/drawing_properties.dart';

class ChartWidget extends StatefulWidget {
  @override
  _ChartWidgetState createState() => _ChartWidgetState();
}

class _ChartWidgetState extends State<ChartWidget> {
  int _counter = 0;
  @override
  Widget build(BuildContext context) {
    return PropertyChangeProvider<DrawingChangeNotifier>(
      value: notifier,
      child: PropertyChangeConsumer<DrawingChangeNotifier>(
        builder: (context, notifier, __) => _buildChartWidget(context),
      ),
    );
  }

  Widget _buildChartWidget(BuildContext context) {
    final properties =
        PropertyChangeProvider.of<DrawingChangeNotifier>(context).properties;
    return Stack(
      children: <Widget>[
        Container(
          child: Center(
            child: Column(
              children: <Widget>[
                Text(properties == null || properties.isEmpty
                    ? 'No changes'
                    : 'Properties: $properties'),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: FloatingActionButton(
            onPressed: () {
              switch ((_counter % 7)) {
                case 0:
                  notifier.setZoom();
                  _counter++;
                  break;
                case 1:
                  notifier.setIndices();
                  _counter++;
                  break;
                case 2:
                  notifier.AreaZoomStart();
                  _counter++;
                  break;
                case 3:
                  notifier.chartTypeChange();
                  _counter++;
                  break;
                case 4:
                  notifier.buySellChange();
                  _counter++;
                  break;
                case 5:
                  notifier.AreaZoomEnd();
                  _counter++;
                  break;
                case 6:
                  notifier.pivotPointsChange();
                  _counter++;
                  break;
              }
            },
            tooltip: 'Dispatch Event',
            child: Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
