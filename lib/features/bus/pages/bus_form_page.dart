import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hms_app/core/common/widgets/back_button.dart';
import 'package:hms_app/core/common/widgets/button.dart';
import 'package:hms_app/core/common/widgets/dropdown.dart';
import 'package:hms_app/core/helper/date_time.dart';
import 'package:hms_app/core/helper/dimensions.dart';
import 'package:hms_app/core/helper/sized_box_ext.dart';
import 'package:hms_app/core/theme/colors.dart';
import 'package:hms_app/features/bus/models/bus_response_params.dart';
import 'package:hms_app/features/bus/provider/bus_form_provider.dart';
import 'package:provider/provider.dart';

class BusFormPage extends StatefulWidget {
  final String busFormId;
  const BusFormPage({super.key, required this.busFormId});

  @override
  State<BusFormPage> createState() => _BusFormPageState();
}

class _BusFormPageState extends State<BusFormPage> {
  bool willTravelByBus = false;
  String? selectedCity;
  String? selectedRelation;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        context.read<BusFormProvider>().clear();
        context.read<BusFormProvider>().fetchFormDetails(busFormId: widget.busFormId);
      },
    );
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
                    "Bus Form Response",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                20.height,
                Consumer<BusFormProvider>(builder: (context, data, _) {
                  return data.expiresAt != null && data.cities.isNotEmpty
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Expires At : ${DateTimeHelper.formatDateTime(data.expiresAt!)}",
                              style: textTheme.bodyMedium,
                            ),
                            20.height,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(child: Text("Will you travel by Bus ?", style: textTheme.bodyLarge)),
                                Transform.scale(
                                  scale: 0.8,
                                  child: CupertinoSwitch(
                                    activeColor: AppColors.primaryColor900,
                                    value: willTravelByBus,
                                    onChanged: (value) {
                                      willTravelByBus = value;
                                      selectedCity = null;
                                      selectedRelation = null;
                                      setState(() {});
                                    },
                                  ),
                                ),
                              ],
                            ),
                            20.height,
                            if (willTravelByBus)
                              CustomDropDownButton(
                                onChanged: (value) {
                                  selectedCity = value;
                                  setState(() {});
                                },
                                item: selectedCity,
                                items: data.cities,
                                placeHolder: "Select City",
                                heading: "Destination City",
                                showHeading: true,
                              ),
                            if (!willTravelByBus)
                              CustomDropDownButton(
                                onChanged: (value) {
                                  selectedRelation = value;
                                  setState(() {});
                                },
                                item: selectedRelation,
                                items: ["Father", "Mother", "Brother"],
                                placeHolder: "Relation",
                                heading: "Who will you be traveling with?",
                                showHeading: true,
                              ),
                            30.height,
                            CustomButton(
                              onTap: () async {
                                await data.respondToBusForm(
                                    params: BusResponseParams(
                                        destinationCity: selectedCity,
                                        relation: selectedRelation,
                                        willTravelByBus: willTravelByBus),
                                    busFormId: widget.busFormId);
                              },
                              isEnabled: selectedCity != null || selectedRelation != null,
                              title: "Submit Response",
                            ),
                          ],
                        )
                      : 0.height;
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
