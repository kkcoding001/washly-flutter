import 'package:flutter/material.dart';

// class BookingDetailsScreen extends StatelessWidget {
//   const BookingDetailsScreen({
//     super.key,
//     required this.booking,
//   });
//
//   final Map<String, dynamic> booking;

class BookingDetailsScreen extends StatelessWidget {
  const BookingDetailsScreen({
    super.key,
    required this.booking,
    this.onBookingCancelled,
  });

  final Map<String, dynamic> booking;
  final VoidCallback? onBookingCancelled;

  @override
  Widget build(BuildContext context) {
    final String status = booking['status'] ?? 'CONFIRMED';

    return Scaffold(
      backgroundColor: const Color(0xFF0D1215),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 30),
                child: Column(
                  children: [
                    _buildMainBookingCard(status),

                    const SizedBox(height: 24),

                    _buildAppointmentCard(),

                    const SizedBox(height: 24),

                    _buildVehicleCard(),

                    const SizedBox(height: 24),

                    _buildServiceCard(),

                    const SizedBox(height: 24),

                    _buildLocationCard(),

                    const SizedBox(height: 24),

                    // _buildPaymentCard(),

                    // const SizedBox(height: 24),
                    //
                    // Text(
                    //   'Booking ID: ${booking['bookingId'] ?? '#CW-20260820-1042'}',
                    //   style: const TextStyle(
                    //     color: Color(0xFF69717C),
                    //     fontSize: 12,
                    //     fontWeight: FontWeight.w600,
                    //   ),
                    // ),
                    _buildPaymentCard(),

                    if (booking['status'] == 'CONFIRMED' ||
                        booking['status'] == 'RESCHEDULED') ...[
                      const SizedBox(height: 24),
                      _buildCancelBookingButton(context),
                    ],

                    const SizedBox(height: 24),

                    Text(
                      'Booking ID: ${booking['bookingId'] ?? '#CW-20260820-1042'}',
                      style: const TextStyle(
                        color: Color(0xFF69717C),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),



                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // Temporary bottom navigation for matching your UI reference.
      // bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  // ============================================================
  // HEADER
  // ============================================================

  Widget _buildHeader(BuildContext context) {
    return Container(
      height: 64,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xFF20262B),
          ),
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Color(0xFFDCE1EA),
                size: 21,
              ),
            ),
          ),

          const Text(
            'Booking Details',
            style: TextStyle(
              color: Color(0xFFE7E9ED),
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // MAIN BOOKING CARD
  // ============================================================

  Widget _buildMainBookingCard(String status) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 25, 20, 26),
      decoration: BoxDecoration(
        color: const Color(0xFF151A1E),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFF292F35),
        ),
      ),
      child: Column(
        children: [
          _buildStatusBadge(status),

          const SizedBox(height: 27),

          Text(
            booking['service'] ?? 'Premium Wash',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFFE5E8ED),
              fontSize: 23,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 12),

          Text(
            booking['price'] ?? '₹500',
            style: const TextStyle(
              color: Color(0xFFAFC5FF),
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // STATUS
  // ============================================================

  Widget _buildStatusBadge(String status) {
    Color borderColor;
    Color backgroundColor;
    Color textColor;

    switch (status) {
      case 'COMPLETED':
        borderColor = const Color(0xFF008A35);
        backgroundColor = const Color(0xFF07351D);
        textColor = const Color(0xFF65E39A);
        break;

      case 'RESCHEDULED':
        borderColor = const Color(0xFF9A6500);
        backgroundColor = const Color(0xFF392B08);
        textColor = const Color(0xFFFFC247);
        break;

      case 'CANCELLED':
        borderColor = const Color(0xFF8B1B1B);
        backgroundColor = const Color(0xFF3A1111);
        textColor = const Color(0xFFFF8585);
        break;

      case 'IN PROGRESS':
      case 'CONFIRMED':
      default:
        borderColor = const Color(0xFF1769D5);
        backgroundColor = const Color(0xFF102744);
        textColor = const Color(0xFFC1D2F5);
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 7,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: borderColor,
        ),
        boxShadow: [
          BoxShadow(
            color: borderColor.withValues(alpha: 0.15),
            blurRadius: 12,
          ),
        ],
      ),
      child: Text(
        status,
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.3,
        ),
      ),
    );
  }

  // ============================================================
  // APPOINTMENT
  // ============================================================

  Widget _buildAppointmentCard() {
    return _buildSectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(
            Icons.calendar_month_outlined,
            'Appointment',
          ),

          const SizedBox(height: 17),

          Text(
            booking['date'] ?? '20 Aug 2026',
            style: const TextStyle(
              color: Color(0xFFE2E5EA),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            booking['time'] ?? '10:30 AM',
            style: const TextStyle(
              color: Color(0xFF9DA5B1),
              fontSize: 16,
            ),
          ),

          const SizedBox(height: 10),

          Row(
            children: [
              const Icon(
                Icons.access_time,
                color: Color(0xFF9DA5B1),
                size: 15,
              ),
              const SizedBox(width: 8),
              Text(
                booking['duration'] ?? '45 minutes',
                style: const TextStyle(
                  color: Color(0xFF9DA5B1),
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ============================================================
  // VEHICLE
  // ============================================================

  Widget _buildVehicleCard() {
    return _buildSectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(
            Icons.directions_car_outlined,
            'Vehicle',
          ),

          const SizedBox(height: 17),

          Text(
            booking['vehicle'] ?? 'Hyundai Creta',
            style: const TextStyle(
              color: Color(0xFFE2E5EA),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 10),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 5,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFF151A1E),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: const Color(0xFF30363D),
              ),
            ),
            child: Text(
              booking['registration'] ?? 'GJ01AB1234',
              style: const TextStyle(
                color: Color(0xFFB8BEC9),
                fontSize: 11,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.6,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SERVICE
  // ============================================================

  Widget _buildServiceCard() {
    return _buildSectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(
            Icons.local_car_wash_outlined,
            'Service Overview',
          ),

          const SizedBox(height: 24),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                booking['service'] ?? 'Premium Wash',
                style: const TextStyle(
                  color: Color(0xFFE1E4E9),
                  fontSize: 15,
                ),
              ),
              Text(
                booking['price'] ?? '₹500',
                style: const TextStyle(
                  color: Color(0xFFE1E4E9),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),

          const SizedBox(height: 13),

          const Divider(
            color: Color(0xFF2A3035),
            height: 1,
          ),

          const SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Estimated Duration',
                style: TextStyle(
                  color: Color(0xFFB0B6C0),
                  fontSize: 14,
                ),
              ),
              Text(
                booking['duration'] ?? '45 minutes',
                style: const TextStyle(
                  color: Color(0xFFB0B6C0),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ============================================================
  // LOCATION
  // ============================================================

  Widget _buildLocationCard() {
    return _buildSectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(
            Icons.location_on_outlined,
            'Location',
          ),

          const SizedBox(height: 17),

          Text(
            booking['store'] ?? 'Bopal Car Wash',
            style: const TextStyle(
              color: Color(0xFFE1E4E9),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 7),

          Text(
            booking['address'] ??
                'Plot 42, Bopal Main Road, Ahmedabad',
            style: const TextStyle(
              color: Color(0xFFB0B6C0),
              fontSize: 13,
            ),
          ),

          const SizedBox(height: 20),

          // Temporary map area.
          // Replace this with your actual map image later.
          Container(
            height: 128,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFF10161D),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: const Color(0xFF252D35),
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  Icons.map_outlined,
                  color: const Color(0xFF414B58),
                  size: 42,
                ),
                const Icon(
                  Icons.location_on,
                  color: Color(0xFF6D8FDC),
                  size: 30,
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
            height: 46,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFFB8C9F5),
                side: const BorderSide(
                  color: Color(0xFFB1C6FF),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
              child: const Text(
                'Get Directions',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // PAYMENT
  // ============================================================

  Widget _buildPaymentCard() {
    final String paymentStatus =
        booking['paymentStatus'] ?? 'Payment Pending';

    Color statusColor;
    IconData? icon;

    switch (paymentStatus) {
      case 'Paid':
        statusColor = const Color(0xFF00C853);
        icon = Icons.check_circle;
        break;

      case 'No pay':
        statusColor = const Color(0xFFFF4B4B);
        icon = null;
        break;

      default:
        statusColor = const Color(0xFFFFA800);
        icon = Icons.error;
    }

    return _buildSectionCard(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Payment',
                style: TextStyle(
                  color: Color(0xFFB7BDC7),
                  fontSize: 13,
                ),
              ),

              const SizedBox(height: 7),

              Text(
                booking['price'] ?? '₹500',
                style: const TextStyle(
                  color: Color(0xFFE3E6EA),
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),

          Row(
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  color: statusColor,
                  size: 14,
                ),
                const SizedBox(width: 7),
              ],
              Text(
                paymentStatus,
                style: TextStyle(
                  color: statusColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }


  // ============================================================
  // Cancel button
  // ============================================================

  Widget _buildCancelBookingButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: OutlinedButton(
        onPressed: () {
          _showCancelConfirmation(context);
        },
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFFFF6B6B),
          side: const BorderSide(
            color: Color(0xFF6A2D2D),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: const Text(
          'Cancel Booking',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }


  // ============================================================
  // confirmation dialog
  // ============================================================


  // void _showCancelConfirmation(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (dialogContext) {
  //       return AlertDialog(
  //         backgroundColor: const Color(0xFF171C20),
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(18),
  //         ),
  //         title: const Text(
  //           'Cancel Booking?',
  //           style: TextStyle(
  //             color: Color(0xFFE7E9ED),
  //             fontWeight: FontWeight.w700,
  //           ),
  //         ),
  //         content: Text(
  //           'Are you sure you want to cancel your '
  //               '${booking['service'] ?? 'wash'} booking?',
  //           style: const TextStyle(
  //             color: Color(0xFFB8C0CC),
  //             fontSize: 14,
  //           ),
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.pop(dialogContext);
  //             },
  //             child: const Text(
  //               'Keep Booking',
  //               style: TextStyle(
  //                 color: Color(0xFFB8C0CC),
  //               ),
  //             ),
  //           ),
  //           TextButton(
  //             onPressed: () {
  //               Navigator.pop(dialogContext);
  //
  //               // Tell BookingsScreen to remove
  //               // this booking from Upcoming
  //               // and add it to History.
  //               onBookingCancelled?.call();
  //
  //               // Close Booking Details
  //               Navigator.pop(context);
  //             },
  //             child: const Text(
  //               'Cancel Booking',
  //               style: TextStyle(
  //                 color: Color(0xFFFF6B6B),
  //                 fontWeight: FontWeight.w600,
  //               ),
  //             ),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
  void _showCancelConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: const Color(0xFF171C20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          title: const Text(
            'Cancel Booking?',
            style: TextStyle(
              color: Color(0xFFE7E9ED),
              fontWeight: FontWeight.w700,
            ),
          ),
          content: Text(
            'Are you sure you want to cancel your '
                '${booking['service'] ?? 'wash'} booking?',
            style: const TextStyle(
              color: Color(0xFFB8C0CC),
              fontSize: 14,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text(
                'Keep Booking',
                style: TextStyle(
                  color: Color(0xFFB8C0CC),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);

                onBookingCancelled?.call();

                Navigator.pop(context);
              },
              child: const Text(
                'Cancel Booking',
                style: TextStyle(
                  color: Color(0xFFFF6B6B),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }



  // ============================================================
  // COMMON SECTION CARD
  // ============================================================

  Widget _buildSectionCard({
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF1B2024),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF30363B),
        ),
      ),
      child: child,
    );
  }

  Widget _buildSectionHeader(
      IconData icon,
      String title,
      ) {
    return Row(
      children: [
        Icon(
          icon,
          color: const Color(0xFFAEB6C4),
          size: 22,
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(
            color: Color(0xFFB8BEC9),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

}