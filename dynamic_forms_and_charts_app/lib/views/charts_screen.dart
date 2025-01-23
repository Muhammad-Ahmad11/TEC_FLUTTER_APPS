import 'package:dynamic_forms_and_charts_app/theme/colors.dart';
import 'package:dynamic_forms_and_charts_app/utils/Utils.dart';
import 'package:dynamic_forms_and_charts_app/view_models/field_view_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChartScreen extends StatefulWidget {
  const ChartScreen({super.key});

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Utils.chartsScreenName),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            tooltip: Utils.clearAllFieldsText,
            onPressed: () {
              final fieldProvider =
                  Provider.of<FieldViewModel>(context, listen: false);
              fieldProvider.deleteAllFields();
              Utils.showSnackBar(context, Utils.allFieldsClearedText);
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<FieldViewModel>(
          builder: (context, fieldProvider, child) {
            // Handle empty fields list
            if (fieldProvider.fields.isEmpty) {
              return const Center(
                child: Text(Utils.noData),
              );
            }

            // Ensure valid values
            final validFields = fieldProvider.fields.where((field) {
              return field.fieldValue.isFinite && field.fieldValue > 0;
            }).toList();

            if (validFields.isEmpty) {
              return const Center(
                child: Text(Utils.invalidData),
              );
            }

            return SingleChildScrollView(
              child: Column(
                children: [
                  const Text(
                    Utils.barChartName,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 300,
                    child: BarChart(
                      BarChartData(
                        barGroups: validFields.map((field) {
                          final index = validFields.indexOf(field);
                          return BarChartGroupData(
                            x: index,
                            barRods: [
                              BarChartRodData(
                                toY: field.fieldValue,
                                color: AppColors.primaryColor,
                                width: 15,
                              )
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    Utils.pieChartname,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 300,
                    child: PieChart(
                      PieChartData(
                        sections: validFields.map((field) {
                          return PieChartSectionData(
                            value: field.fieldValue,
                            title: field.fieldName,
                            color: Colors.primaries[validFields.indexOf(field) %
                                Colors.primaries.length],
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
