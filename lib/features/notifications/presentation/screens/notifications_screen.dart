import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({
    super.key,
    required this.onBackToHome,
  });

  final VoidCallback onBackToHome;

  @override
  State<NotificationsScreen> createState() =>
      _NotificationsScreenState();
}

class _NotificationsScreenState
    extends State<NotificationsScreen> {
  String _selectedFilter = 'All Notifications';

  final List<Map<String, dynamic>> _todayNotifications = [
    {
      'type': 'payment',
      'title': 'Payment Successfully',
      'message': 'Payment of ₹500 was successfully recorded.',
      'time': '10:40 AM',
      'unread': true,
    },
    {
      'type': 'wash',
      'title': 'Wash Completed',
      'message':
      'Your Premium Wash is completed for 20 Aug at 10:30 AM.',
      'time': '10:30 AM',
      'unread': true,
    },
    {
      'type': 'booking',
      'title': 'Booking Confirmed',
      'message':
      'Your Premium Wash is confirmed for 20 Aug at 9:30 AM.',
      'time': '9:30 AM',
      'unread': true,
    },
  ];

  final List<Map<String, dynamic>> _earlierNotifications = [
    {
      'type': 'rescheduled',
      'title': 'Booking Rescheduled',
      'message': 'Your appointment has been moved to 11:00 AM.',
      'time': 'Yesterday',
      'unread': false,
    },
    {
      'type': 'completed',
      'title': 'Wash Completed',
      'message': 'Your Premium Wash has been completed.',
      'time': '2 days ago',
      'unread': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1215),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(
                  20,
                  12,
                  20,
                  30,
                ),
                children: [
                  // _buildFilterDropdown(),

                  // const SizedBox(height: 22),

                  _buildSectionTitle('TODAY'),

                  const SizedBox(height: 13),

                  ..._todayNotifications.map(
                        (notification) =>
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 9,
                          ),
                          child: _buildNotificationCard(
                            notification,
                          ),
                        ),
                  ),

                  const SizedBox(height: 26),

                  _buildSectionTitle('EARLIER'),

                  const SizedBox(height: 13),

                  ..._earlierNotifications.map(
                        (notification) =>
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 9,
                          ),
                          child: _buildNotificationCard(
                            notification,
                          ),
                        ),
                  ),
                ],
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

  Widget _buildHeader() {
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
              onPressed: widget.onBackToHome,
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Color(0xFFDCE1EA),
                size: 21,
              ),
            ),
          ),

          const Text(
            'Notifications',
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
  // FILTER
  // ============================================================

  // Widget _buildFilterDropdown() {
  //   return Container(
  //     height: 43,
  //     decoration: BoxDecoration(
  //       color: const Color(0xFF191E22),
  //       borderRadius: BorderRadius.circular(11),
  //       border: Border.all(
  //         color: const Color(0xFF2B3136),
  //       ),
  //     ),
  //     padding: const EdgeInsets.symmetric(horizontal: 16),
  //     child: DropdownButtonHideUnderline(
  //       child: DropdownButton<String>(
  //         value: _selectedFilter,
  //         isExpanded: true,
  //         dropdownColor: const Color(0xFF1B2024),
  //         icon: const Icon(
  //           Icons.keyboard_arrow_down,
  //           color: Color(0xFFE0E3E8),
  //           size: 20,
  //         ),
  //         style: const TextStyle(
  //           color: Color(0xFFE2E5E9),
  //           fontSize: 13,
  //           fontWeight: FontWeight.w500,
  //         ),
  //         items: const [
  //           DropdownMenuItem(
  //             value: 'All Notifications',
  //             child: Text('All Notifications'),
  //           ),
  //           DropdownMenuItem(
  //             value: 'Bookings',
  //             child: Text('Bookings'),
  //           ),
  //           DropdownMenuItem(
  //             value: 'Payments',
  //             child: Text('Payments'),
  //           ),
  //           DropdownMenuItem(
  //             value: 'Wash Updates',
  //             child: Text('Wash Updates'),
  //           ),
  //         ],
  //         onChanged: (value) {
  //           if (value == null) return;
  //
  //           setState(() {
  //             _selectedFilter = value;
  //           });
  //         },
  //       ),
  //     ),
  //   );
  // }

  // ============================================================
  // SECTION TITLE
  // ============================================================

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: Color(0xFFB6BDC8),
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.4,
      ),
    );
  }

  // ============================================================
  // NOTIFICATION CARD
  // ============================================================

  Widget _buildNotificationCard(
      Map<String, dynamic> notification,
      ) {
    final bool unread = notification['unread'] == true;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        24,
        16,
        16,
        16,
      ),
      decoration: BoxDecoration(
        color: unread
            ? const Color(0xFF111D29)
            : const Color(0xFF171C20),
        borderRadius: BorderRadius.circular(11),
        border: Border.all(
          color: unread
              ? const Color(0xFF16467D)
              : const Color(0xFF252B30),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildNotificationIcon(
            notification['type'],
            unread,
          ),

          const SizedBox(width: 13),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        notification['title'],
                        style: TextStyle(
                          color: unread
                              ? const Color(0xFFE0E4EA)
                              : const Color(0xFFB8BDC5),
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                    const SizedBox(width: 8),

                    if (unread)
                      _buildUnreadDot(),

                    const SizedBox(width: 6),

                    Text(
                      notification['time'],
                      style: TextStyle(
                        color: unread
                            ? const Color(0xFFAFC5FF)
                            : const Color(0xFF9AA1AC),
                        fontSize: 11,
                        fontWeight: unread
                            ? FontWeight.w600
                            : FontWeight.w400,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 5),

                Text(
                  notification['message'],
                  style: TextStyle(
                    color: unread
                        ? const Color(0xFFC0C6D0)
                        : const Color(0xFF9CA3AE),
                    fontSize: 13,
                    height: 1.35,
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
  // NOTIFICATION ICON
  // ============================================================

  Widget _buildNotificationIcon(
      String type,
      bool unread,
      ) {
    IconData icon;

    switch (type) {
      case 'payment':
        icon = Icons.payments_outlined;
        break;

      case 'wash':
      case 'completed':
        icon = Icons.local_car_wash_outlined;
        break;

      case 'booking':
        icon = Icons.local_car_wash_outlined;
        break;

      case 'rescheduled':
        icon = Icons.calendar_month_outlined;
        break;

      default:
        icon = Icons.notifications_none;
    }

    Color backgroundColor;
    Color iconColor;
    Color borderColor;

    if (type == 'payment') {
      backgroundColor = const Color(0xFF0B382A);
      iconColor = const Color(0xFF68D9A2);
      borderColor = const Color(0xFF145C43);
    } else if (unread) {
      backgroundColor = const Color(0xFF102D55);
      iconColor = const Color(0xFFAEC8FF);
      borderColor = const Color(0xFF24548D);
    } else {
      backgroundColor = const Color(0xFF242A30);
      iconColor = const Color(0xFFA6ADB8);
      borderColor = const Color(0xFF30363D);
    }

    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
        ),
      ),
      child: Icon(
        icon,
        color: iconColor,
        size: 23,
      ),
    );
  }

  Widget _buildUnreadDot() {
    return Container(
      width: 8,
      height: 8,
      decoration: const BoxDecoration(
        color: Color(0xFFAFC5FF),
        shape: BoxShape.circle,
      ),
    );
  }
}