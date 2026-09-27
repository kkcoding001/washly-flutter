import 'package:flutter/material.dart';

import 'booking_details_screen.dart';

class BookingsScreen extends StatefulWidget {
  const BookingsScreen({
    super.key,
    required this.onBackToHome,
  });

  final VoidCallback onBackToHome;

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> {
  bool _showUpcoming = true;

  final Color _backgroundColor = const Color(0xFF0D1215);
  final Color _cardColor = const Color(0xFF1B2024);
  final Color _blue = const Color(0xFF2878E8);
  final Color _lightBlue = const Color(0xFFAFC5FF);
  final Color _primaryText = const Color(0xFFE7E9ED);
  final Color _secondaryText = const Color(0xFFB4BAC5);

  final List<Map<String, dynamic>> _upcomingBookings = [
    {
      'status': 'CONFIRMED',
      'statusColor': Color(0xFF2878E8),
      'service': 'Premium Wash',
      'vehicle': 'Hyundai Creta',
      'registration': 'GJ01AB1234',
      'price': '₹500',
      'date': '20 Aug 2026',
      'time': '10:30 AM',
      'duration': '45 minutes',
      'store': 'Bopal Car Wash',
      'address': 'Plot 42, Bopal Main Road, Ahmedabad',
      'paymentStatus': 'Payment Pending',
      'bookingId': '#CW-20260820-1042',
    },
    {
      'status': 'IN PROGRESS',
      'statusColor': Color(0xFF2878E8),
      'service': 'Full Detailing',
      'vehicle': 'Hyundai Creta',
      'registration': 'GJ01AB1234',
      'price': '₹800',
      'date': '20 Aug 2026',
      'time': '09:30 AM',
      'duration': '60 minutes',
      'store': 'Bopal Car Wash',
      'address': 'Plot 42, Bopal Main Road, Ahmedabad',
      'paymentStatus': 'Payment Pending',
      'bookingId': '#CW-20260820-1042',
    },
    {
      'status': 'RESCHEDULED',
      'statusColor': Color(0xFF9A6500),
      'service': 'Premium Wash',
      'vehicle': 'Hyundai Creta',
      'registration': 'GJ01AB1234',
      'price': '₹500',
      'date': '22 Aug 2026',
      'time': '11:30 AM',
      'duration': '45 minutes',
      'store': 'Bopal Car Wash',
      'address': 'Plot 42, Bopal Main Road, Ahmedabad',
      'paymentStatus': 'Payment Pending',
      'bookingId': '#CW-20260820-1042',
    },
  ];

  final List<Map<String, dynamic>> _historyBookings = [
    {
      'status': 'COMPLETED',
      'statusColor': Color(0xFF00A63C),
      'service': 'Premium Wash',
      'vehicle': 'Hyundai Creta',
      'registration': 'GJ01AB1234',
      'price': '₹500',
      'date': '20 Aug 2026',
      'time': '10:30 AM',
      'duration': '45 minutes',
      'store': 'Bopal Car Wash',
      'address': 'Plot 42, Bopal Main Road, Ahmedabad',
      'paymentStatus': 'Paid',
      'bookingId': '#CW-20260820-1042',
    },
    {
      'status': 'CANCELLED',
      'statusColor': Color(0xFFC90000),
      'service': 'Premium Wash',
      'vehicle': 'Hyundai Creta',
      'registration': 'GJ01AB1234',
      'price': '₹500',
      'date': '22 Aug 2026',
      'time': '11:30 AM',
      'duration': '45 minutes',
      'store': 'Bopal Car Wash',
      'address': 'Plot 42, Bopal Main Road, Ahmedabad',
      'paymentStatus': 'No pay',
      'bookingId': '#CW-20260820-1042',
    },
    {
      'status': 'COMPLETED',
      'statusColor': Color(0xFF00A63C),
      'service': 'Full Detailing',
      'vehicle': 'Hyundai Creta',
      'registration': 'GJ01AB1234',
      'price': '₹800',
      'date': '12 Aug 2026',
      'time': '10:30 AM',
      'duration': '60 minutes',
      'store': 'Bopal Car Wash',
      'address': 'Plot 42, Bopal Main Road, Ahmedabad',
      'paymentStatus': 'Paid',
      'bookingId': '#CW-20260820-1042',
    }
  ];

  // void _openBookingDetails(Map<String, dynamic> booking) {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => BookingDetailsScreen(
  //         booking: booking,
  //       ),
  //     ),
  //   );
  // }
  // void _openBookingDetails(Map<String, dynamic> booking) {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => BookingDetailsScreen(
  //         booking: booking,
  //         onBookingCancelled:
  //         booking['status'] == 'CONFIRMED' ||
  //             booking['status'] == 'RESCHEDULED'
  //             ? () {
  //           _cancelBooking(booking);
  //         }
  //             : null,
  //       ),
  //     ),
  //   );
  // }
  void _openBookingDetails(Map<String, dynamic> booking) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BookingDetailsScreen(
          booking: booking,
          onBookingCancelled: () {
            _moveBookingToCancelled(booking);
          },
        ),
      ),
    );
  }

  void _cancelBooking(Map<String, dynamic> booking) {
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
            'Are you sure you want to cancel your ${booking['service']} booking?',
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

                setState(() {
                  // Remove from upcoming
                  _upcomingBookings.remove(booking);

                  // Create cancelled booking
                  final cancelledBooking =
                  Map<String, dynamic>.from(booking);

                  cancelledBooking['status'] = 'CANCELLED';
                  cancelledBooking['statusColor'] =
                  const Color(0xFFC90000);
                  cancelledBooking['paymentStatus'] = 'No pay';

                  // Add to history
                  _historyBookings.insert(
                    0,
                    cancelledBooking,
                  );
                });
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

  // void _moveBookingToCancelled(Map<String, dynamic> booking) {
  //   setState(() {
  //     _upcomingBookings.remove(booking);
  //
  //     final cancelledBooking =
  //     Map<String, dynamic>.from(booking);
  //
  //     cancelledBooking['status'] = 'CANCELLED';
  //     cancelledBooking['statusColor'] =
  //     const Color(0xFFC90000);
  //     cancelledBooking['paymentStatus'] = 'No pay';
  //
  //     _historyBookings.insert(
  //       0,
  //       cancelledBooking,
  //     );
  //   });
  // }
  void _moveBookingToCancelled(Map<String, dynamic> booking) {
    setState(() {
      _upcomingBookings.remove(booking);

      final cancelledBooking =
      Map<String, dynamic>.from(booking);

      cancelledBooking['status'] = 'CANCELLED';
      cancelledBooking['statusColor'] =
      const Color(0xFFC90000);
      cancelledBooking['paymentStatus'] = 'No pay';

      _historyBookings.insert(
        0,
        cancelledBooking,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final bookings =
    _showUpcoming ? _upcomingBookings : _historyBookings;

    return Scaffold(
      backgroundColor: _backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: Column(
                children: [
                  _buildTabSwitcher(),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
                      itemCount: bookings.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 24),
                          child: _showUpcoming
                              ? _buildUpcomingCard(bookings[index])
                              : _buildHistoryCard(bookings[index]),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  // ------------------------------------------------------------
  // HEADER
  // ------------------------------------------------------------

  Widget _buildHeader() {
    return SizedBox(
      height: 64,
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Color(0xFF20262B),
              width: 1,
            ),
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                onPressed: widget.onBackToHome,
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  size: 21,
                  color: Color(0xFFDCE1EA),
                ),
              ),
            ),

            Text(
              'Bookings',
              style: TextStyle(
                color: _primaryText,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            )

            // Align(
            //   alignment: Alignment.centerRight,
            //   child: IconButton(
            //     onPressed: () {},
            //     icon: const Icon(
            //       Icons.search,
            //       size: 25,
            //       color: Color(0xFFDCE1EA),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  // UPCOMING / HISTORY SWITCHER
  // ------------------------------------------------------------

  Widget _buildTabSwitcher() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      height: 46,
      decoration: BoxDecoration(
        color: const Color(0xFF161B1F),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF262D32),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildTabButton(
              title: 'Upcoming',
              selected: _showUpcoming,
              onTap: () {
                setState(() {
                  _showUpcoming = true;
                });
              },
            ),
          ),
          Expanded(
            child: _buildTabButton(
              title: 'History',
              selected: !_showUpcoming,
              onTap: () {
                setState(() {
                  _showUpcoming = false;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton({
    required String title,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xFF193154)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(9),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
            color: selected
                ? const Color(0xFFB8CBF3)
                : const Color(0xFFB7BBC4),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  // UPCOMING CARD
  // ------------------------------------------------------------

  Widget _buildUpcomingCard(Map<String, dynamic> booking) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF343A3F),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // STATUS + PRICE
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildStatusBadge(
                booking['status'],
                booking['statusColor'],
              ),
              Text(
                booking['price'],
                style: TextStyle(
                  color: _primaryText,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          Text(
            booking['service'],
            style: TextStyle(
              color: _primaryText,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            '${booking['vehicle']} (${booking['registration']})',
            style: TextStyle(
              color: _secondaryText,
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),

          const SizedBox(height: 25),

          Row(
            children: [
              _buildInfoItem(
                Icons.calendar_month_outlined,
                booking['date'],
              ),
              const SizedBox(width: 42),
              _buildInfoItem(
                Icons.access_time,
                booking['time'],
              ),
            ],
          ),

          const SizedBox(height: 16),

          _buildInfoItem(
            Icons.location_on_outlined,
            booking['store'],
          ),

          const SizedBox(height: 25),

          // SizedBox(
          //   width: double.infinity,
          //   height: 45,
          //   child: ElevatedButton(
          //     onPressed: () {
          //       _openBookingDetails(booking);
          //     },
          //     style: ElevatedButton.styleFrom(
          //       backgroundColor: _lightBlue,
          //       foregroundColor: const Color(0xFF092E68),
          //       elevation: 0,
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(8),
          //       ),
          //     ),
          //     child: const Text(
          //       'View Details →',
          //       style: TextStyle(
          //         fontSize: 14,
          //         fontWeight: FontWeight.w700,
          //       ),
          //     ),
          //   ),
          // ),


          Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  onPressed: () {
                    _openBookingDetails(booking);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _lightBlue,
                    foregroundColor: const Color(0xFF092E68),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'View Details →',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),

              // Cancel button
              if (booking['status'] == 'CONFIRMED' ||
                  booking['status'] == 'RESCHEDULED') ...[
                const SizedBox(height: 10),

                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: OutlinedButton(
                    onPressed: () {
                      _cancelBooking(booking);
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
                ),
              ],
            ],
          ),



        ],
      ),
    );
  }

  // ------------------------------------------------------------
  // HISTORY CARD
  // ------------------------------------------------------------

  Widget _buildHistoryCard(Map<String, dynamic> booking) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
      decoration: BoxDecoration(
        color: _cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF30363B),
        ),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // VEHICLE ICON BOX
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: const Color(0xFF2C3338),
                  ),
                ),
                child: const Icon(
                  Icons.directions_car_outlined,
                  color: Color(0xFFC2C7D1),
                  size: 23,
                ),
              ),

              const SizedBox(width: 24),

              // DETAILS
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      booking['service'],
                      style: TextStyle(
                        color: _primaryText,
                        fontSize: 19,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      '${booking['vehicle']} • ${booking['registration']}',
                      style: TextStyle(
                        color: _secondaryText,
                        fontSize: 15,
                      ),
                    ),

                    const SizedBox(height: 8),

                    _buildHistoryInfo(
                      Icons.calendar_month_outlined,
                      '${booking['date']}, ${booking['time']}',
                    ),

                    const SizedBox(height: 7),

                    _buildHistoryInfo(
                      Icons.location_on_outlined,
                      booking['store'],
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              _buildStatusBadge(
                booking['status'],
                booking['statusColor'],
              ),
            ],
          ),

          const SizedBox(height: 10),

          Divider(
            color: const Color(0xFF30363B),
            height: 1,
          ),

          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                booking['price'],
                style: TextStyle(
                  color: _primaryText,
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                ),
              ),

              SizedBox(
                height: 41,
                child: ElevatedButton(
                  onPressed: () {
                    _openBookingDetails(booking);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _lightBlue,
                    foregroundColor: const Color(0xFF092E68),
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'View Details ›',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ------------------------------------------------------------
  // COMMON WIDGETS
  // ------------------------------------------------------------

  Widget _buildStatusBadge(
      String status,
      Color color,
      ) {
    final bool rescheduled = status == 'RESCHEDULED';

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: rescheduled
              ? const Color(0xFFFFB875)
              : Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.3,
        ),
      ),
    );
  }

  Widget _buildInfoItem(
      IconData icon,
      String text,
      ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 18,
          color: const Color(0xFFB8BEC9),
        ),
        const SizedBox(width: 6),
        Text(
          text,
          style: TextStyle(
            color: _secondaryText,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildHistoryInfo(
      IconData icon,
      String text,
      ) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: const Color(0xFF8D95A3),
        ),
        const SizedBox(width: 5),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: const Color(0xFF929AA8),
              fontSize: 14,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

}