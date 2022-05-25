import 'package:charts_flutter/flutter.dart' as charts;
import 'package:charts_common/common.dart' as common;
import 'package:flutter/material.dart';

class CustomLegendBuilder extends charts.LegendContentBuilder {
  Widget createLabel(BuildContext context, common.LegendEntry legendEntry,
      common.SeriesLegend legend, bool isHidden) {
    Color color = charts.ColorUtil.toDartColor(legendEntry.color!);

    return GestureDetector(
        child: Container(
          height: 30,
          width: MediaQuery.of(context).size.width / 3,
          margin: const EdgeInsets.only(top: 5, right: 10, bottom: 5),
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border:
                Border.all(color: isHidden ? (color).withOpacity(0.26) : color),
          ),
          child: Center(
            child: Text(
              legendEntry.label,
              textAlign: TextAlign.center,
              style: TextStyle(
                  inherit: true,
                  fontFamily: legendEntry.textStyle?.fontFamily,
                  fontSize: legendEntry.textStyle?.fontSize != null
                      ? legendEntry.textStyle?.fontSize?.toDouble()
                      : null,
                  color: isHidden ? (color).withOpacity(0.26) : color),
            ),
          ),
        ),
        onTapUp: makeTapUpCallback(context, legendEntry, legend));
  }

  GestureTapUpCallback makeTapUpCallback(BuildContext context,
      common.LegendEntry legendEntry, common.SeriesLegend legend) {
    return (TapUpDetails d) {
      switch (legend.legendTapHandling) {
        case common.LegendTapHandling.hide:
          final seriesId = legendEntry.series.id;
          if (legend.isSeriesHidden(seriesId)) {
            legend.showSeries(seriesId);
          } else {
            legend.hideSeries(seriesId);
          }
          legend.chart.redraw(skipLayout: true, skipAnimation: false);
          break;
        case common.LegendTapHandling.none:
        default:
          break;
      }
    };
  }

  @override
  Widget build(BuildContext context, common.LegendState legendState,
      common.Legend legend,
      {bool? showMeasures}) {
    final entryWidgets = legendState.legendEntries.map((legendEntry) {
      var isHidden = false;
      if (legend is common.SeriesLegend) {
        isHidden = legend.isSeriesHidden(legendEntry.series.id);
      }
      return createLabel(
          context, legendEntry, legend as common.SeriesLegend, isHidden);
    }).toList();

    return Padding(
      padding: const EdgeInsets.only(right: 100, top: 5),
      child: Wrap(children: entryWidgets),
    );
  }
}
