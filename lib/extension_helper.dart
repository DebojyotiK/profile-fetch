import 'package:flutter/material.dart';

extension IntExtensions on int? {
  Widget get h => SizedBox(height: this?.toDouble());
  Widget get w => SizedBox(width: this?.toDouble());
}

extension WidgetChildrenExtensions on List<Widget?> {
  List<Widget> spaceVertically(double spacing){
    Widget spacer = spacing.h;
    return _addSpacer(spacer);
  }

  List<Widget> spaceHorizontally(double spacing){
    Widget spacer = spacing.w;
    return _addSpacer(spacer);
  }

  List<Widget> _addSpacer(Widget spacer) {
    List<Widget> spacedWidgets = [];
    List<Widget> filteredWidgets = [];
    _getFilteredWidgets(filteredWidgets);
    if(filteredWidgets.length > 1){
      for(int i=0;i<filteredWidgets.length-1;i++){
        spacedWidgets.add(filteredWidgets[i]);
        spacedWidgets.add(spacer);
      }
      spacedWidgets.add(filteredWidgets.last);
      return spacedWidgets;
    }
    else{
      return filteredWidgets;
    }
  }

  void _getFilteredWidgets(List<Widget> filteredWidgets) {
    for (var e in this) {
      if(e != null){
        filteredWidgets.add(e);
      }
    }
  }
}

extension DoubleExtensions on double? {
  Widget get h => SizedBox(height: this);

  Widget get w => SizedBox(width: this);

  int get flex => 10 * this! ~/ (1 - this!);

}