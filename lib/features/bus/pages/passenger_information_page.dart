import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_swipe_button/flutter_swipe_button.dart';
import 'package:hms_app/core/common/provider/user_provider.dart';
import 'package:hms_app/core/common/widgets/back_button.dart';
import 'package:hms_app/core/common/widgets/text_field.dart';
import 'package:hms_app/core/helper/date_time.dart';
import 'package:hms_app/core/helper/dimensions.dart';
import 'package:hms_app/core/helper/sized_box_ext.dart';
import 'package:hms_app/core/theme/colors.dart';
import 'package:hms_app/features/bus/models/bus_route_model.dart';
import 'package:provider/provider.dart';

class PassengerInformationPage extends StatefulWidget {
  final BusRouteModel bus;
  const PassengerInformationPage({super.key, required this.bus});

  @override
  State<PassengerInformationPage> createState() => _PassengerInformationPageState();
}

class _PassengerInformationPageState extends State<PassengerInformationPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = context.read<UserProvider>().userName ?? "";
    emailController.text = context.read<UserProvider>().email ?? "";
    emailController.addListener(_updateState);
    phoneController.addListener(_updateState);
  }

  void _updateState() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    emailController.removeListener(_updateState);
    phoneController.removeListener(_updateState);
    super.dispose();
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
                    "Bus Information",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.headlineMedium,
                  ),
                ),
                25.height,
                Text(
                  "${widget.bus.from} to ${widget.bus.to}",
                  style: textTheme.headlineMedium,
                ),
                5.height,
                Text(
                  widget.bus.busType,
                  style: textTheme.bodyLarge?.copyWith(color: AppColors.grey600),
                ),
                10.height,
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: AppColors.primaryColor400,
                      ),
                      child: Text(
                        "1 Seat",
                        style: textTheme.bodySmall?.copyWith(color: Colors.white),
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: AppColors.errorColor500,
                      ),
                      child: Text(
                        "₹ ${widget.bus.busFare}",
                        style: textTheme.bodySmall?.copyWith(color: Colors.white, fontSize: 14),
                      ),
                    ),
                  ],
                ),
                10.height,
                Text(
                  DateTimeHelper.formatDateTime(widget.bus.date.toIso8601String()),
                  style: textTheme.bodyLarge,
                ),
                30.height,
                SizedBox(
                  width: Dimensions.getWidth(context) * 0.75,
                  child: Text(
                    "Passenger Information",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.headlineMedium,
                  ),
                ),
                25.height,
                CustomTextField(
                  heading: "",
                  showHeading: false,
                  textEditingController: nameController,
                  hintText: "Passenger name",
                ),
                10.height,
                CustomTextField(
                  heading: "",
                  showHeading: false,
                  textEditingController: emailController,
                  readOnly: true,
                  hintText: "Email",
                ),
                10.height,
                CustomTextField(
                  heading: "",
                  showHeading: false,
                  textEditingController: phoneController,
                  hintText: "Phone Number",
                  maxLength: 10,
                  prefix: Padding(
                    padding: const EdgeInsets.only(top: 10, left: 10),
                    child: Text(
                      "+ 91",
                      style: textTheme.bodyLarge,
                    ),
                  ),
                ),
                50.height,
                SwipeButton.expand(
                  enabled: nameController.text.trim().isNotEmpty && phoneController.text.trim().length == 10,
                  thumb: Icon(
                    Icons.double_arrow_rounded,
                    color: Colors.white,
                  ),
                  activeThumbColor: Colors.red,
                  activeTrackColor: Colors.red.withOpacity(0.2),
                  onSwipeEnd: () {
                    HapticFeedback.vibrate();
                  },
                  child: Text("Pay ₹ ${widget.bus.busFare}", style: textTheme.bodyMedium?.copyWith(fontSize: 18)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
