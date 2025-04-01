import 'package:flutter/material.dart';
import 'package:hms_app/core/common/widgets/back_button.dart';
import 'package:hms_app/core/constants/assets.dart';
import 'package:hms_app/core/helper/dimensions.dart';
import 'package:hms_app/core/helper/sized_box_ext.dart';
import 'package:hms_app/core/theme/colors.dart';
import 'package:hms_app/features/bus/provider/booking_provider.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class PaymentValidationPage extends StatefulWidget {
  final String transactionId;
  final String lock;
  const PaymentValidationPage({super.key, required this.transactionId, required this.lock});

  @override
  State<PaymentValidationPage> createState() => _PaymentValidationPageState();
}

class _PaymentValidationPageState extends State<PaymentValidationPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        context.read<BookingProvider>().paymentStatus = null;
        context.read<BookingProvider>().isValidating = false;
        context.read<BookingProvider>().validatePayment(id: widget.transactionId, lock: widget.lock);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) => false,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(15).copyWith(bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                10.height,
                SizedBox(
                  width: Dimensions.getWidth(context) * 0.75,
                  child: Text(
                    "Verifying Payment",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.headlineMedium,
                  ),
                ),
                25.height,
                Spacer(),
                Consumer<BookingProvider>(builder: (context, data, value) {
                  return data.isValidating
                      ? 0.height
                      : data.paymentStatus != null
                          ? data.paymentStatus == "SUCCESS"
                              ? Column(
                                  children: [
                                    Center(
                                      child: Lottie.asset(Assets.paymentSuccess),
                                    ),
                                    30.height,
                                    Text(
                                      "You will be redirected to Home page in few seconds!",
                                      style: textTheme.headlineMedium?.copyWith(color: AppColors.primaryColor900),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                )
                              : Column(
                                  children: [
                                    Center(
                                      child: Lottie.asset(Assets.paymentFailure),
                                    ),
                                    30.height,
                                    Text(
                                      "You will be redirected to Home page in few seconds!",
                                      style: textTheme.headlineMedium?.copyWith(color: AppColors.primaryColor900),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                )
                          : Center(
                              child: Text(
                                "Something went wrong",
                                style: textTheme.headlineMedium,
                              ),
                            );
                }),
                Spacer(flex: 2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
