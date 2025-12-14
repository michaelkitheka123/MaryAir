import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../theme/app_theme.dart';
import '../../models/parcel_model.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/parcel_ticket_widget.dart';
import '../../widgets/dashed_container.dart';

class ParcelWizardScreen extends StatefulWidget {
  const ParcelWizardScreen({super.key});

  @override
  State<ParcelWizardScreen> createState() => _ParcelWizardScreenState();
}

class _ParcelWizardScreenState extends State<ParcelWizardScreen> {
  int _currentStep = 0;
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final _senderNameCtrl = TextEditingController();
  final _senderContactCtrl = TextEditingController();
  final _receiverNameCtrl = TextEditingController();
  final _receiverContactCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  final _weightCtrl = TextEditingController();
  final _dimsCtrl = TextEditingController();

  // State
  Uint8List? _parcelPhoto;
  String? _selectedFlight;
  DateTime _flightDate = DateTime.now().add(const Duration(days: 1));
  double _calculatedCost = 0.0;

  // Mock Flights
  final List<String> _flights = [
    'MA101 (NBO-DXB)',
    'MA202 (DXB-LHR)',
    'MA305 (NBO-JFK)',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.maryBlack,
      appBar: AppBar(
        title: const Text('Send Parcel Wizard'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Steps Indicator
          _buildProgressIndicator(),

          Expanded(
            child: Theme(
              data: ThemeData.dark().copyWith(
                colorScheme: const ColorScheme.dark(
                  primary: AppTheme.maryOrangeRed,
                ),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppTheme.spacingM),
                child: Form(key: _formKey, child: _buildStepContent()),
              ),
            ),
          ),

          // Navigation
          _buildBottomBar(),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      color: Colors.black26,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildStepDot(0, 'Contacts'),
          _buildLine(0),
          _buildStepDot(1, 'Goods'),
          _buildLine(1),
          _buildStepDot(2, 'Flight'),
          _buildLine(2),
          _buildStepDot(3, 'Confirm'),
        ],
      ),
    );
  }

  Widget _buildStepDot(int index, String label) {
    bool isActive = index <= _currentStep;
    return Column(
      children: [
        CircleAvatar(
          radius: 12,
          backgroundColor: isActive ? AppTheme.maryOrangeRed : Colors.grey,
          child: Text(
            '${index + 1}',
            style: const TextStyle(fontSize: 10, color: Colors.white),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.white : Colors.grey,
            fontSize: 10,
          ),
        ),
      ],
    );
  }

  Widget _buildLine(int index) {
    return Container(
      width: 40,
      height: 2,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      color: index < _currentStep ? AppTheme.maryOrangeRed : Colors.grey,
    );
  }

  Widget _buildStepContent() {
    switch (_currentStep) {
      case 0:
        return _buildStep1Contacts();
      case 1:
        return _buildStep2Goods();
      case 2:
        return _buildStep3Flight();
      case 3:
        return _buildStep4Review();
      default:
        return Container();
    }
  }

  Widget _buildStep1Contacts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Sender Information',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        CustomTextField(
          label: 'Sender Name',
          hint: 'Full Name',
          controller: _senderNameCtrl,
        ),
        const SizedBox(height: 16),
        CustomTextField(
          label: 'Sender Contact',
          hint: 'Phone or Email',
          controller: _senderContactCtrl,
        ),
        const Divider(height: 32, color: Colors.grey),
        const Text(
          'Receiver Information',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        CustomTextField(
          label: 'Receiver Name',
          hint: 'Full Name',
          controller: _receiverNameCtrl,
        ),
        const SizedBox(height: 16),
        CustomTextField(
          label: 'Receiver Contact',
          hint: 'Phone or Email',
          controller: _receiverContactCtrl,
        ),
      ],
    );
  }

  Widget _buildStep2Goods() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Parcel Details',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        CustomTextField(
          label: 'Description',
          hint: 'What is inside?',
          controller: _descCtrl,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: CustomTextField(
                label: 'Weight (kg)',
                hint: '0.0',
                keyboardType: TextInputType.number,
                controller: _weightCtrl,
                onChanged: (val) => setState(() {}),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: CustomTextField(
                label: 'Dimensions',
                hint: 'LxWxH cm',
                controller: _dimsCtrl,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Photo Capture Mock
        const Text('Parcel Photo', style: TextStyle(color: Colors.white70)),
        const SizedBox(height: 8),
        InkWell(
          onTap: () {
            // Mock taking a photo
            setState(() {
              // Creating a 1x1 dummy blue pixel
              _parcelPhoto = Uint8List.fromList(
                List.filled(1000, 100),
              ); // Just noise
            });
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Photo captured!')));
          },
          child: DashedContainer(
            color: Colors.white24,
            dashLength: 5,
            gapLength: 5,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.circular(12),
              ),
              child: _parcelPhoto == null
                  ? const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.camera_alt, color: Colors.white54, size: 40),
                        SizedBox(height: 8),
                        Text(
                          'Tap to Capture',
                          style: TextStyle(color: Colors.white54),
                        ),
                      ],
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.memory(_parcelPhoto!, fit: BoxFit.cover),
                    ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStep3Flight() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Assign Flight',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedFlight,
              hint: const Text(
                'Select Flight',
                style: TextStyle(color: Colors.white54),
              ),
              dropdownColor: AppTheme.maryBlack,
              isExpanded: true,
              style: const TextStyle(color: Colors.white),
              items: _flights
                  .map((f) => DropdownMenuItem(value: f, child: Text(f)))
                  .toList(),
              onChanged: (val) => setState(() => _selectedFlight = val),
            ),
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Cost Calculation',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white10,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // The original Text widget for Estimated Cost
              const Text(
                'Estimated Cost:',
                style: TextStyle(color: Colors.white70),
              ),
              // This is the line being changed based on the instruction
              Text(
                'KES ${_calculateCost().toStringAsFixed(2)}',
                style: const TextStyle(
                  color: AppTheme.maryOrangeRed,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStep4Review() {
    final parcel = _createParcel();
    return Column(
      children: [
        const Icon(Icons.check_circle, color: Colors.green, size: 60),
        const SizedBox(height: 16),
        const Text(
          'Review Information',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 24),
        ParcelTicketWidget(parcel: parcel),
      ],
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingM),
      color: Colors.black54,
      child: Row(
        children: [
          if (_currentStep > 0)
            Expanded(
              child: CustomButton(
                text: 'Back',
                isOutlined: true,
                onPressed: () => setState(() => _currentStep--),
              ),
            ),
          if (_currentStep > 0) const SizedBox(width: 16),
          Expanded(
            child: CustomButton(
              text: _currentStep == 3 ? 'Generate Ticket' : 'Next',
              onPressed: () async {
                if (_currentStep < 3) {
                  setState(() => _currentStep++);
                } else {
                  // Save Parcel logic
                  try {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (c) => const Center(
                        child: CircularProgressIndicator(
                          color: AppTheme.maryOrangeRed,
                        ),
                      ),
                    );

                    final parcel = _createParcel();
                    await FirebaseFirestore.instance
                        .collection('parcels')
                        .add(parcel.toJson());

                    if (mounted) {
                      Navigator.pop(context); // dismiss loader
                      Navigator.pop(context); // exit wizard
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Parcel Ticket Generated & Saved!'),
                        ),
                      );
                    }
                  } catch (e) {
                    if (mounted) Navigator.pop(context); // dismiss loader
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error saving parcel: $e'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  double _calculateCost() {
    final weight = double.tryParse(_weightCtrl.text) ?? 0;
    final basePrice = 2500.0; // Base KES
    final perKg = 850.0; // Per KG KES
    return basePrice + (weight * perKg);
  }

  Parcel _createParcel() {
    return Parcel(
      id: 'PKG-${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}',
      senderName: _senderNameCtrl.text,
      senderContact: _senderContactCtrl.text,
      receiverName: _receiverNameCtrl.text,
      receiverContact: _receiverContactCtrl.text,
      description: _descCtrl.text,
      weightKg: double.tryParse(_weightCtrl.text) ?? 0.0,
      dimensions: _dimsCtrl.text,
      photoBytes: _parcelPhoto,
      flightNumber: _selectedFlight?.split(' ')[0] ?? 'MA000',
      departureDate: _flightDate,
      origin: _selectedFlight?.contains('NBO') == true ? 'NBO' : 'DXB',
      destination: _selectedFlight?.contains('DXB') == true ? 'DXB' : 'JFK',
      cost: _calculateCost(),
    );
  }
}
