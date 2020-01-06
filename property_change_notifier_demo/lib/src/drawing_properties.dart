import 'package:property_change_notifier/property_change_notifier.dart';

enum DrawingChanges {
  ZOOM,
  INDICES,
  AREA_ZOOM,
  CHART_TYPE,
  BUY_SELL,
  PIVOT_POINT,
}

class DrawingChangeNotifier extends PropertyChangeNotifier {
  void setZoom() {
    notifyListeners(DrawingChanges.ZOOM);
  }

  void setIndices() {
    notifyListeners(DrawingChanges.INDICES);
  }

  void AreaZoomStart() {
    notifyListeners(DrawingChanges.AREA_ZOOM);
  }

  void AreaZoomEnd() {
    notifyListeners(DrawingChanges.AREA_ZOOM);
  }

  void chartTypeChange() {
    notifyListeners(DrawingChanges.CHART_TYPE);
  }

  void pivotPointsChange() {
    notifyListeners(DrawingChanges.PIVOT_POINT);
  }

  void buySellChange() {
    notifyListeners(DrawingChanges.BUY_SELL);
  }
}

final notifier = DrawingChangeNotifier();
