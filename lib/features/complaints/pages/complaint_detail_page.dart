import 'package:flutter/material.dart';
import 'package:hms_app/core/common/widgets/back_button.dart';
import 'package:hms_app/core/common/widgets/chat_widgets.dart';
import 'package:hms_app/core/common/widgets/text_field.dart';
import 'package:hms_app/core/constants/enums.dart';
import 'package:hms_app/core/helper/date_time.dart';
import 'package:hms_app/core/helper/dimensions.dart';
import 'package:hms_app/core/helper/sized_box_ext.dart';
import 'package:hms_app/core/theme/colors.dart';
import 'package:hms_app/features/complaints/models/complaint_model.dart';
import 'package:hms_app/features/complaints/provider/complaint_provider.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';

class ComplaintDetailPage extends StatefulWidget {
  final ComplaintModel complaintModel;
  const ComplaintDetailPage({super.key, required this.complaintModel});

  @override
  State<ComplaintDetailPage> createState() => _ComplaintDetailPageState();
}

class _ComplaintDetailPageState extends State<ComplaintDetailPage> {
  late ComplaintProvider complaintProvider;
  final TextEditingController commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    complaintProvider = context.read<ComplaintProvider>();
    complaintProvider.complaintDetail = null;
    complaintProvider.getComplaintDetails(id: widget.complaintModel.id);
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: LiquidPullToRefresh(
          onRefresh: () async {
            await complaintProvider.getComplaintDetails(id: widget.complaintModel.id);
          },
          animSpeedFactor: 5,
          showChildOpacityTransition: false,
          color: AppColors.successColor500,
          backgroundColor: AppColors.successColor100,
          child: Padding(
            padding: const EdgeInsets.all(15).copyWith(bottom: 10),
            child: Consumer<ComplaintProvider>(builder: (context, data, _) {
              return data.isFetchingComplaintDetail
                  ? 0.height
                  : data.complaintDetail == null
                      ? Center(
                          child: Text(
                            "Something went wrong, Pull down to refresh !",
                            style: textTheme.headlineMedium,
                            textAlign: TextAlign.center,
                          ),
                        )
                      : Column(
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                physics: AlwaysScrollableScrollPhysics(),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomBackButton(),
                                    20.height,
                                    Text(
                                      data.complaintDetail!.type.toUpperCase(),
                                      style: textTheme.headlineLarge,
                                    ),
                                    20.height,
                                    Text(
                                      data.complaintDetail!.description,
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
                                            color: data.complaintDetail!.priority == "low"
                                                ? AppColors.successColor500
                                                : data.complaintDetail!.priority == "medium"
                                                    ? AppColors.warningColor500
                                                    : AppColors.errorColor500,
                                          ),
                                          child: Text(
                                            data.complaintDetail!.priority.toUpperCase(),
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
                                          data.complaintDetail!.status.toUpperCase(),
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
                                          DateTimeHelper.formatDateTime(
                                              data.complaintDetail!.createdAt.toIso8601String()),
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
                                          DateTimeHelper.formatDateTime(
                                              data.complaintDetail!.updatedAt.toIso8601String()),
                                          style: textTheme.bodyMedium,
                                        ),
                                      ],
                                    ),
                                    if (data.complaintDetail!.images.isNotEmpty) 20.height,
                                    if (data.complaintDetail!.images.isNotEmpty)
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
                                              for (int i = 0; i < data.complaintDetail!.images.length; i++)
                                                ClipRRect(
                                                  borderRadius: BorderRadius.circular(12),
                                                  child: Image.network(
                                                    data.complaintDetail!.images[i],
                                                    fit: BoxFit.cover,
                                                    width: (Dimensions.getWidth(context) - 40) * 0.5,
                                                    height: Dimensions.getHeight(context) * 0.2,
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    if (data.complaintDetail!.comments.isNotEmpty) 35.height,
                                    if (data.complaintDetail!.comments.isNotEmpty)
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Comments : ",
                                            style: textTheme.headlineMedium,
                                          ),
                                          10.height,
                                          for (int i = 0; i < data.complaintDetail!.comments.length; i++)
                                            Padding(
                                              padding: EdgeInsets.only(bottom: 10),
                                              child: ChatTextWidget(
                                                text: data.complaintDetail!.comments[i].text,
                                                sender: data.complaintDetail!.comments[i].addedBy ==
                                                        data.complaintDetail!.raisedBy
                                                    ? MessageUsers.student
                                                    : MessageUsers.admin,
                                              ),
                                            ),
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                            ),
                            15.height,
                            CustomTextField(
                              heading: "",
                              showHeading: false,
                              textEditingController: commentController,
                              hintText: "Comment here",
                              isMultiline: true,
                              suffix: IconButton(
                                onPressed: () async {
                                  if (commentController.text.trim().isNotEmpty) {
                                    bool isDone = await data.addCommentToComplaint(
                                        id: data.complaintDetail!.id, comment: commentController.text.trim());
                                    if (isDone) commentController.clear();
                                  }
                                },
                                icon: Icon(
                                  Icons.send_rounded,
                                  size: 26,
                                  color: AppColors.primaryColor900,
                                ),
                              ),
                            ),
                          ],
                        );
            }),
          ),
        ),
      ),
    );
  }
}
