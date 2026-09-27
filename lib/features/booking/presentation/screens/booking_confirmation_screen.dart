import 'package:flutter/material.dart';

import 'booking_details_screen.dart';

class BookingConfirmationScreen extends StatelessWidget {
  final Map<String, String> selectedVehicle;
  final Map<String, dynamic> selectedService;
  final Map<String, dynamic> selectedStore;
  final DateTime selectedDate;
  final String selectedTime;

  const BookingConfirmationScreen({
    super.key,
    required this.selectedVehicle,
    required this.selectedService,
    required this.selectedStore,
    required this.selectedDate,
    required this.selectedTime,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0F12),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  20,
                  28,
                  20,
                  24,
                ),
                child: Column(
                  children: [
                    _buildSuccessIcon(),

                    const SizedBox(height: 24),

                    const Text(
                      'Booking Confirmed',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFFE8EAF0),
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 4),

                    const Text(
                      'Your wash has been successfully\nscheduled.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFFB8C0CC),
                        fontSize: 15,
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 64),

                    _buildBookingCard(),

                    const SizedBox(height: 64),

                    _buildViewDetailsButton(context),

                    const SizedBox(height: 24),

                    GestureDetector(
                      onTap: () {
                        // Navigator.of(context).pushNamedAndRemoveUntil(
                        //   '/home',
                        //       (route) => false,
                        // );
                        Navigator.of(context).popUntil(
                              (route) => route.settings.name == '/home',
                        );
                      },
                      child: const Text(
                        'Back to Home',
                        style: TextStyle(
                          color: Color(0xFFB8C0CC),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                    const SizedBox(height: 34),

                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  // ============================================================
  // HEADER
  // ============================================================

  Widget _buildHeader(BuildContext context) {
    return Container(
      height: 60,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xFF252B31),
          ),
        ),
      ),
      child: const Center(
        child: Text(
          'Book a Wash',
          style: TextStyle(
            color: Color(0xFFE8EAF0),
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  // ============================================================
  // SUCCESS ICON
  // ============================================================

  Widget _buildSuccessIcon() {
    return Container(
      width: 96,
      height: 96,
      decoration: BoxDecoration(
        color: const Color(0xFF2878E8),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2878E8)
                .withOpacity(0.28),
            blurRadius: 28,
            spreadRadius: 6,
          ),
        ],
      ),
      child: Center(
        child: Container(
          width: 42,
          height: 42,
          decoration: const BoxDecoration(
            color: Color(0xFFEFF4FF),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.check,
            color: Color(0xFF2878E8),
            size: 30,
          ),
        ),
      ),
    );
  }

  // ============================================================
  // BOOKING CARD
  // ============================================================

  Widget _buildBookingCard() {
    final String bookingId =
    _generateBookingId();

    final String serviceName =
        selectedService['name']?.toString() ??
            'Wash Service';

    final String vehicleModel =
        selectedVehicle['model'] ?? 'Vehicle';

    final String registration =
        selectedVehicle['registration'] ?? '';

    final String storeName =
        selectedStore['name']?.toString() ??
            'Car Wash Center';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        24,
        24,
        24,
        24,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF171C20),
        borderRadius:
        BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF252B31),
        ),
      ),
      child: Column(
        children: [
          // Booking ID + Status
          Row(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'BOOKING ID',
                      style: TextStyle(
                        color: Color(0xFFB8C0CC),
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.6,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      bookingId,
                      style: const TextStyle(
                        color: Color(0xFF9DBBFF),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.4,
                      ),
                    ),
                  ],
                ),
              ),

              _buildConfirmedBadge(),
            ],
          ),

          const SizedBox(height: 16),

          Container(
            height: 1,
            color: const Color(0xFF252B31),
          ),

          const SizedBox(height: 26),

          // Service + Vehicle
          Row(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildInfoItem(
                  icon:
                  Icons.local_car_wash_outlined,
                  label: 'SERVICE',
                  value: serviceName,
                ),
              ),

              const SizedBox(width: 20),

              Expanded(
                child: _buildInfoItem(
                  icon:
                  Icons.directions_car_outlined,
                  label: 'VEHICLE',
                  value: vehicleModel,
                  secondaryValue:
                  registration,
                ),
              ),
            ],
          ),

          const SizedBox(height: 26),

          // Date + Time
          Row(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildInfoItem(
                  icon:
                  Icons.calendar_today_outlined,
                  label: 'DATE',
                  value: _formatShortDate(
                    selectedDate,
                  ),
                ),
              ),

              const SizedBox(width: 20),

              Expanded(
                child: _buildInfoItem(
                  icon: Icons.access_time,
                  label: 'TIME',
                  value: selectedTime,
                ),
              ),
            ],
          ),

          const SizedBox(height: 26),

          // Location
          _buildInfoItem(
            icon: Icons.location_on_outlined,
            label: 'LOCATION',
            value: storeName,
          ),
        ],
      ),
    );
  }

  // ============================================================
  // CONFIRMED BADGE
  // ============================================================

  Widget _buildConfirmedBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF123A29),
        borderRadius:
        BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF1D6846),
        ),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.circle,
            color: Color(0xFF4ADE80),
            size: 6,
          ),

          SizedBox(width: 7),

          Text(
            'CONFIRMED',
            style: TextStyle(
              color: Color(0xFF4ADE80),
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.7,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // INFO ITEM
  // ============================================================

  Widget _buildInfoItem({
    required IconData icon,
    required String label,
    required String value,
    String? secondaryValue,
  }) {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: const Color(0xFFB8C0CC),
              size: 15,
            ),

            const SizedBox(width: 8),

            Text(
              label,
              style: const TextStyle(
                color: Color(0xFFB8C0CC),
                fontSize: 11,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),

        const SizedBox(height: 8),

        Text(
          value,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Color(0xFFE1E4E9),
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),

        if (secondaryValue != null &&
            secondaryValue.isNotEmpty) ...[
          const SizedBox(height: 5),

          Text(
            secondaryValue,
            style: const TextStyle(
              color: Color(0xFFB8C0CC),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ],
    );
  }

  // ============================================================
  // VIEW BOOKING DETAILS
  // ============================================================

  // Widget _buildViewDetailsButton(
  //     BuildContext context,
  //     ) {
  //   return SizedBox(
  //     width: double.infinity,
  //     height: 56,
  //     child: ElevatedButton(
  //       onPressed: () {
  //         // Booking details screen
  //         // will be connected here later.
  //       },
  //       style: ElevatedButton.styleFrom(
  //         backgroundColor:
  //         const Color(0xFF2878E8),
  //         foregroundColor: Colors.white,
  //         elevation: 0,
  //         shape: RoundedRectangleBorder(
  //           borderRadius:
  //           BorderRadius.circular(11),
  //         ),
  //       ),
  //       child: const Row(
  //         mainAxisAlignment:
  //         MainAxisAlignment.center,
  //         children: [
  //           Text(
  //             'View Booking Details',
  //             style: TextStyle(
  //               fontSize: 14,
  //               fontWeight: FontWeight.w600,
  //             ),
  //           ),
  //
  //           SizedBox(width: 9),
  //
  //           Icon(
  //             Icons.arrow_forward,
  //             size: 20,
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _buildViewDetailsButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BookingDetailsScreen(
                booking: {
                  'status': 'CONFIRMED',
                  'service':
                  selectedService['name']?.toString() ?? 'Wash Service',
                  'vehicle':
                  selectedVehicle['model'] ?? 'Vehicle',
                  'registration':
                  selectedVehicle['registration'] ?? '',
                  'price':
                  selectedService['price']?.toString() ?? '₹0',
                  'date': _formatShortDate(selectedDate),
                  'time': selectedTime,
                  'duration':
                  selectedService['duration']?.toString() ?? '',
                  'store':
                  selectedStore['name']?.toString() ??
                      'Car Wash Center',
                  'address':
                  selectedStore['location']?.toString() ?? '',
                  'paymentStatus': 'Payment Pending',
                  'bookingId': _generateBookingId(),
                },
              ),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2878E8),
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(11),
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'View Booking Details',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(width: 9),
            Icon(
              Icons.arrow_forward,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(
      IconData icon,
      String label,
      bool active,
      ) {
    return Column(
      mainAxisAlignment:
      MainAxisAlignment.center,
      children: [
        Container(
          width: active ? 66 : 50,
          height: 42,
          decoration: active
              ? BoxDecoration(
            color: const Color(0xFF2878E8),
            borderRadius:
            BorderRadius.circular(24),
          )
              : null,
          child: Icon(
            icon,
            color: active
                ? Colors.white
                : const Color(0xFFB8C0CC),
            size: 24,
          ),
        ),

        const SizedBox(height: 2),

        Text(
          label,
          style: TextStyle(
            color: active
                ? const Color(0xFFE1E4E9)
                : const Color(0xFFB8C0CC),
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // DATE FORMAT
  // ============================================================

  String _formatShortDate(DateTime date) {
    const List<String> months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    return '${date.day} '
        '${months[date.month - 1]} '
        '${date.year}';
  }

  // ============================================================
  // TEMPORARY BOOKING ID
  // ============================================================

  String _generateBookingId() {
    final now = DateTime.now();

    final String date =
        '${now.year}'
        '${now.month.toString().padLeft(2, '0')}'
        '${now.day.toString().padLeft(2, '0')}';

    final String time =
        '${now.hour.toString().padLeft(2, '0')}'
        '${now.minute.toString().padLeft(2, '0')}';

    return '#CW-$date-$time';
  }
}