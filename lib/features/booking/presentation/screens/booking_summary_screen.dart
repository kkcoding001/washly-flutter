import 'package:flutter/material.dart';
import 'booking_confirmation_screen.dart';

class BookingSummaryScreen extends StatelessWidget {
  final Map<String, String> selectedVehicle;
  final Map<String, dynamic> selectedService;
  final Map<String, dynamic> selectedStore;
  final DateTime selectedDate;
  final String selectedTime;

  const BookingSummaryScreen({
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
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Review your booking',
                      style: TextStyle(
                        color: Color(0xFFE8EAF0),
                        fontSize: 23,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 4),

                    const Text(
                      'Make sure everything looks correct before\nconfirming.',
                      style: TextStyle(
                        color: Color(0xFFB8C0CC),
                        fontSize: 15,
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 40),

                    // Vehicle
                    _buildVehicleCard(),

                    const SizedBox(height: 12),

                    // Service
                    _buildServiceCard(),

                    const SizedBox(height: 12),

                    // Location
                    _buildLocationCard(),

                    const SizedBox(height: 12),

                    // Date & Time
                    _buildDateTimeCard(),

                    const SizedBox(height: 24),

                    // Divider
                    Container(
                      height: 1,
                      color: const Color(0xFF252B31),
                    ),

                    const SizedBox(height: 16),

                    // Total
                    _buildTotal(),

                    const SizedBox(height: 26),

                    // Continue
                    _buildContinueButton(context),
                  ],
                ),
              ),
            ),

            // _buildBottomNavigation(),
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
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Color(0xFFD7DDE8),
              size: 24,
            ),
          ),

          const Expanded(
            child: Center(
              child: Text(
                'Book a Wash',
                style: TextStyle(
                  color: Color(0xFFE8EAF0),
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),

          const SizedBox(width: 48),
        ],
      ),
    );
  }

  // ============================================================
  // VEHICLE CARD
  // ============================================================

  Widget _buildVehicleCard() {
    final String vehicleModel =
        selectedVehicle['model'] ?? 'Vehicle';

    final String registration =
        selectedVehicle['registration'] ?? '';

    final String vehicleType =
        selectedVehicle['type'] ?? 'SUV';

    return _buildSummaryCard(
      title: 'VEHICLE',
      icon: Icons.directions_car_outlined,
      child: Row(
        children: [
          _buildIconCircle(
            Icons.directions_car_outlined,
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  vehicleModel,
                  style: const TextStyle(
                    color: Color(0xFFE1E4E9),
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  '$registration • $vehicleType',
                  style: const TextStyle(
                    color: Color(0xFFB8C0CC),
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SERVICE CARD
  // ============================================================

  Widget _buildServiceCard() {
    final String serviceName =
        selectedService['name'] ?? 'Wash Service';

    final String description =
        selectedService['description'] ??
            '';

    final String duration =
        selectedService['duration']?.toString() ??
            '';

    final String price =
        selectedService['price']?.toString() ??
            '0';

    return _buildSummaryCard(
      title: 'SERVICE',
      icon: Icons.local_car_wash_outlined,
      child: Row(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          _buildIconCircle(
            Icons.local_car_wash_outlined,
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  serviceName,
                  style: const TextStyle(
                    color: Color(0xFFE1E4E9),
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  description,
                  maxLines: 2,
                  overflow:
                  TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFFB8C0CC),
                    fontSize: 14,
                    height: 1.3,
                  ),
                ),

                const SizedBox(height: 5),

                Row(
                  children: [
                    const Icon(
                      Icons.access_time,
                      color: Color(0xFFB8C0CC),
                      size: 15,
                    ),

                    const SizedBox(width: 4),

                    Text(
                      duration.contains('min')
                          ? duration
                          : '$duration min',
                      style: const TextStyle(
                        color: Color(0xFFB8C0CC),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          Text(
            price.startsWith('₹') ? price : '₹$price',
            style: const TextStyle(
              color: Color(0xFFE1E4E9),
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // LOCATION CARD
  // ============================================================

  Widget _buildLocationCard() {
    final String storeName =
        selectedStore['name'] ?? 'Car Wash';

    final String location =
        selectedStore['location'] ?? '';

    return _buildSummaryCard(
      title: 'LOCATION',
      icon: Icons.location_on_outlined,
      child: Row(
        children: [
          _buildIconCircle(
            Icons.location_on_outlined,
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  storeName,
                  style: const TextStyle(
                    color: Color(0xFFE1E4E9),
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  location,
                  style: const TextStyle(
                    color: Color(0xFFB8C0CC),
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // DATE & TIME CARD
  // ============================================================

  Widget _buildDateTimeCard() {
    return _buildSummaryCard(
      title: 'DATE & TIME',
      icon: Icons.calendar_month_outlined,
      child: Row(
        children: [
          _buildIconCircle(
            Icons.calendar_month_outlined,
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  _formatDate(selectedDate),
                  style: const TextStyle(
                    color: Color(0xFFE1E4E9),
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  selectedTime,
                  style: const TextStyle(
                    color: Color(0xFFB8C0CC),
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SUMMARY CARD
  // ============================================================

  Widget _buildSummaryCard({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        24,
        22,
        24,
        22,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF171C20),
        borderRadius:
        BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF252B31),
        ),
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFFB8C0CC),
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),

          const SizedBox(height: 14),

          child,
        ],
      ),
    );
  }

  // ============================================================
  // ICON CIRCLE
  // ============================================================

  Widget _buildIconCircle(IconData icon) {
    return Container(
      width: 42,
      height: 42,
      decoration: const BoxDecoration(
        color: Color(0xFF2A3036),
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        color: Color(0xFF9DBBFF),
        size: 22,
      ),
    );
  }

  // ============================================================
  // TOTAL
  // ============================================================

  Widget _buildTotal() {
    final String price =
        selectedService['price']?.toString() ??
            '0';

    return Row(
      mainAxisAlignment:
      MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Total',
          style: TextStyle(
            color: Color(0xFFE1E4E9),
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),

        Text(
          price.startsWith('₹') ? price : '₹$price',
          style: const TextStyle(
            color: Color(0xFFE1E4E9),
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // CONTINUE BUTTON
  // ============================================================

  Widget _buildContinueButton(
      BuildContext context,
      ) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  BookingConfirmationScreen(
                    selectedVehicle:
                    selectedVehicle,
                    selectedService:
                    selectedService,
                    selectedStore:
                    selectedStore,
                    selectedDate:
                    selectedDate,
                    selectedTime:
                    selectedTime,
                  ),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor:
          const Color(0xFF2878E8),
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(11),
          ),
        ),
        child: const Row(
          mainAxisAlignment:
          MainAxisAlignment.center,
          children: [
            Text(
              'Confirm Booking',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),

            SizedBox(width: 8),

            Icon(
              Icons.arrow_forward,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // BOTTOM NAVIGATION
  // ============================================================

  // Widget _buildBottomNavigation() {
  //   return Container(
  //     height: 78,
  //     decoration: const BoxDecoration(
  //       color: Color(0xFF0B0F12),
  //       border: Border(
  //         top: BorderSide(
  //           color: Color(0xFF252B31),
  //         ),
  //       ),
  //     ),
  //     child: Row(
  //       mainAxisAlignment:
  //       MainAxisAlignment.spaceAround,
  //       children: [
  //         _buildNavItem(
  //           Icons.home,
  //           'Home',
  //           true,
  //         ),
  //
  //         _buildNavItem(
  //           Icons.calendar_month_outlined,
  //           'Bookings',
  //           false,
  //         ),
  //
  //         _buildNavItem(
  //           Icons.notifications_none,
  //           'Notifications',
  //           false,
  //         ),
  //
  //         _buildNavItem(
  //           Icons.person_outline,
  //           'Profile',
  //           false,
  //         ),
  //       ],
  //     ),
  //   );
  // }

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
          height: active ? 42 : 42,
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

  String _formatDate(DateTime date) {
    const List<String> weekdays = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];

    const List<String> months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    return '${weekdays[date.weekday - 1]}, '
        '${date.day} '
        '${months[date.month - 1]} '
        '${date.year}';
  }
}