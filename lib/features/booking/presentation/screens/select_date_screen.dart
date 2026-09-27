import 'package:flutter/material.dart';

import 'booking_summary_screen.dart';

class SelectDateScreen extends StatefulWidget {
  final Map<String, String> selectedVehicle;
  final Map<String, dynamic> selectedService;
  final Map<String, dynamic> selectedStore;

  const SelectDateScreen({
    super.key,
    required this.selectedVehicle,
    required this.selectedService,
    required this.selectedStore,
  });

  @override
  State<SelectDateScreen> createState() =>
      _SelectDateScreenState();
}

class _SelectDateScreenState
    extends State<SelectDateScreen> {
  // Today's date.
  final DateTime _today = DateTime.now();

  // Month currently displayed on the calendar.
  // late DateTime _displayedMonth;
  DateTime _displayedMonth = DateTime(
    DateTime.now().year,
    DateTime.now().month,
  );

  // Currently selected date.
  // late DateTime _selectedDate;
  DateTime _selectedDate = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  String _selectedTime = '10:30 AM';

  final List<String> _morningTimes = [
    '09:00 AM',
    '09:30 AM',
    '10:00 AM',
    '10:30 AM',
    '11:00 AM',
    '11:30 AM',
  ];

  final List<String> _afternoonTimes = [
    '12:00 PM',
    '12:30 PM',
    '01:00 PM',
    '01:30 PM',
    '02:00 PM',
    '02:30 PM',
  ];

  final List<String> _eveningTimes = [
    '04:00 PM',
    '04:30 PM',
    '05:00 PM',
  ];

  // Temporary unavailable slots for UI testing.
  // Later these will come from Spring Boot.
  final Set<String> _disabledTimes = {
    '09:00 AM',
    '01:00 PM',
  };

  // @override
  // void initState() {
  //   super.initState();
  //
  //   // Start the calendar on the current month.
  //   _displayedMonth = DateTime(
  //     _today.year,
  //     _today.month,
  //   );
  //
  //   // Select today by default.
  //   _selectedDate = DateTime(
  //     _today.year,
  //     _today.month,
  //     _today.day,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0F12),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  20,
                  24,
                  20,
                  24,
                ),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    _buildStepIndicator(),

                    const SizedBox(height: 26),

                    const Text(
                      'Choose a Date & Time',
                      style: TextStyle(
                        color: Color(0xFFE8EAF0),
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 20),

                    _buildCalendar(),

                    const SizedBox(height: 18),

                    const Text(
                      'Available times',
                      style: TextStyle(
                        color: Color(0xFFE1E4E9),
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 20),

                    _buildTimeSection(
                      'MORNING',
                      _morningTimes,
                    ),

                    const SizedBox(height: 20),

                    _buildTimeSection(
                      'AFTERNOON',
                      _afternoonTimes,
                    ),

                    const SizedBox(height: 20),

                    _buildTimeSection(
                      'EVENING',
                      _eveningTimes,
                    ),
                  ],
                ),
              ),
            ),

            _buildContinueButton(),
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
  // STEPPER
  // ============================================================

  Widget _buildStepIndicator() {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        const Text(
          'Step 4 of 4',
          style: TextStyle(
            color: Color(0xFFB8C0CC),
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 14),

        SizedBox(
          height: 68,
          child: Stack(
            children: [
              Positioned(
                left: 36,
                right: 36,
                top: 20,
                child: Container(
                  height: 3,
                  color: const Color(0xFF292F35),
                ),
              ),

              Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [
                  _buildBookingStep(
                    icon:
                    Icons.directions_car_outlined,
                    label: 'Vehicle',
                    completed: true,
                    active: false,
                  ),

                  _buildBookingStep(
                    icon:
                    Icons.local_car_wash_outlined,
                    label: 'Service',
                    completed: true,
                    active: false,
                  ),

                  _buildBookingStep(
                    icon:
                    Icons.storefront_outlined,
                    label: 'Store',
                    completed: true,
                    active: false,
                  ),

                  _buildBookingStep(
                    icon:
                    Icons.calendar_month_outlined,
                    label: 'Date',
                    completed: false,
                    active: true,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBookingStep({
    required IconData icon,
    required String label,
    required bool completed,
    required bool active,
  }) {
    return SizedBox(
      width: 72,
      child: Column(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: active || completed
                  ? const Color(0xFF2878E8)
                  : const Color(0xFF252A2F),
              shape: BoxShape.circle,
            ),
            child: Icon(
              completed && !active
                  ? Icons.check
                  : icon,
              color: active || completed
                  ? Colors.white
                  : const Color(0xFF9DA5B1),
              size: 20,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: active
                  ? const Color(0xFF9DBBFF)
                  : const Color(0xFFB8C0CC),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // CALENDAR
  // ============================================================

  Widget _buildCalendar() {
    const List<String> weekdays = [
      'MON',
      'TUE',
      'WED',
      'THU',
      'FRI',
      'SAT',
      'SUN',
    ];

    final List<DateTime?> days =
    _generateCalendarDays(_displayedMonth);

    final bool canGoToPreviousMonth =
        _displayedMonth.year > _today.year ||
            (_displayedMonth.year == _today.year &&
                _displayedMonth.month > _today.month);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        24,
        22,
        24,
        18,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF171C20),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF252B31),
        ),
      ),
      child: Column(
        children: [
          // Month header
          Row(
            children: [
              Expanded(
                child: Text(
                  _monthName(
                    _displayedMonth.month,
                  ),
                  style: const TextStyle(
                    color: Color(0xFFE1E4E9),
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),

              _buildMonthButton(
                Icons.chevron_left,
                enabled:
                canGoToPreviousMonth,
                onTap:
                canGoToPreviousMonth
                    ? _goToPreviousMonth
                    : null,
              ),

              const SizedBox(width: 8),

              _buildMonthButton(
                Icons.chevron_right,
                enabled: true,
                onTap: _goToNextMonth,
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Weekday names
          Row(
            children: weekdays.map((day) {
              return Expanded(
                child: Center(
                  child: Text(
                    day,
                    style: const TextStyle(
                      color: Color(0xFFB8C0CC),
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 12),

          // Calendar days
          GridView.builder(
            shrinkWrap: true,
            physics:
            const NeverScrollableScrollPhysics(),
            itemCount: days.length,
            gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisExtent: 40,
            ),
            itemBuilder: (context, index) {
              final DateTime? date = days[index];

              if (date == null) {
                return const SizedBox();
              }

              return _buildCalendarDay(date);
            },
          ),

          const SizedBox(height: 8),

          Container(
            height: 1,
            color: const Color(0xFF252B31),
          ),

          const SizedBox(height: 15),

          Text(
            'Selected: ${_formatSelectedDate()}',
            style: const TextStyle(
              color: Color(0xFF9DBBFF),
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // GENERATE MONTH DAYS
  // ============================================================

  List<DateTime?> _generateCalendarDays(
      DateTime month,
      ) {
    final int daysInMonth = DateTime(
      month.year,
      month.month + 1,
      0,
    ).day;

    // DateTime weekday:
    // Monday = 1
    // Sunday = 7
    final int firstWeekday =
        DateTime(
          month.year,
          month.month,
          1,
        ).weekday;

    final List<DateTime?> days = [];

    // Empty cells before the first day.
    for (int i = 1; i < firstWeekday; i++) {
      days.add(null);
    }

    // Actual days.
    for (int day = 1;
    day <= daysInMonth;
    day++) {
      days.add(
        DateTime(
          month.year,
          month.month,
          day,
        ),
      );
    }

    return days;
  }

  // ============================================================
  // MONTH NAVIGATION
  // ============================================================

  void _goToPreviousMonth() {
    final DateTime previousMonth = DateTime(
      _displayedMonth.year,
      _displayedMonth.month - 1,
    );

    final DateTime currentMonth = DateTime(
      _today.year,
      _today.month,
    );

    // Never go before the current month.
    if (previousMonth.isBefore(currentMonth)) {
      return;
    }

    setState(() {
      _displayedMonth = previousMonth;

      // If selected date is no longer inside the
      // displayed month, select the first valid date.
      if (_selectedDate.year !=
          previousMonth.year ||
          _selectedDate.month !=
              previousMonth.month) {
        _selectedDate = DateTime(
          previousMonth.year,
          previousMonth.month,
          1,
        );
      }
    });
  }

  void _goToNextMonth() {
    setState(() {
      _displayedMonth = DateTime(
        _displayedMonth.year,
        _displayedMonth.month + 1,
      );
    });
  }

  // ============================================================
  // MONTH BUTTON
  // ============================================================

  Widget _buildMonthButton(
      IconData icon, {
        required bool enabled,
        required VoidCallback? onTap,
      }) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: enabled
              ? const Color(0xFF1E2328)
              : const Color(0xFF15191C),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: enabled
              ? const Color(0xFFB8C0CC)
              : const Color(0xFF4F565F),
          size: 18,
        ),
      ),
    );
  }

  // ============================================================
  // CALENDAR DAY
  // ============================================================

  Widget _buildCalendarDay(DateTime date) {
    final bool isSelected =
    _isSameDate(date, _selectedDate);

    final bool isToday =
    _isSameDate(date, _today);

    final bool isPast =
    date.isBefore(
      DateTime(
        _today.year,
        _today.month,
        _today.day,
      ),
    );

    return GestureDetector(
      onTap: isPast
          ? null
          : () {
        setState(() {
          _selectedDate = date;
        });
      },
      child: Center(
        child: Container(
          width: 40,
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xFF2878E8)
                : Colors.transparent,
            shape: BoxShape.circle,
            border: isToday && !isSelected
                ? Border.all(
              color:
              const Color(0xFF2878E8),
              width: 1.2,
            )
                : null,
            boxShadow: isSelected
                ? [
              BoxShadow(
                color:
                const Color(0xFF2878E8)
                    .withOpacity(0.35),
                blurRadius: 12,
              ),
            ]
                : null,
          ),
          child: Text(
            '${date.day}',
            style: TextStyle(
              color: isSelected
                  ? Colors.white
                  : isPast
                  ? const Color(0xFF555D67)
                  : const Color(0xFFD0D5DD),
              fontSize: 14,
              fontWeight: isSelected
                  ? FontWeight.w700
                  : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // TIME SECTIONS
  // ============================================================

  Widget _buildTimeSection(
      String title,
      List<String> times,
      ) {
    return Column(
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

        const SizedBox(height: 12),

        GridView.builder(
          shrinkWrap: true,
          physics:
          const NeverScrollableScrollPhysics(),
          itemCount: times.length,
          gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            mainAxisExtent: 46,
          ),
          itemBuilder: (context, index) {
            return _buildTimeButton(
              times[index],
            );
          },
        ),
      ],
    );
  }

  Widget _buildTimeButton(String time) {
    final bool selected =
        _selectedTime == time;

    final bool disabled =
    _disabledTimes.contains(time);

    return GestureDetector(
      onTap: disabled
          ? null
          : () {
        setState(() {
          _selectedTime = time;
        });
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xFF126BE0)
              : const Color(0xFF1B2024),
          borderRadius:
          BorderRadius.circular(7),
          border: Border.all(
            color: selected
                ? const Color(0xFF2878E8)
                : const Color(0xFF20262B),
          ),
          boxShadow: selected
              ? [
            BoxShadow(
              color:
              const Color(0xFF2878E8)
                  .withOpacity(0.25),
              blurRadius: 10,
            ),
          ]
              : null,
        ),
        child: Text(
          time,
          style: TextStyle(
            color: disabled
                ? const Color(0xFF646B75)
                : selected
                ? Colors.white
                : const Color(0xFFD6DBE4),
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  // ============================================================
  // CONTINUE
  // ============================================================

  Widget _buildContinueButton() {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        20,
        12,
        20,
        16,
      ),
      decoration: const BoxDecoration(
        color: Color(0xFF0B0F12),
        border: Border(
          top: BorderSide(
            color: Color(0xFF252B31),
          ),
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    BookingSummaryScreen(
                      selectedVehicle:
                      widget.selectedVehicle,
                      selectedService:
                      widget.selectedService,
                      selectedStore:
                      widget.selectedStore,
                      selectedDate:
                      _selectedDate,
                      selectedTime:
                      _selectedTime,
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
                'Continue',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),

              SizedBox(width: 10),

              Icon(
                Icons.arrow_forward,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // HELPERS
  // ============================================================

  bool _isSameDate(
      DateTime first,
      DateTime second,
      ) {
    return first.year == second.year &&
        first.month == second.month &&
        first.day == second.day;
  }

  String _monthName(int month) {
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

    return '${months[month - 1]} '
        '${_displayedMonth.year}';
  }

  String _formatSelectedDate() {
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

    return '${weekdays[_selectedDate.weekday - 1]}, '
        '${_selectedDate.day} '
        '${months[_selectedDate.month - 1]}';
  }
}