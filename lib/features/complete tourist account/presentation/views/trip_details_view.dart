import 'package:beyond_the_pramids/core/constants/app_color.dart';
import 'package:beyond_the_pramids/core/utils/size_config.dart';
import 'package:beyond_the_pramids/core/utils/widgets/snack_bar.dart';
import 'package:beyond_the_pramids/features/account%20type/presentation/views/widgets/custom_text_semi_bold.dart';
import 'package:beyond_the_pramids/features/auth/presentation/views/widgets/custom_text_field.dart';
import 'package:beyond_the_pramids/features/complete%20guide%20account/presentation/views/widgets/custom_dropdown_field.dart';
import 'package:beyond_the_pramids/features/complete%20guide%20account/presentation/views/widgets/step_progress_indicator.dart';
import 'package:beyond_the_pramids/features/complete%20tourist%20account/presentation/manager/Trip%20Details/trip_details_cubit.dart';
import 'package:beyond_the_pramids/features/complete%20tourist%20account/presentation/views/widgets/date_picker_bottom_sheet.dart';
import 'package:beyond_the_pramids/features/complete%20tourist%20account/presentation/views/widgets/travelers_counter.dart';
import 'package:beyond_the_pramids/features/onboarding/presentation/views/widgets/custom_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TripDetailsView extends StatefulWidget {
  const TripDetailsView({super.key});

  @override
  State<TripDetailsView> createState() => _TripDetailsViewState();
}

class _TripDetailsViewState extends State<TripDetailsView> {
  static const Map<String, String> _cityKeys = {
    'Cairo': 'city_cairo',
    'Giza': 'city_giza',
    'Alexandria': 'city_alexandria',
    'Luxor': 'city_luxor',
    'Aswan': 'city_aswan',
    'Hurghada': 'city_hurghada',
    'Sharm El Sheikh': 'city_sharm',
    'Dahab': 'city_dahab',
    'Marsa Matrouh': 'city_marsa',
    'Siwa Oasis': 'city_siwa',
    'Fayoum': 'city_fayoum',
    'North Coast': 'city_north_coast',
  };

  static const Map<String, String> _tripTypeKeys = {
    'Adventure': 'trip_type_adventure',
    'Cultural': 'trip_type_cultural',
    'Beach': 'trip_type_beach',
    'Historical': 'trip_type_historical',
    'Relaxation': 'trip_type_relaxation',
  };

  final List<String> cities = [
    'Cairo',
    'Giza',
    'Alexandria',
    'Luxor',
    'Aswan',
    'Hurghada',
    'Sharm El Sheikh',
    'Dahab',
    'Marsa Matrouh',
    'Siwa Oasis',
    'Fayoum',
    'North Coast',
  ];

  final List<String> tripTypes = [
    'Adventure',
    'Cultural',
    'Beach',
    'Historical',
    'Relaxation',
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TripDetailsCubit, TripDetailsState>(
      listener: (context, state) {
        if (state is TripDetailsLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(child: CircularProgressIndicator()),
          );
        } else if (state is TripDetailsSuccess) {
          Navigator.of(context).pop();
          Navigator.pushReplacementNamed(context, '/travelInterestsView');
        } else if (state is TripDetailsError) {
          if (Navigator.of(context).canPop()) Navigator.of(context).pop();
          showSnackBar(context, state.message, isSuccess: false);
        }
      },
      builder: (context, state) {
        final cubit = context.read<TripDetailsCubit>();

        return Scaffold(
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 30.h),
                        const StepProgressIndicator(currentStep: 2),
                        SizedBox(height: 36.h),

                        // Travel Date
                        CustomTextSemiBold(
                          fontSize: 16.sp,
                          text: 'trip_travel_date'.tr(),
                        ),
                        SizedBox(height: 8.h),
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20),
                                ),
                              ),
                              builder:
                                  (context) => DatePickerBottomSheet(
                                    onDateRangeSelected: (from, to) {
                                      setState(() {
                                        cubit.fromDate = from;
                                        cubit.toDate = to;
                                      });
                                    },
                                  ),
                            );
                          },
                          child: CustomTextField(
                            hintText:
                                cubit.fromDate != null && cubit.toDate != null
                                    ? '${DateFormat('dd/MM/yyyy').format(cubit.fromDate!)} - ${DateFormat('dd/MM/yyyy').format(cubit.toDate!)}'
                                    : 'trip_select_date'.tr(),
                            suffixIcon: Icon(
                              Icons.calendar_month_sharp,
                              color: AppColor.secondaryColor,
                            ),
                            enabled: false,
                          ),
                        ),

                        SizedBox(height: 16.h),

                        // Destination City
                        CustomTextSemiBold(
                          fontSize: 16.sp,
                          text: 'trip_destination_city'.tr(),
                        ),
                        SizedBox(height: 8.h),
                        CustomDropdownField(
                          hint: 'trip_select_destination'.tr(),
                          items: cities,
                          value: cubit.destinationCity,
                          displayMapper:
                              (item) => (_cityKeys[item] ?? item).tr(),
                          onChanged: (value) {
                            setState(() => cubit.destinationCity = value);
                          },
                        ),

                        SizedBox(height: 16.h),

                        // Trip Type
                        CustomTextSemiBold(
                          fontSize: 16.sp,
                          text: 'trip_type'.tr(),
                        ),
                        SizedBox(height: 8.h),
                        CustomDropdownField(
                          hint: 'trip_select_type'.tr(),
                          items: tripTypes,
                          value: cubit.tripType,
                          displayMapper:
                              (item) => (_tripTypeKeys[item] ?? item).tr(),
                          onChanged: (value) {
                            setState(() => cubit.tripType = value);
                          },
                        ),

                        SizedBox(height: 16.h),

                        Row(
                          children: [
                            Expanded(
                              child: CustomTextSemiBold(
                                fontSize: 16.sp,
                                text: 'trip_how_many_travelers'.tr(),
                              ),
                            ),
                            TravelersCounter(
                              initialValue: cubit.numberOfTravelers,
                              min: 1,
                              max: 20,
                              onChanged: (val) {
                                setState(() => cubit.numberOfTravelers = val);
                              },
                            ),
                          ],
                        ),

                        SizedBox(height: 24.h),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          bottomNavigationBar: SizedBox(
            height: 150.h,
            child: Center(
              child: CustomButton(
                text: 'next'.tr(),
                width: 230.w,
                onTap: () {
                  cubit.submitTravelInfo();
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
