import 'package:flutter/material.dart';
import 'package:hms_app/core/common/widgets/back_button.dart';
import 'package:hms_app/core/helper/dimensions.dart';
import 'package:hms_app/core/helper/sized_box_ext.dart';
import 'package:hms_app/features/bus/models/bus_route_model.dart';
import 'package:hms_app/features/bus/provider/bus_provider.dart';
import 'package:hms_app/features/bus/widgets/bus_route_widget.dart';
import 'package:provider/provider.dart';

class BusRoutesPage extends StatefulWidget {
  const BusRoutesPage({super.key});

  @override
  State<BusRoutesPage> createState() => _BusRoutesPageState();
}

class _BusRoutesPageState extends State<BusRoutesPage> {
  @override
  void initState() {
    super.initState();
    context.read<BusProvider>().fetchBuses();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15).copyWith(bottom: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomBackButton(),
                10.height,
                SizedBox(
                  width: Dimensions.getWidth(context) * 0.75,
                  child: Text(
                    "Bus Routes",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.headlineMedium,
                  ),
                ),
                20.height,
                Consumer<BusProvider>(builder: (context, data, _) {
                  return Column(
                    children: [
                      for (BusRouteModel bus in data.busRoutes) BusRouteWidget(bus: bus),
                    ],
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
