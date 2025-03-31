import 'package:flutter/material.dart';
import 'package:hms_app/core/common/widgets/button.dart';
import 'package:hms_app/core/common/widgets/dropdown.dart';
import 'package:hms_app/core/common/widgets/text_field.dart';
import 'package:hms_app/core/helper/dimensions.dart';
import 'package:hms_app/core/helper/sized_box_ext.dart';
import 'package:hms_app/core/navigation/go_router.dart';
import 'package:hms_app/core/navigation/routes.dart';
import 'package:hms_app/core/theme/colors.dart';
import 'package:hms_app/features/bus/provider/bus_provider.dart';
import 'package:provider/provider.dart';

class BusSelectionPage extends StatefulWidget {
  const BusSelectionPage({super.key});

  @override
  State<BusSelectionPage> createState() => _BusSelectionPageState();
}

class _BusSelectionPageState extends State<BusSelectionPage> {
  final fromController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<BusProvider>().getCities();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    fromController.text = "Nuzvid";
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15).copyWith(bottom: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: Dimensions.getWidth(context) * 0.75,
                  child: Text(
                    "Book a Bus 🚌",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.headlineMedium,
                  ),
                ),
                20.height,
                CustomTextField(
                  heading: "From",
                  textEditingController: fromController,
                  hintText: "",
                  readOnly: false,
                  borderColor: AppColors.errorColor500,
                ),
                Consumer<BusProvider>(
                  builder: (context, data, child) {
                    return Column(
                      children: [
                        CustomDropDownButton(
                          onChanged: data.setSelectedCity,
                          items: data.cities,
                          placeHolder: "Select City",
                          heading: "To",
                          showHeading: true,
                          item: data.selectedCity,
                          borderColor: AppColors.errorColor500,
                        ),
                        30.height,
                        CustomButton(
                          onTap: () {
                            router.push(Routes.busRoutes);
                          },
                          borderColor: AppColors.errorColor500,
                          isEnabled: data.selectedCity != null,
                          color: AppColors.errorColor500,
                          title: "Search Buses",
                          textColor: Colors.white,
                        ),
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
