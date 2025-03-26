import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:hms_app/core/constants/assets.dart';
import 'package:hms_app/core/constants/enums.dart';
import 'package:hms_app/core/helper/dimensions.dart';
import 'package:hms_app/core/theme/colors.dart';

class ChatTextWidget extends StatelessWidget {
  final String text;
  final MessageUsers sender;
  const ChatTextWidget({
    super.key,
    required this.text,
    required this.sender,
  });

  @override
  Widget build(BuildContext context) {
    final isUserSender = MessageUsers.student == sender;
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Align(
        alignment: isUserSender ? Alignment.centerRight : Alignment.centerLeft,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (!isUserSender)
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: ClipOval(
                  child: Image.asset(
                    Assets.rguktLogo,
                    width: Dimensions.getWidth(context) * 0.08,
                    height: Dimensions.getWidth(context) * 0.08,
                    alignment: Alignment.center,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            Bubble(
              alignment: isUserSender ? Alignment.centerRight : Alignment.centerLeft,
              elevation: 0,
              nip: isUserSender ? BubbleNip.rightBottom : BubbleNip.leftBottom,
              color: isUserSender ? AppColors.primaryColor50 : AppColors.grey50,
              radius: const Radius.circular(12),
              child: IntrinsicWidth(
                child: Container(
                  constraints: BoxConstraints(maxWidth: Dimensions.getWidth(context) * 0.6),
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    text,
                    textAlign: TextAlign.left,
                    style:
                        Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.grey900, letterSpacing: 1.1),
                  ),
                ),
              ),
            ),
            if (isUserSender)
              Container(
                width: Dimensions.getWidth(context) * 0.08,
                height: Dimensions.getWidth(context) * 0.08,
                decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.primaryColor100),
                child: Center(
                  child: Text("You",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.primaryColor900,
                          )),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
