import 'package:flutter/material.dart';
import 'package:hms_app/core/helper/date_time.dart';
import 'package:hms_app/core/helper/dimensions.dart';
import 'package:hms_app/core/helper/sized_box_ext.dart';
import 'package:hms_app/core/theme/colors.dart';
import 'package:hms_app/features/bus/models/bus_booking_model.dart';

class BusBookingWidget extends StatelessWidget {
  const BusBookingWidget({
    super.key,
    required this.bus,
  });

  final BusBookingModel bus;

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
                  bus.bus.name,
                  style: textTheme.bodyMedium,
                ),
              ),
              10.width,
              Text(
                DateTimeHelper.formatDateTime(
                  bus.bus.date.toIso8601String(),
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
                      "${bus.bus.from} to ${bus.bus.to}",
                      style: textTheme.bodyMedium,
                    ),
                    5.height,
                    Text(
                      bus.bus.busType,
                      style: textTheme.bodyMedium?.copyWith(color: AppColors.grey600),
                    ),
                  ],
                ),
              ),
              Text(
                "₹ ${bus.amount}",
                style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          10.height,
          Row(
            children: [
              Text(
                "Payment Status : ",
                style: textTheme.bodyMedium,
              ),
              10.width,
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: bus.status == "CONFIRMED"
                      ? AppColors.successColor500
                      : bus.status == "PENDING"
                          ? AppColors.warningColor500
                          : AppColors.errorColor500,
                ),
                child: Text(
                  bus.status,
                  style: textTheme.bodySmall?.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
          10.height,
          Text(
            "Transaction on : ${DateTimeHelper.formatDateTime(bus.createdAt.toIso8601String())}",
            style: textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
