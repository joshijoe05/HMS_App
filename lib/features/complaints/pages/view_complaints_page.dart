import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hms_app/core/common/widgets/button.dart';
import 'package:hms_app/core/helper/dimensions.dart';
import 'package:hms_app/core/helper/sized_box_ext.dart';
import 'package:hms_app/core/theme/colors.dart';
import 'package:hms_app/features/complaints/models/complaint_model.dart';
import 'package:hms_app/features/complaints/provider/complaint_provider.dart';
import 'package:hms_app/features/complaints/widgets/complaint_slidable_widget.dart';
import 'package:provider/provider.dart';

class ViewComplaintsPage extends StatefulWidget {
  const ViewComplaintsPage({super.key});

  @override
  State<ViewComplaintsPage> createState() => _ViewComplaintsPageState();
}

class _ViewComplaintsPageState extends State<ViewComplaintsPage> {
  late ComplaintProvider complaintProvider;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    complaintProvider = context.read<ComplaintProvider>();
    complaintProvider.hasMoreComplaints = true;
    complaintProvider.complaintsPage = 1;
    complaintProvider.complaints.clear();
    complaintProvider.getYourComplaints();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        _scrollController.addListener(
          () async {
            if (mounted) {
              if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
                await complaintProvider.getYourComplaints();
              }
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Padding(
            padding: const EdgeInsets.all(15).copyWith(bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: Dimensions.getWidth(context) * 0.75,
                  child: Text(
                    "Complaints & Issues",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.headlineMedium,
                  ),
                ),
                10.height,
                SizedBox(
                  width: Dimensions.getWidth(context) * 0.9,
                  child: Text(
                    "Raise your hostel concerns, and let the authorities resolve them swiftly! 🚀",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.bodySmall?.copyWith(fontSize: 15, color: AppColors.grey600),
                  ),
                ),
                30.height,
                CustomButton(
                  onTap: () {},
                  title: "Raise your Complaint",
                  color: AppColors.primaryColor50,
                  textColor: AppColors.primaryColor900,
                ),
                20.height,
                Text(
                  "Your Complaints",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.bodyLarge,
                ),
                20.height,
                Consumer<ComplaintProvider>(
                  builder: (context, data, child) {
                    if (data.complaints.isEmpty && !EasyLoading.isShow) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          (Dimensions.getHeight(context) * 0.25).round().height,
                          Center(
                            child: SizedBox(
                              width: (Dimensions.getWidth(context) * 0.8),
                              child: Text(
                                "You have not raised any complaints yet !",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: textTheme.bodyLarge,
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                    return Column(
                      children: [
                        for (ComplaintModel cmp in data.complaints) ComplaintSlidableWidget(cmp: cmp),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
