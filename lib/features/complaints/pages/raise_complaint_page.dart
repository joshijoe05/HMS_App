import 'package:flutter/material.dart';
import 'package:hms_app/core/common/widgets/back_button.dart';
import 'package:hms_app/core/common/widgets/button.dart';
import 'package:hms_app/core/common/widgets/dropdown.dart';
import 'package:hms_app/core/common/widgets/text_field.dart';
import 'package:hms_app/core/helper/dimensions.dart';
import 'package:hms_app/core/helper/sized_box_ext.dart';
import 'package:hms_app/core/theme/colors.dart';
import 'package:hms_app/features/complaints/provider/raise_complaint_provider.dart';
import 'package:provider/provider.dart';

class RaiseComplaintPage extends StatefulWidget {
  const RaiseComplaintPage({super.key});

  @override
  State<RaiseComplaintPage> createState() => _RaiseComplaintPageState();
}

class _RaiseComplaintPageState extends State<RaiseComplaintPage> {
  var complaintProvider;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        complaintProvider = context.read<RaiseComplaintProvider>();
        complaintProvider.clear();
        complaintProvider.descriptionController.addListener(_updateState);
      },
    );
  }

  void _updateState() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    complaintProvider.descriptionController.removeListener(_updateState);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15).copyWith(bottom: 10),
          child: SingleChildScrollView(
            child: Consumer<RaiseComplaintProvider>(builder: (context, data, _) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomBackButton(),
                  20.height,
                  Text(
                    "Raise Complaint",
                    style: textTheme.headlineMedium,
                  ),
                  20.height,
                  CustomDropDownButton(
                    onChanged: (value) {
                      data.changeCategory(value);
                    },
                    placeHolder: "Select Category",
                    items: ["Electricity", "Cleaning", "Others"],
                    heading: "Category",
                    showHeading: true,
                    item: data.type,
                  ),
                  20.height,
                  CustomDropDownButton(
                    onChanged: (value) {
                      data.changePriority(value);
                    },
                    items: ["Low", "Medium", "High"],
                    heading: "Priority",
                    placeHolder: "Select Priority",
                    showHeading: true,
                    item: data.priority,
                  ),
                  20.height,
                  CustomTextField(
                    heading: "Description",
                    textEditingController: data.descriptionController,
                    hintText: "Describe the issue",
                    isMultiline: true,
                  ),
                  20.height,
                  Text(
                    "Supporting Images",
                    style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  5.height,
                  Row(
                    children: [
                      data.firstImage == null
                          ? IconButton(
                              style: IconButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  side: const BorderSide(width: 1.5, color: AppColors.primaryColor400),
                                ),
                                fixedSize: Size(
                                    (Dimensions.getWidth(context) - 40) * 0.5, Dimensions.getHeight(context) * 0.2),
                              ),
                              onPressed: () async {
                                await data.addPhotos(isFirstImg: true);
                              },
                              icon: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.add,
                                    size: 32,
                                    color: AppColors.primaryColor400,
                                  ),
                                  5.height,
                                  Text(
                                    "Add Photo 1",
                                    style: textTheme.bodySmall?.copyWith(color: AppColors.primaryColor400),
                                  ),
                                ],
                              ),
                            )
                          : Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.file(
                                    data.firstImage!,
                                    fit: BoxFit.cover,
                                    width: (Dimensions.getWidth(context) - 40) * 0.5,
                                    height: Dimensions.getHeight(context) * 0.2,
                                  ),
                                ),
                                Positioned(
                                  top: -15,
                                  right: -15,
                                  child: IconButton(
                                    padding: const EdgeInsets.all(0),
                                    constraints: const BoxConstraints(),
                                    tooltip: "Deselect Image",
                                    style: IconButton.styleFrom(
                                        padding: const EdgeInsets.all(0), backgroundColor: AppColors.errorColor50),
                                    onPressed: () {
                                      data.removePhoto(isFirstImg: true);
                                    },
                                    icon: const Icon(
                                      Icons.close,
                                      size: 20,
                                      color: AppColors.errorColor500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                      10.width,
                      data.secondImage == null
                          ? IconButton(
                              style: IconButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  side: const BorderSide(width: 1.5, color: AppColors.primaryColor400),
                                ),
                                fixedSize: Size(
                                    (Dimensions.getWidth(context) - 40) * 0.5, Dimensions.getHeight(context) * 0.2),
                              ),
                              onPressed: () async {
                                await data.addPhotos(isFirstImg: false);
                              },
                              icon: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.add,
                                    size: 32,
                                    color: AppColors.primaryColor400,
                                  ),
                                  5.height,
                                  Text(
                                    "Add Photo 2",
                                    style: textTheme.bodySmall?.copyWith(color: AppColors.primaryColor400),
                                  ),
                                ],
                              ),
                            )
                          : Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.file(
                                    data.secondImage!,
                                    fit: BoxFit.cover,
                                    width: (Dimensions.getWidth(context) - 40) * 0.5,
                                    height: Dimensions.getHeight(context) * 0.2,
                                  ),
                                ),
                                Positioned(
                                  top: -15,
                                  right: -15,
                                  child: IconButton(
                                    padding: const EdgeInsets.all(0),
                                    constraints: const BoxConstraints(),
                                    tooltip: "Deselect Image",
                                    style: IconButton.styleFrom(
                                        padding: const EdgeInsets.all(0), backgroundColor: AppColors.errorColor50),
                                    onPressed: () {
                                      data.removePhoto(isFirstImg: false);
                                    },
                                    icon: const Icon(
                                      Icons.close,
                                      size: 20,
                                      color: AppColors.errorColor500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                    ],
                  ),
                  30.height,
                  CustomButton(
                    onTap: () async {
                      await data.raiseComplaint();
                    },
                    title: "Raise Complaint",
                    isEnabled:
                        data.type != null && data.priority != null && data.descriptionController.text.trim().isNotEmpty,
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
