import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hms_app/core/constants/assets.dart';
import 'package:hms_app/core/navigation/go_router.dart';
import 'package:hms_app/core/navigation/routes.dart';
import 'package:hms_app/core/theme/colors.dart';
import 'package:hms_app/features/complaints/models/complaint_model.dart';

class ComplaintSlidableWidget extends StatelessWidget {
  const ComplaintSlidableWidget({
    super.key,
    required this.cmp,
  });

  final ComplaintModel cmp;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {},
              icon: Icons.delete,
              backgroundColor: AppColors.errorColor500,
              borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
            ),
          ],
        ),
        child: ListTile(
          onTap: () {
            router.push(Routes.complaintDetail, extra: cmp);
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: AppColors.grey500, width: 0.5),
          ),
          title: Text(
            cmp.type.toUpperCase(),
            style: textTheme.headlineMedium?.copyWith(fontSize: 18),
          ),
          subtitle: Text(
            cmp.description,
            style: textTheme.bodyMedium,
          ),
          leading: Image.asset(cmp.type == "electricity"
              ? Assets.electricity
              : cmp.type == "cleaning"
                  ? Assets.cleaning
                  : Assets.others),
        ),
      ),
    );
  }
}
