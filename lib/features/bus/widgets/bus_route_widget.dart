import 'package:flutter/material.dart';
import 'package:hms_app/core/common/widgets/button.dart';
import 'package:hms_app/core/helper/date_time.dart';
import 'package:hms_app/core/helper/dimensions.dart';
import 'package:hms_app/core/helper/sized_box_ext.dart';
import 'package:hms_app/core/navigation/go_router.dart';
import 'package:hms_app/core/navigation/routes.dart';
import 'package:hms_app/core/theme/colors.dart';
import 'package:hms_app/features/bus/models/bus_route_model.dart';

class BusRouteWidget extends StatelessWidget {
  const BusRouteWidget({
    super.key,
    required this.bus,
  });

  final BusRouteModel bus;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Container(
      width: Dimensions.getWidth(context) - 30,
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            spreadRadius: 2,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  bus.name,
                  style: textTheme.bodyMedium,
                ),
              ),
              10.width,
              Text(
                DateTimeHelper.formatDateTime(
                  bus.date.toIso8601String(),
                ),
              ),
            ],
          ),
          10.height,
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${bus.from} to ${bus.to}",
                      style: textTheme.bodyMedium,
                    ),
                    5.height,
                    Text(
                      bus.busType,
                      style: textTheme.bodyMedium?.copyWith(color: AppColors.grey600),
                    ),
                  ],
                ),
              ),
              Text(
                "₹ ${bus.busFare}",
                style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          10.height,
          Row(
            children: [
              Expanded(
                child: Text(
                  "Available Seats : ${bus.seatsAvailable}",
                  style: textTheme.bodyMedium,
                ),
              ),
              10.width,
              CustomButton(
                onTap: () {
                  router.push(Routes.passengerInfo, extra: bus);
                },
                title: "Book Now",
                color: AppColors.errorColor500,
                width: 100,
                height: 40,
                fontSize: 14,
              )
            ],
          )
        ],
      ),
    );
  }
}
