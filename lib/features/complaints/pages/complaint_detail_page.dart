import 'package:flutter/material.dart';
import 'package:hms_app/core/common/widgets/back_button.dart';
import 'package:hms_app/core/common/widgets/text_field.dart';
import 'package:hms_app/core/helper/date_time.dart';
import 'package:hms_app/core/helper/dimensions.dart';
import 'package:hms_app/core/helper/sized_box_ext.dart';
import 'package:hms_app/core/theme/colors.dart';
import 'package:hms_app/features/complaints/models/complaint_model.dart';

class ComplaintDetailPage extends StatefulWidget {
  final ComplaintModel complaintModel;
  const ComplaintDetailPage({super.key, required this.complaintModel});

  @override
  State<ComplaintDetailPage> createState() => _ComplaintDetailPageState();
}

class _ComplaintDetailPageState extends State<ComplaintDetailPage> {
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15).copyWith(bottom: 10),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomBackButton(),
                      20.height,
                      Text(
                        widget.complaintModel.type.toUpperCase(),
                        style: textTheme.headlineLarge,
                      ),
                      20.height,
                      Text(
                        widget.complaintModel.description,
                        style: textTheme.bodyLarge,
                      ),
                      20.height,
                      Row(
                        children: [
                          Text("Priority : ", style: textTheme.headlineMedium),
                          20.width,
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                            decoration: BoxDecoration(
                              color: widget.complaintModel.priority == "low"
                                  ? AppColors.successColor500
                                  : widget.complaintModel.priority == "medium"
                                      ? AppColors.warningColor500
                                      : AppColors.errorColor500,
                            ),
                            child: Text(
                              widget.complaintModel.priority.toUpperCase(),
                              style: textTheme.bodySmall?.copyWith(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      20.height,
                      Row(
                        children: [
                          Text("Status : ", style: textTheme.headlineMedium),
                          20.width,
                          Text(
                            widget.complaintModel.status.toUpperCase(),
                            style: textTheme.bodyMedium,
                          ),
                        ],
                      ),
                      20.height,
                      Row(
                        children: [
                          Text("Created At : ", style: textTheme.headlineMedium),
                          20.width,
                          Text(
                            DateTimeHelper.formatDateTime(widget.complaintModel.createdAt.toIso8601String()),
                            style: textTheme.bodyMedium,
                          ),
                        ],
                      ),
                      20.height,
                      Row(
                        children: [
                          Text("Updated At : ", style: textTheme.headlineMedium),
                          20.width,
                          Text(
                            DateTimeHelper.formatDateTime(widget.complaintModel.updatedAt.toIso8601String()),
                            style: textTheme.bodyMedium,
                          ),
                        ],
                      ),
                      if (widget.complaintModel.images.isNotEmpty) 20.height,
                      if (widget.complaintModel.images.isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Images : ",
                              style: textTheme.headlineMedium,
                            ),
                            10.height,
                            Wrap(
                              spacing: 10,
                              runSpacing: 20,
                              children: [
                                for (int i = 0; i < widget.complaintModel.images.length; i++)
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(
                                      widget.complaintModel.images[i],
                                      fit: BoxFit.cover,
                                      width: (Dimensions.getWidth(context) - 40) * 0.5,
                                      height: Dimensions.getHeight(context) * 0.2,
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        )
                    ],
                  ),
                ),
              ),
              15.height,
              CustomTextField(
                heading: "",
                showHeading: false,
                textEditingController: TextEditingController(),
                hintText: "Comment here",
                isMultiline: true,
                suffix: Icon(
                  Icons.send_rounded,
                  size: 26,
                  color: AppColors.primaryColor900,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
