// import 'package:flutter/material.dart';
//
// class EditVehicleScreen extends StatefulWidget {
//   const EditVehicleScreen({
//     super.key,
//     required this.vehicle,
//   });
//
//   final Map<String, String> vehicle;
//
//   @override
//   State<EditVehicleScreen> createState() =>
//       _EditVehicleScreenState();
// }
//
// class _EditVehicleScreenState
//     extends State<EditVehicleScreen> {
//   late TextEditingController _nameController;
//   late TextEditingController _registrationController;
//
//   String _selectedType = 'SUV';
//
//   @override
//   void initState() {
//     super.initState();
//
//     _nameController = TextEditingController(
//       text:
//       '${widget.vehicle['brand']} ${widget.vehicle['model']}',
//     );
//
//     _registrationController = TextEditingController(
//       text: widget.vehicle['registration'],
//     );
//
//     _selectedType =
//     widget.vehicle['type'] == 'MOTORCYCLE'
//         ? 'Motorcycle'
//         : 'SUV';
//   }
//
//   @override
//   void dispose() {
//     _nameController.dispose();
//     _registrationController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: const Color(0xFF0D1215),
//       body: SafeArea(
//         child: Column(
//           children: [
//             _buildHeader(),
//
//             Expanded(
//               child: SingleChildScrollView(
//                 padding: const EdgeInsets.fromLTRB(
//                   20,
//                   24,
//                   20,
//                   30,
//                 ),
//                 child: Column(
//                   children: [
//                     _buildFormCard(),
//
//                     const SizedBox(height: 44),
//
//                     _buildSaveButton(),
//
//                     const SizedBox(height: 18),
//
//                     _buildRemoveVehicleButton(),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildHeader() {
//     return Container(
//       height: 64,
//       decoration: const BoxDecoration(
//         border: Border(
//           bottom: BorderSide(
//             color: Color(0xFF20262B),
//           ),
//         ),
//       ),
//       child: Stack(
//         alignment: Alignment.center,
//         children: [
//           Align(
//             alignment: Alignment.centerLeft,
//             child: IconButton(
//               onPressed: () => Navigator.pop(context),
//               icon: const Icon(
//                 Icons.arrow_back_ios_new,
//                 color: Color(0xFFDCE1EA),
//                 size: 21,
//               ),
//             ),
//           ),
//           const Text(
//             'Edit Vehicle',
//             style: TextStyle(
//               color: Color(0xFFE7E9ED),
//               fontSize: 20,
//               fontWeight: FontWeight.w700,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildFormCard() {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.fromLTRB(
//         24,
//         28,
//         24,
//         30,
//       ),
//       decoration: BoxDecoration(
//         color: const Color(0xFF151A1E),
//         borderRadius: BorderRadius.circular(24),
//         border: Border.all(
//           color: const Color(0xFF30363B),
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           _buildLabel('Vehicle Name'),
//
//           const SizedBox(height: 10),
//
//           _buildTextField(
//             controller: _nameController,
//             hint: 'ex. Creta',
//           ),
//
//           const SizedBox(height: 28),
//
//           _buildLabel('Registration Number'),
//
//           const SizedBox(height: 10),
//
//           _buildTextField(
//             controller: _registrationController,
//             hint: 'ex. GJ01AB1234',
//           ),
//
//           const SizedBox(height: 28),
//
//           _buildLabel('Vehicle Type'),
//
//           const SizedBox(height: 12),
//
//           Row(
//             children: [
//               _buildTypeButton('SUV'),
//               const SizedBox(width: 12),
//               _buildTypeButton('Motorcycle'),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildLabel(String text) {
//     return Text(
//       text,
//       style: const TextStyle(
//         color: Color(0xFFBFC5CE),
//         fontSize: 15,
//       ),
//     );
//   }
//
//   Widget _buildTextField({
//     required TextEditingController controller,
//     required String hint,
//   }) {
//     return TextField(
//       controller: controller,
//       style: const TextStyle(
//         color: Color(0xFF424957),
//         fontSize: 15,
//       ),
//       decoration: InputDecoration(
//         hintText: hint,
//         hintStyle: const TextStyle(
//           color: Color(0xFF626A76),
//         ),
//         filled: true,
//         fillColor: Colors.white,
//         contentPadding: const EdgeInsets.symmetric(
//           horizontal: 14,
//           vertical: 17,
//         ),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide.none,
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTypeButton(String type) {
//     final selected = _selectedType == type;
//
//     return Expanded(
//       child: GestureDetector(
//         onTap: () {
//           setState(() {
//             _selectedType = type;
//           });
//         },
//         child: Container(
//           height: 50,
//           decoration: BoxDecoration(
//             color: selected
//                 ? const Color(0xFF2878E8)
//                 : const Color(0xFF20252A),
//             borderRadius: BorderRadius.circular(25),
//             border: Border.all(
//               color: selected
//                   ? const Color(0xFF2878E8)
//                   : const Color(0xFF30363B),
//             ),
//           ),
//           alignment: Alignment.center,
//           child: Text(
//             type,
//             style: TextStyle(
//               color: selected
//                   ? Colors.white
//                   : const Color(0xFFC0C5CE),
//               fontSize: 14,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildSaveButton() {
//     return SizedBox(
//       width: double.infinity,
//       height: 56,
//       child: ElevatedButton(
//         onPressed: () {
//           Navigator.pop(context);
//         },
//         style: ElevatedButton.styleFrom(
//           backgroundColor: const Color(0xFF2878E8),
//           foregroundColor: Colors.white,
//           elevation: 8,
//           shadowColor: const Color(0x662878E8),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(11),
//           ),
//         ),
//         child: const Text(
//           'Save Changes',
//           style: TextStyle(
//             fontSize: 14,
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildRemoveVehicleButton() {
//     return SizedBox(
//       width: double.infinity,
//       height: 52,
//       child: OutlinedButton(
//         onPressed: () {
//           _showRemoveConfirmation();
//         },
//         style: OutlinedButton.styleFrom(
//           foregroundColor: const Color(0xFFFF6B6B),
//           side: const BorderSide(
//             color: Color(0xFF6A2D2D),
//           ),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(11),
//           ),
//         ),
//         child: const Text(
//           'Remove Vehicle',
//           style: TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _showRemoveConfirmation() {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           backgroundColor: const Color(0xFF171C20),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(18),
//           ),
//           title: const Text(
//             'Remove Vehicle?',
//             style: TextStyle(
//               color: Color(0xFFE7E9ED),
//               fontWeight: FontWeight.w700,
//             ),
//           ),
//           content: const Text(
//             'Are you sure you want to remove this vehicle?',
//             style: TextStyle(
//               color: Color(0xFFB8C0CC),
//               fontSize: 14,
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: const Text(
//                 'Cancel',
//                 style: TextStyle(
//                   color: Color(0xFFB8C0CC),
//                 ),
//               ),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context); // close dialog
//                 Navigator.pop(context, true); // remove + go back
//               },
//               child: const Text(
//                 'Remove',
//                 style: TextStyle(
//                   color: Color(0xFFFF6B6B),
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }


import 'package:flutter/material.dart';

class EditVehicleScreen extends StatefulWidget {
  const EditVehicleScreen({
    super.key,
    required this.vehicle,
  });

  final Map<String, String> vehicle;

  @override
  State<EditVehicleScreen> createState() =>
      _EditVehicleScreenState();
}

class _EditVehicleScreenState extends State<EditVehicleScreen> {
  late TextEditingController _brandController;
  late TextEditingController _modelController;
  late TextEditingController _registrationController;

  late String _selectedVehicleType;

  @override
  void initState() {
    super.initState();

    _brandController = TextEditingController(
      text: widget.vehicle['brand'] ?? '',
    );

    _modelController = TextEditingController(
      text: widget.vehicle['model'] ?? '',
    );

    _registrationController = TextEditingController(
      text: widget.vehicle['registration'] ?? '',
    );

    _selectedVehicleType = 'Car';
  }

  @override
  void dispose() {
    _brandController.dispose();
    _modelController.dispose();
    _registrationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFF0D1215),
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
                  30,
                ),
                child: Column(
                  children: [
                    _buildFormCard(),

                    const SizedBox(height: 44),

                    _buildSaveButton(),

                    const SizedBox(height: 18),

                    _buildRemoveVehicleButton(),
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
            'Edit Vehicle',
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
  // FORM
  // ============================================================

  Widget _buildFormCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        24,
        28,
        24,
        30,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF151A1E),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFF30363B),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLabel('Vehicle Brand'),

          const SizedBox(height: 10),

          _buildTextField(
            controller: _brandController,
            hint: 'e.g. Hyundai',
          ),

          const SizedBox(height: 28),

          _buildLabel('Model'),

          const SizedBox(height: 10),

          _buildTextField(
            controller: _modelController,
            hint: 'e.g. Creta',
          ),

          const SizedBox(height: 28),

          _buildLabel('Registration Number'),

          const SizedBox(height: 10),

          _buildTextField(
            controller: _registrationController,
            hint: 'e.g. GJ01AB1234',
          ),

          const SizedBox(height: 28),

          _buildLabel('Vehicle Type'),

          const SizedBox(height: 12),

          _buildVehicleTypeDropdown(),
        ],
      ),
    );
  }

  // ============================================================
  // LABEL
  // ============================================================

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Color(0xFFBFC5CE),
        fontSize: 15,
      ),
    );
  }

  // ============================================================
  // TEXT FIELD
  // ============================================================

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
  }) {
    return TextField(
      controller: controller,
      style: const TextStyle(
        color: Color(0xFF424957),
        fontSize: 15,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
          color: Color(0xFF626A76),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 17,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  // ============================================================
  // VEHICLE TYPE
  // ============================================================

  Widget _buildVehicleTypeDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedVehicleType,
      dropdownColor: const Color(0xFF1B1F22),
      icon: const Icon(
        Icons.keyboard_arrow_down,
        color: Color(0xFFA8AFBB),
      ),
      style: const TextStyle(
        color: Color(0xFFE1E4E9),
        fontSize: 15,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFF1B1F22),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Color(0xFF30363D),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Color(0xFF30363D),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Color(0xFF8FAFFF),
          ),
        ),
      ),
      items: const [
        DropdownMenuItem(
          value: 'Car',
          child: Text('Car'),
        ),
      ],
      onChanged: (value) {
        if (value == null) return;

        setState(() {
          _selectedVehicleType = value;
        });
      },
    );
  }

  // ============================================================
  // SAVE
  // ============================================================

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: _saveChanges,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2878E8),
          foregroundColor: Colors.white,
          elevation: 8,
          shadowColor: const Color(0x662878E8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(11),
          ),
        ),
        child: const Text(
          'Save Changes',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  void _saveChanges() {
    final brand = _brandController.text.trim();
    final model = _modelController.text.trim();
    final registration =
    _registrationController.text.trim();

    if (brand.isEmpty ||
        model.isEmpty ||
        registration.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please fill in all vehicle details.',
          ),
        ),
      );
      return;
    }

    final updatedVehicle = <String, String>{
      'type': _selectedVehicleType,
      'brand': brand,
      'model': model,
      'registration': registration,
    };

    Navigator.pop(context, updatedVehicle);
  }

  // ============================================================
  // REMOVE VEHICLE
  // ============================================================

  Widget _buildRemoveVehicleButton() {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: OutlinedButton(
        onPressed: _showRemoveConfirmation,
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFFFF6B6B),
          side: const BorderSide(
            color: Color(0xFF6A2D2D),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(11),
          ),
        ),
        child: const Text(
          'Remove Vehicle',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  void _showRemoveConfirmation() {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: const Color(0xFF171C20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          title: const Text(
            'Remove Vehicle?',
            style: TextStyle(
              color: Color(0xFFE7E9ED),
              fontWeight: FontWeight.w700,
            ),
          ),
          content: const Text(
            'Are you sure you want to remove this vehicle?',
            style: TextStyle(
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
                'Cancel',
                style: TextStyle(
                  color: Color(0xFFB8C0CC),
                ),
              ),
            ),

            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);

                // true tells MyVehiclesScreen
                // that this vehicle should be removed.
                Navigator.pop(context, true);
              },
              child: const Text(
                'Remove',
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
}