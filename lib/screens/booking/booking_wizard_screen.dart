import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:image_picker/image_picker.dart';
import '../../theme/app_theme.dart';
import '../../models/booking_state.dart';
import '../../widgets/wizard_card.dart';
import '../../widgets/custom_button.dart';
import '../../services/airport_service.dart';
import '../../services/seat_selection_service.dart';
import '../../models/seat_selection_models.dart' as ss_models;
import '../../widgets/seat_map_widget.dart';
import '../../models/ticket_model.dart';
import '../../widgets/eticket_card_horizontal.dart';
import '../../widgets/booking_actions_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../utils/country_utils.dart';

class BookingWizardScreen extends StatefulWidget {
  const BookingWizardScreen({super.key});

  @override
  State<BookingWizardScreen> createState() => _BookingWizardScreenState();
}

class _BookingWizardScreenState extends State<BookingWizardScreen> {
  final PageController _pageController = PageController();
  int _currentStep = 0;
  final AirportService _airportService = AirportService();
  final SeatSelectionService _seatService = SeatSelectionService();
  ss_models.AircraftCabin? _cabin;

  // Airport Data (loaded from CSV)
  List<Map<String, String>> kenyanAirports = [];
  Map<String, List<Map<String, String>>> destinationAirportsByCountry = {};
  bool isLoadingAirports = true;

  // Dropdown state
  String? selectedOriginCode;
  String? selectedDestCountry;
  String? selectedDestAirportCode;
  String? selectedReturnPickupCode; // For round trip return leg

  @override
  void initState() {
    super.initState();
    _loadAirports();
  }

  Future<void> _loadAirports() async {
    setState(() => isLoadingAirports = true);

    try {
      kenyanAirports = await _airportService.getKenyanAirportsAsMap();
      destinationAirportsByCountry = await _airportService
          .getAirportsByCountryAsMap();
    } catch (e) {
      debugPrint('Error loading airports: $e');
      // Keep empty lists as fallback
    }

    setState(() => isLoadingAirports = false);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep < 4) {
      if (_currentStep == 1) {
        // Moving to Phase 3 (Index 2), initialize passengers
        context.read<BookingState>().initializePassengers();
      }

      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() => _currentStep++);
    }
  }

  // ... (previous code)

  Widget _buildPhase3Details() {
    final bookingState = context.watch<BookingState>();
    final ImagePicker picker = ImagePicker();

    Future<void> pickImage(Passenger passenger) async {
      try {
        final XFile? image = await picker.pickImage(
          source: ImageSource.gallery,
        );
        if (image != null) {
          final bytes = await image.readAsBytes();
          setState(() {
            passenger.passportPhotoPath = image.path;
            passenger.passportPhotoBytes = bytes;
          });
        }
      } catch (e) {
        debugPrint('Error picking image: $e');
      }
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppTheme.spacingM),
      child: WizardCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppTheme.maryGreen.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.person,
                    color: AppTheme.maryGreen,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'Passenger Details',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Passenger Forms
            if (bookingState.passengers.isEmpty)
              const Center(
                child: CircularProgressIndicator(color: AppTheme.maryOrangeRed),
              )
            else
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: bookingState.passengers.length,
                separatorBuilder: (_, __) => const Padding(
                  padding: EdgeInsets.symmetric(vertical: 24.0),
                  child: Divider(color: Colors.white12),
                ),
                itemBuilder: (context, index) {
                  final passenger = bookingState.passengers[index];
                  // Determine type (Simplistic logic, assuming order: Adults, Children, Infants but here just generic)
                  final label = 'Passenger ${index + 1}';

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label,
                        style: const TextStyle(
                          color: AppTheme.maryGold,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 16),

                      _buildTextField(
                        label: 'Full Name',
                        icon: Icons.badge,
                        value: passenger.fullName,
                        onChanged: (val) => passenger.fullName = val,
                        placeholder: 'As on ID/Passport',
                      ),
                      const SizedBox(height: 12),
                      _buildTextField(
                        label: 'Passport Number',
                        icon: Icons.numbers,
                        value: passenger.passportNumber,
                        onChanged: (val) => passenger.passportNumber = val,
                        placeholder: 'Enter number',
                      ),
                      const SizedBox(height: 16),

                      // Passport Photo Upload
                      Text(
                        'Passport Photo',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          if (passenger.passportPhotoPath != null)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.memory(
                                passenger.passportPhotoBytes!,
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                            )
                          else
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.white10,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.white24),
                              ),
                              child: const Icon(
                                Icons.camera_alt,
                                color: Colors.white38,
                              ),
                            ),
                          const SizedBox(width: 16),
                          ElevatedButton.icon(
                            onPressed: () => pickImage(passenger),
                            icon: const Icon(Icons.upload_file, size: 18),
                            label: Text(
                              passenger.passportPhotoPath != null
                                  ? 'Change Photo'
                                  : 'Upload Photo',
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white10,
                              foregroundColor: Colors.white,
                              elevation: 0,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),
                      // Seat Map Placeholder
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: () {
                            _openSeatMapModal(context, bookingState);
                          },
                          icon: Icon(
                            passenger.selectedSeat != null
                                ? Icons.check_circle
                                : Icons.event_seat,
                            size: 18,
                          ),
                          label: Text(
                            passenger.selectedSeat != null
                                ? 'Seat ${passenger.selectedSeat}'
                                : 'Select Seat',
                          ),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: passenger.selectedSeat != null
                                ? AppTheme.maryGreen
                                : AppTheme.maryGold,
                            side: BorderSide(
                              color: passenger.selectedSeat != null
                                  ? AppTheme.maryGreen
                                  : AppTheme.maryGold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),

            const SizedBox(height: 32),
            CustomButton(text: 'Continue to Payment', onPressed: _nextStep),
          ],
        ),
      ),
    );
  }

  void _prevStep() {
    if (_currentStep > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() => _currentStep--);
    } else {
      Navigator.pop(context); // Exit wizard
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.maryBlack,
      body: SafeArea(
        child: Stack(
          children: [
            // 1. Background Overlay (Consistent with Dashboard)
            Positioned.fill(
              child: Container(
                margin: const EdgeInsets.all(AppTheme.spacingM),
                decoration: BoxDecoration(
                  color: AppTheme.maryGreen.withOpacity(0.05),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                  border: Border.all(
                    color: AppTheme.maryGreen.withOpacity(0.3),
                    width: 1,
                  ),
                ),
              ),
            ),

            // 2. Wizard Content
            Column(
              children: [
                // Top Bar: Back & Title
                Padding(
                  padding: const EdgeInsets.all(AppTheme.spacingL),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: AppTheme.maryGold,
                        ),
                        onPressed: _prevStep,
                      ),
                      Expanded(
                        child: Text(
                          _getStepTitle(_currentStep),
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(width: 48), // Balance for back button
                    ],
                  ),
                ),

                // Page View (The Cards)
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    physics:
                        const NeverScrollableScrollPhysics(), // Disable swipe
                    children: [
                      _buildPhase1Search(),
                      _buildPhase2Flights(),
                      _buildPhase3Details(),
                      _buildPhase4Payment(),
                      _buildPhase5Confirmation(),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getStepTitle(int step) {
    switch (step) {
      case 0:
        return 'Plan Your Trip';
      case 1:
        return 'Select Flights';
      case 2:
        return 'Passenger Details';
      case 3:
        return 'Payment';
      case 4:
        return 'Confirmation';
      default:
        return '';
    }
  }

  // --- PHASE BUILDERS (Placeholders for now) ---

  Widget _buildPhase1Search() {
    final bookingState = context.watch<BookingState>();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppTheme.spacingM),
      child: WizardCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppTheme.maryGreen.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.flight,
                    color: AppTheme.maryGreen,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'Flight Search',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Trip Type
            Row(
              children: [
                _buildTripTypeChip(
                  bookingState,
                  TripType.roundTrip,
                  'Round Trip',
                ),
                const SizedBox(width: 12),
                _buildTripTypeChip(bookingState, TripType.oneWay, 'One Way'),
              ],
            ),
            const SizedBox(height: 24),

            // Show loading indicator while airports are being loaded
            if (isLoadingAirports)
              const Center(
                child: Column(
                  children: [
                    CircularProgressIndicator(color: AppTheme.maryGreen),
                    SizedBox(height: 16),
                    Text(
                      'Loading airports...',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              )
            else ...[
              // Route: Origin & Destination
              _buildAirportDropdown(
                label: 'From (Kenya)',
                icon: Icons.flight_takeoff,
                value: selectedOriginCode,
                airports: kenyanAirports,
                onChanged: (code) {
                  setState(() {
                    selectedOriginCode = code;
                  });
                },
              ),
              const SizedBox(height: 16),

              // Destination Country
              _buildCountryDropdown(
                label: 'To (Country)',
                icon: Icons.public,
                value: selectedDestCountry,
                countries: destinationAirportsByCountry.keys.toList(),
                onChanged: (country) {
                  setState(() {
                    selectedDestCountry = country;
                    selectedDestAirportCode =
                        null; // Reset airport when country changes
                  });
                },
              ),
              const SizedBox(height: 16),

              // Destination Airport (only show if country selected)
              if (selectedDestCountry != null)
                _buildAirportDropdown(
                  label: 'To (Airport)',
                  icon: Icons.flight_land,
                  value: selectedDestAirportCode,
                  airports: destinationAirportsByCountry[selectedDestCountry]!,
                  onChanged: (code) {
                    setState(() {
                      selectedDestAirportCode = code;
                    });
                  },
                ),
              if (selectedDestCountry != null) const SizedBox(height: 16),

              // Return Leg Pickup (only for round trip)
              if (bookingState.tripType == TripType.roundTrip &&
                  selectedDestCountry != null) ...[
                _buildAirportDropdown(
                  label: 'Return From',
                  icon: Icons.flight_takeoff,
                  value: selectedReturnPickupCode,
                  airports: destinationAirportsByCountry[selectedDestCountry]!,
                  onChanged: (code) {
                    setState(() {
                      selectedReturnPickupCode = code;
                    });
                  },
                ),
                const SizedBox(height: 16),
              ],
            ],
            const SizedBox(height: 8),

            // Dates
            Row(
              children: [
                Expanded(
                  child: _buildDatePicker(
                    context,
                    label: 'Departure',
                    selectedDate: bookingState.departureDate,
                    onPicked: (d) =>
                        setState(() => bookingState.departureDate = d),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: bookingState.tripType == TripType.oneWay
                      ? Container() // Hide for one-way trips
                      : _buildDatePicker(
                          context,
                          label: 'Return',
                          selectedDate: bookingState.returnDate,
                          onPicked: (d) =>
                              setState(() => bookingState.returnDate = d),
                        ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Passengers
            Text(
              'Passengers',
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
            const SizedBox(height: 12),
            _buildPassengerCounter(
              label: 'Adults',
              subLabel: '12+ yrs',
              count: bookingState.adults,
              onChanged: (val) => setState(() => bookingState.adults = val),
            ),
            _buildPassengerCounter(
              label: 'Children',
              subLabel: '2-12 yrs',
              count: bookingState.children,
              onChanged: (val) => setState(() => bookingState.children = val),
            ),
            _buildPassengerCounter(
              label: 'Infants',
              subLabel: '< 2 yrs',
              count: bookingState.infants,
              onChanged: (val) => setState(() => bookingState.infants = val),
            ),
            const SizedBox(height: 24),

            // Class Selection
            Text(
              'Class',
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
            const SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: FlightClass.values.map((cls) {
                  final isSelected = bookingState.flightClass == cls;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(cls.name.toUpperCase()),
                      selected: isSelected,
                      selectedColor: AppTheme.maryOrangeRed,
                      backgroundColor: Colors.white10,
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : Colors.white70,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                      onSelected: (sel) {
                        if (sel) setState(() => bookingState.flightClass = cls);
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 32),

            // Search Action
            CustomButton(
              text: 'Search Flights',
              icon: Icons.search,
              onPressed: () {
                // TODO: Validate inputs
                _nextStep();
              },
            ),
          ],
        ),
      ),
    );
  }

  // --- Widgets ---

  Widget _buildTripTypeChip(BookingState state, TripType type, String label) {
    final isSelected = state.tripType == type;
    return GestureDetector(
      onTap: () => setState(() => state.tripType = type),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.maryOrangeRed : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppTheme.maryOrangeRed : Colors.white24,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.white70,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildAirportDropdown({
    required String label,
    required IconData icon,
    required String? value,
    required List<Map<String, String>> airports,
    required Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.4),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white12),
          ),
          child: Row(
            children: [
              Icon(icon, color: AppTheme.maryGold, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: value,
                    hint: Text(
                      'Select Airport',
                      style: TextStyle(color: Colors.white.withOpacity(0.3)),
                    ),
                    isExpanded: true,
                    dropdownColor: AppTheme.maryBlack,
                    style: const TextStyle(color: Colors.white),
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.white70,
                    ),
                    items: airports.map((airport) {
                      return DropdownMenuItem<String>(
                        value: airport['code'],
                        child: Text(
                          '${airport['code']} - ${airport['name']}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      );
                    }).toList(),
                    onChanged: onChanged,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCountryDropdown({
    required String label,
    required IconData icon,
    required String? value,
    required List<String> countries,
    required Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.4),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white12),
          ),
          child: Row(
            children: [
              Icon(icon, color: AppTheme.maryGold, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: value,
                    hint: Text(
                      'Select Country',
                      style: TextStyle(color: Colors.white.withOpacity(0.3)),
                    ),
                    isExpanded: true,
                    dropdownColor: AppTheme.maryBlack,
                    style: const TextStyle(color: Colors.white),
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.white70,
                    ),
                    items: countries.map((country) {
                      return DropdownMenuItem<String>(
                        value: country,
                        child: Text(
                          country,
                          style: const TextStyle(color: Colors.white),
                        ),
                      );
                    }).toList(),
                    onChanged: onChanged,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required IconData icon,
    String? value,
    required Function(String) onChanged,
    required String placeholder,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.4),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white12),
          ),
          child: Row(
            children: [
              Icon(icon, color: AppTheme.maryGold, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  style: const TextStyle(color: Colors.white),
                  onChanged: onChanged,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: placeholder,
                    hintStyle: TextStyle(color: Colors.white.withOpacity(0.3)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDatePicker(
    BuildContext context, {
    required String label,
    required DateTime? selectedDate,
    required Function(DateTime) onPicked,
  }) {
    return GestureDetector(
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 365)),
        );
        if (date != null) onPicked(date);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.4),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white12),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.calendar_today,
                  color: AppTheme.maryGreen,
                  size: 18,
                ),
                const SizedBox(width: 8),
                Text(
                  selectedDate == null
                      ? 'Select Date'
                      : '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPassengerCounter({
    required String label,
    required String subLabel,
    required int count,
    required Function(int) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                subLabel,
                style: const TextStyle(color: Colors.white38, fontSize: 12),
              ),
            ],
          ),
          Row(
            children: [
              _buildCounterBtn(
                Icons.remove,
                () => count > 0 ? onChanged(count - 1) : null,
              ),
              SizedBox(
                width: 30,
                child: Center(
                  child: Text(
                    '$count',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              _buildCounterBtn(Icons.add, () => onChanged(count + 1)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCounterBtn(IconData icon, VoidCallback? onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }

  Widget _buildPhase2Flights() {
    final bookingState = context.watch<BookingState>();
    final isRoundTrip = bookingState.tripType == TripType.roundTrip;

    // Mock Flight Data Generator (Simplistic)
    List<Map<String, dynamic>> getMockFlights(String type) {
      return [
        {'time': '06:00 - 08:30', 'price': 12500, 'flight': 'KQ101'},
        {'time': '10:00 - 12:30', 'price': 15800, 'flight': 'KQ105'},
        {'time': '18:00 - 20:30', 'price': 11400, 'flight': 'KQ109'},
      ];
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppTheme.spacingM),
      child: WizardCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppTheme.maryGreen.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.airplanemode_active,
                    color: AppTheme.maryGreen,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'Select Flights',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Outbound
            Text(
              'Outbound: ${bookingState.origin ?? "NBO"} -> ${bookingState.destination ?? "MBA"}',
              style: const TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            ...getMockFlights('outbound')
                .map((flight) => _buildFlightOption(bookingState, flight, true))
                .toList(),

            if (isRoundTrip) ...[
              const SizedBox(height: 24),
              Text(
                'Return: ${bookingState.destination ?? "MBA"} -> ${bookingState.origin ?? "NBO"}',
                style: const TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              ...getMockFlights('return')
                  .map(
                    (flight) => _buildFlightOption(bookingState, flight, false),
                  )
                  .toList(),
            ],

            const SizedBox(height: 32),

            // Fare Tiers (Simplistic)
            Text(
              'Fare Class: ${bookingState.flightClass.name.toUpperCase()}',
              style: const TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        bookingState.selectedFareTier = 'Basic';
                      });
                    },
                    child: _buildFareTierCard(
                      'Basic',
                      0,
                      bookingState.selectedFareTier == 'Basic',
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        bookingState.selectedFareTier = 'Flex';
                      });
                    },
                    child: _buildFareTierCard(
                      'Flex',
                      4500,
                      bookingState.selectedFareTier == 'Flex',
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Ancillaries
            _buildAncillaryOption('Add Baggage (23kg)', 'KES 3,500', 'baggage'),
            _buildAncillaryOption('Travel Insurance', 'KES 1,500', 'insurance'),

            const SizedBox(height: 32),
            CustomButton(text: 'Continue to Passengers', onPressed: _nextStep),
          ],
        ),
      ),
    );
  }

  Widget _buildFlightOption(
    BookingState state,
    Map<String, dynamic> flight,
    bool isOutbound,
  ) {
    // Determine if selected
    final selectedFlight = isOutbound
        ? state.selectedOutboundFlight
        : state.selectedReturnFlight;
    final isSelected =
        selectedFlight != null && selectedFlight['flight'] == flight['flight'];

    return GestureDetector(
      onTap: () {
        setState(() {
          if (isOutbound) {
            state.selectedOutboundFlight = flight;
          } else {
            state.selectedReturnFlight = flight;
          }
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected
              ? AppTheme.maryOrangeRed.withOpacity(0.2)
              : Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppTheme.maryOrangeRed : Colors.white12,
          ),
        ),
        child: Row(
          children: [
            const Icon(Icons.flight_takeoff, color: Colors.white70, size: 20),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  flight['time'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  flight['flight'],
                  style: const TextStyle(color: Colors.white54, fontSize: 12),
                ),
              ],
            ),
            const Spacer(),
            Text(
              'KES ${flight['price']}',
              style: const TextStyle(
                color: AppTheme.maryGold,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFareTierCard(String name, int addedCost, bool isSelected) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isSelected ? Colors.white24 : Colors.white10,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? Colors.white : Colors.transparent,
        ),
      ),
      child: Column(
        children: [
          Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '+ KES $addedCost',
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildAncillaryOption(String label, String price, String ancillaryId) {
    final bookingState = context.watch<BookingState>();
    final isSelected = bookingState.selectedAncillaries.contains(ancillaryId);

    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            bookingState.selectedAncillaries.remove(ancillaryId);
          } else {
            bookingState.selectedAncillaries.add(ancillaryId);
          }
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.check_box : Icons.check_box_outline_blank,
              color: isSelected ? AppTheme.maryGreen : Colors.white54,
            ),
            const SizedBox(width: 12),
            Text(label, style: const TextStyle(color: Colors.white)),
            const Spacer(),
            Text(price, style: const TextStyle(color: AppTheme.maryGold)),
          ],
        ),
      ),
    );
  }

  Widget _buildPhase4Payment() {
    final bookingState = context.watch<BookingState>();
    final totalPax =
        bookingState.adults + bookingState.children + bookingState.infants;
    // Real Pricing Logic
    double totalCost = 0;

    // 1. Flight Base Price
    double outboundPrice = (bookingState.selectedOutboundFlight?['price'] ?? 0)
        .toDouble();
    double returnPrice = (bookingState.selectedReturnFlight?['price'] ?? 0)
        .toDouble();
    double flightBase = outboundPrice + returnPrice;

    // 2. Fare Tier
    if (bookingState.selectedFareTier == 'Flex') {
      flightBase += 4500;
    }

    // 3. Multiplier by Pax
    totalCost += flightBase * totalPax;

    // 4. Ancillaries (Selecting per pax for simplicity in this logic)
    if (bookingState.selectedAncillaries.contains('baggage'))
      totalCost += 3500 * totalPax;
    if (bookingState.selectedAncillaries.contains('insurance'))
      totalCost += 1500 * totalPax;

    // 5. Taxes (Approx 15% of base)
    double taxes = totalCost * 0.15;
    totalCost += taxes;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppTheme.spacingM),
      child: WizardCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppTheme.maryGreen.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.payment,
                    color: AppTheme.maryGreen,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'Payment',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Order Summary
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white12),
              ),
              child: Column(
                children: [
                  _buildSummaryRow(
                    'Flight',
                    '${bookingState.origin ?? "NBO"} <-> ${bookingState.destination ?? "MBA"}',
                  ),
                  const SizedBox(height: 8),
                  _buildSummaryRow(
                    'Trip Type',
                    bookingState.tripType == TripType.roundTrip
                        ? 'Round Trip'
                        : 'One Way',
                  ),
                  const SizedBox(height: 8),
                  _buildSummaryRow('Passengers', '$totalPax'),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    child: Divider(color: Colors.white12),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        'KES ${totalCost.toStringAsFixed(0)}',
                        style: const TextStyle(
                          color: AppTheme.maryGold,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Payment Method
            Text(
              'Payment Method',
              style: const TextStyle(color: Colors.white70, fontSize: 14),
            ),
            const SizedBox(height: 12),
            _buildPaymentMethodOption(
              Icons.credit_card,
              'Credit / Debit Card',
              true,
            ),
            _buildPaymentMethodOption(Icons.phone_android, 'M-Pesa', false),

            const SizedBox(height: 32),
            CustomButton(
              text: 'Pay KES ${totalCost.toStringAsFixed(0)}',
              onPressed: _completeBooking,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _completeBooking() async {
    // Show Loading
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (c) => const Center(
        child: CircularProgressIndicator(color: AppTheme.maryGreen),
      ),
    );

    try {
      final bookingState = context.read<BookingState>();
      final pnr = 'KQ-${(DateTime.now().millisecondsSinceEpoch % 10000)}';
      final firestore = FirebaseFirestore.instance;

      // Logic to generate tickets (Reused from _buildPhase5Confirmation logic ideally, but replicating here for saving)
      // We need to generate the ACTUAL ticket objects to save them.
      // For simplicity, I will use the same generation logic as confirmation or extract it.
      // Let's implement the generation here directly to ensure we save what we display.

      final tickets = <Ticket>[];

      void addTickets(
        Map<String, dynamic>? flight,
        DateTime date,
        bool isReturn,
      ) {
        if (flight == null) return;
        final timeParts = (flight['time'] as String).split(' - ');
        final depTimeStr = timeParts[0];
        final arrTimeStr = timeParts[1];

        final depTime = _parseTime(depTimeStr);
        final arrTime = _parseTime(arrTimeStr);

        final depDateTime = DateTime(
          date.year,
          date.month,
          date.day,
          depTime.hour,
          depTime.minute,
        );
        var arrDateTime = DateTime(
          date.year,
          date.month,
          date.day,
          arrTime.hour,
          arrTime.minute,
        );
        if (arrDateTime.isBefore(depDateTime))
          arrDateTime = arrDateTime.add(const Duration(days: 1));

        for (var pax in bookingState.passengers) {
          tickets.add(
            Ticket.create(
              pnr: pnr,
              flightNumber: flight['flight'],
              origin: isReturn
                  ? (bookingState.destination ?? 'MBA')
                  : (bookingState.origin ?? 'NBO'),
              destination: isReturn
                  ? (bookingState.origin ?? 'NBO')
                  : (bookingState.destination ?? 'MBA'),
              departureTime: depDateTime,
              arrivalTime: arrDateTime,
              passengerName: pax.fullName ?? 'Guest',
              seatNumber: pax.selectedSeat ?? 'ANY',
              cabinClass: bookingState.flightClass.name.toUpperCase(),
              nationality: pax.nationality ?? 'KE',
            ),
          );
        }
      }

      if (bookingState.selectedOutboundFlight != null &&
          bookingState.departureDate != null) {
        addTickets(
          bookingState.selectedOutboundFlight,
          bookingState.departureDate!,
          false,
        );
      }
      if (bookingState.tripType == TripType.roundTrip &&
          bookingState.selectedReturnFlight != null &&
          bookingState.returnDate != null) {
        addTickets(
          bookingState.selectedReturnFlight,
          bookingState.returnDate!,
          true,
        );
      }

      // Save to Firestore
      final batch = firestore.batch();
      for (var ticket in tickets) {
        final docRef = firestore.collection('bookings').doc();
        batch.set(docRef, ticket.toJson());
      }
      await batch.commit();

      Navigator.pop(context); // dismiss loader
      _nextStep(); // Go to confirmation
    } catch (e) {
      Navigator.pop(context); // dismiss loader
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Booking Failed: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  TimeOfDay _parseTime(String s) {
    final parts = s.split(':');
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }

  Widget _buildSummaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: Colors.white54)),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentMethodOption(
    IconData icon,
    String label,
    bool isSelected,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isSelected
            ? AppTheme.maryOrangeRed.withOpacity(0.1)
            : Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? AppTheme.maryOrangeRed : Colors.white12,
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 16),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          if (isSelected)
            const Icon(
              Icons.check_circle,
              color: AppTheme.maryOrangeRed,
              size: 20,
            ),
        ],
      ),
    );
  }

  Widget _buildPhase5Confirmation() {
    final bookingState = context.read<BookingState>();
    final pnr = 'KQ-${(DateTime.now().millisecondsSinceEpoch % 10000)}';

    // Generate Tickets
    final tickets = <Ticket>[];

    // Helper to add tickets for a leg
    void addTickets(
      Map<String, dynamic>? flight,
      DateTime date,
      bool isReturn,
    ) {
      if (flight == null) return;

      // Parse time string '06:00 - 08:30'
      final timeParts = (flight['time'] as String).split(' - ');
      final depTimeStr = timeParts[0];
      final arrTimeStr = timeParts[1];

      TimeOfDay _parseTime(String s) {
        final parts = s.split(':');
        return TimeOfDay(
          hour: int.parse(parts[0]),
          minute: int.parse(parts[1]),
        );
      }

      final depTime = _parseTime(depTimeStr);
      final arrTime = _parseTime(arrTimeStr);

      final depDateTime = DateTime(
        date.year,
        date.month,
        date.day,
        depTime.hour,
        depTime.minute,
      );
      // Handle overnight? Assuming same day or next day for simplicity in mock
      var arrDateTime = DateTime(
        date.year,
        date.month,
        date.day,
        arrTime.hour,
        arrTime.minute,
      );
      if (arrDateTime.isBefore(depDateTime)) {
        arrDateTime = arrDateTime.add(const Duration(days: 1));
      }

      for (var pax in bookingState.passengers) {
        // Determine Trip Origin/Dest Context
        // Trip Origin: Always Kenya/NBO for this flow
        const tripOriginCountry = 'Kenya';
        const tripOriginLang = 'sw';
        const tripOriginCode = 'NBO';

        // Trip Destination: The selected destination
        final tripDestCode =
            bookingState.destination ?? selectedDestAirportCode ?? 'DXB';
        final tripDestName =
            selectedDestCountry ?? 'Dubai'; // Name of country or city
        final tripDestLang = CountryUtils.getPrimaryLanguageCode(
          selectedDestCountry?.substring(0, 2) ?? 'AE',
        );

        // Assign based on leg (Outbound vs Return)
        final ticketOriginCode = isReturn ? tripDestCode : tripOriginCode;
        final ticketDestCode = isReturn ? tripOriginCode : tripDestCode;

        final ticketOriginCountry = isReturn ? tripDestName : tripOriginCountry;
        final ticketOriginLang = isReturn ? tripDestLang : tripOriginLang;

        final ticketDestCountry = isReturn ? tripOriginCountry : tripDestName;
        final ticketDestLang = isReturn ? tripOriginLang : tripDestLang;

        tickets.add(
          Ticket.create(
            pnr: pnr,
            flightNumber: flight['flight'],
            origin: ticketOriginCode,
            destination: ticketDestCode,
            departureTime: depDateTime,
            arrivalTime: arrDateTime,
            passengerName: pax.fullName ?? 'Guest',
            seatNumber: pax.selectedSeat ?? 'ANY',
            cabinClass:
                pax.seatClass?.name.toUpperCase() ??
                bookingState.flightClass.name.toUpperCase(),
            // Mock data for new fields
            nationality: pax.nationality ?? 'KE',
            profileImageBytes: pax.passportPhotoBytes,
            originCountry: ticketOriginCountry,
            originLanguage: ticketOriginLang,
            destinationCountry: ticketDestCountry,
            destinationLanguage: ticketDestLang,
          ),
        );
      }
    }

    // Add Outbound
    if (bookingState.selectedOutboundFlight != null &&
        bookingState.departureDate != null) {
      addTickets(
        bookingState.selectedOutboundFlight,
        bookingState.departureDate!,
        false,
      );
    }

    // Add Return
    if (bookingState.tripType == TripType.roundTrip &&
        bookingState.selectedReturnFlight != null &&
        bookingState.returnDate != null) {
      addTickets(
        bookingState.selectedReturnFlight,
        bookingState.returnDate!,
        true,
      );
    }

    // Fallback if no flights selected (shouldn't happen in flow)
    if (tickets.isEmpty) {
      // Mock for testing visuals if state is empty
      tickets.add(
        Ticket.create(
          pnr: pnr,
          flightNumber: 'KQ101',
          origin: 'NBO',
          destination: 'MBA',
          departureTime: DateTime.now(),
          arrivalTime: DateTime.now().add(const Duration(hours: 1)),
          passengerName: 'Victor',
          seatNumber: '1A',
          cabinClass: 'Business',
          nationality: 'KE',
          originCountry: 'Kenya',
          originLanguage: 'en',
          destinationCountry: 'Destination',
          destinationLanguage: 'en',
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppTheme.spacingM),
      child: Column(
        children: [
          const SizedBox(height: 20),
          // Success Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.maryGreen.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check_circle,
              color: AppTheme.maryGreen,
              size: 60,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Booking Confirmed!',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Ref: $pnr',
            style: const TextStyle(
              color: AppTheme.maryGold,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Your e-tickets have been sent to your email.',
            style: TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 24),

          // Tickets List
          SingleChildScrollView(
            child: Column(
              children: tickets
                  .map((t) => HorizontalETicketCard(ticket: t))
                  .toList(),
            ),
          ),

          const SizedBox(height: 24),

          // Booking Management Options
          BookingActionsCard(
            tickets: tickets,
            onRemove: (ticket) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Removing ticket for ${ticket.passengerName}...',
                  ),
                ),
              );
              // In a real app, you'd call bookingState.removePassenger(ticket.passengerId)
              // For now, we simulate by re-building or just showing feedback
            },
            onReschedule: (ticket) async {
              final date = await showDatePicker(
                context: context,
                initialDate: bookingState.departureDate ?? DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 365)),
              );
              if (date != null) {
                // Update booking state which will regenerate tickets
                context.read<BookingState>().updateDepartureDate(date);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Flight rescheduled. New ticket generated.'),
                  ),
                );
              }
            },
            onShare: (ticket) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Row(
                    children: [
                      Icon(Icons.share, color: Colors.white),
                      SizedBox(width: 8),
                      Text('Sharing to WhatsApp...'),
                    ],
                  ),
                  backgroundColor: Colors.green,
                ),
              );
            },
          ),

          const SizedBox(height: 32),
          CustomButton(
            text: 'Return to Home',
            onPressed: () {
              // Reset or Pop
              Navigator.pop(context);
            },
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
  // --- Seat Selection Integration ---

  void _openSeatMapModal(
    BuildContext context,
    BookingState bookingState,
  ) async {
    // 1. Prepare Data
    if (_cabin == null) {
      _cabin = _createMockCabin();
    }

    // Convert Booking Passengers to Seat Passengers
    final seatPassengers = bookingState.passengers.asMap().entries.map((entry) {
      final index = entry.key;
      final p = entry.value;
      return ss_models.SeatPassenger(
        id: 'PAX-$index', // Simple ID
        firstName: p.fullName?.split(' ').first ?? 'Passenger',
        lastName:
            p.fullName?.split(' ').length != null &&
                p.fullName!.split(' ').length > 1
            ? p.fullName!.split(' ').last
            : '$index',
        pnr: 'TEMP',
        frequentFlyerNumber: '',
        frequentFlyerTier: 'Blue',
        hasSpecialAssistance: false,
        specialRequests: [],
        mealPreference: 'Standard',
        ticketNumber: '',
        fareBasis: bookingState.flightClass == FlightClass.first
            ? 'F'
            : bookingState.flightClass == FlightClass.business
            ? 'J'
            : 'Y',
      );
    }).toList();

    // 2. Initialize Service with Filtered Cabin based on Selection

    // Filter sections to show ONLY the selected class
    // Map FlightClass to Section Name prefix/match
    String targetSectionName;
    switch (bookingState.flightClass) {
      case FlightClass.first:
        targetSectionName = 'First';
        break;
      case FlightClass.business:
        targetSectionName = 'Business';
        break;

      case FlightClass.economy:
        targetSectionName = 'Economy';
        break;
    }

    final filteredSections = _cabin!.sections.where((s) {
      return s.name.contains(targetSectionName);
    }).toList();

    // Create a temporary filtered cabin for display
    final displayedCabin = ss_models.AircraftCabin(
      aircraftType: _cabin!.aircraftType,
      airlineCode: _cabin!.airlineCode,
      registration: _cabin!.registration,
      configurationId: _cabin!.configurationId,
      sections: filteredSections,
      totalSeats: _cabin!.totalSeats,
      seatMap: _cabin!.seatMap,
      lastUpdated: _cabin!.lastUpdated,
      version: _cabin!.version,
      cabinLayout: _cabin!.cabinLayout,
    );

    await _seatService.initialize(
      cabin: displayedCabin,
      passengers: seatPassengers,
      rules: ss_models.SeatSelectionRules(
        allowMultipleSeats: true,
        allowFamilySeating: true,
        allowExitRowForMinors: false,
        allowBulkheadForInfants: true,
        allowPremiumUpgrade: true,
        maxSeatSelectionTime: 10.0,
        restrictedSeats: [],
        pricingRules: {},
        blockedRows: [],
      ),
    );

    // Pre-select seats if already in booking state
    // (This is a simplified re-hydration. In full prod, sync properly)

    if (!mounted) return;

    // 3. Show Modal
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.9,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.maryBlack,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Select Your Seats',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),

            // Seat Map
            Expanded(
              child: AircraftSeatMap(
                cabin: _cabin!,
                passengers: seatPassengers,
                onSelectionChanged: (seats) {
                  // Real-time updates if needed
                },
              ),
            ),

            // Footer
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                border: Border(top: BorderSide(color: Colors.grey[300]!)),
              ),
              child: Column(
                children: [
                  ValueListenableBuilder<double>(
                    valueListenable: _seatService.totalSeatCharge,
                    builder: (context, total, _) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total Seat Charges',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '\$${total.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => _seatService.autoAssignSeats(),
                          child: const Text('Auto Assign'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ValueListenableBuilder<bool>(
                          valueListenable: _seatService.isSelectionValid,
                          builder: (context, isValid, child) {
                            // Allow confirm even if partial for now, or enforce strict?
                            // Let's enforce strictly if service says so, or at least check if seats selected.
                            return ElevatedButton(
                              onPressed: () {
                                _saveSelectedSeats(bookingState);
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.maryGreen,
                                foregroundColor: Colors.white,
                              ),
                              child: const Text('Confirm Seats'),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _saveSelectedSeats(BookingState bookingState) {
    final selected = _seatService.selectedSeats.value;
    for (var seat in selected) {
      // Find passenger by ID (we used 'PAX-$index')
      final indexStr = seat.passengerId.replaceAll('PAX-', '');
      final index = int.tryParse(indexStr);
      if (index != null && index < bookingState.passengers.length) {
        final pax = bookingState.passengers[index];
        pax.selectedSeat = seat.seatNumber;

        // Map compartment to SeatClass
        if (seat.compartment == 'First')
          pax.seatClass = SeatClass.first;
        else if (seat.compartment == 'Business')
          pax.seatClass = SeatClass.business;
        else
          pax.seatClass = SeatClass.economy;
      }
    }
    // Trigger rebuild to update button states
    setState(() {});
  }

  ss_models.AircraftCabin _createMockCabin() {
    // Create a mock Boeing 777-300ER cabin
    final sections = [
      ss_models.CabinSection(
        name: 'First',
        startRow: 1,
        endRow: 4,
        seatArrangement: '1-2-1',
        seats: _createSeatsForSection('First', 1, 4, '1-2-1'),
        sectionColor: Colors.blue,
        basePrice: 0.0,
        amenities: ['Lie-flat', 'Suite', 'Fine Dining', 'Premium Amenities'],
      ),
      ss_models.CabinSection(
        name: 'Business',
        startRow: 5,
        endRow: 12, // Reduced for demo
        seatArrangement: '2-3-2',
        seats: _createSeatsForSection('Business', 5, 12, '2-3-2'),
        sectionColor: Colors.purple,
        basePrice: 150.0,
        amenities: ['Lie-flat', 'Direct Aisle', 'Premium Dining', 'WiFi'],
      ),
      ss_models.CabinSection(
        name: 'Economy',
        startRow: 13,
        endRow: 30, // Reduced for demo
        seatArrangement: '3-4-3',
        seats: _createSeatsForSection('Economy', 13, 30, '3-4-3'),
        sectionColor: AppTheme.maryGreen,
        basePrice: 0.0,
        amenities: ['Standard', 'Meal Service', 'Entertainment'],
      ),
    ];

    return ss_models.AircraftCabin(
      aircraftType: 'B77W',
      registration: 'N123AA',
      airlineCode: 'AA',
      configurationId: '77W-F4-J30-Y300',
      sections: sections,
      totalSeats: 334,
      seatMap: {},
      lastUpdated: DateTime.now(),
      version: '1.0',
      cabinLayout: '1-2-1/2-3-2/3-4-3',
    );
  }

  List<ss_models.AircraftSeat> _createSeatsForSection(
    String section,
    int startRow,
    int endRow,
    String arrangement,
  ) {
    final seats = <ss_models.AircraftSeat>[];
    final seatLetters = arrangement.split('-').expand((count) {
      final intCount = int.parse(count);
      return List.generate(
        intCount,
        (index) => String.fromCharCode(65 + index),
      );
    }).toList(); // A, B, C... should skip I but let's keep simple

    // Correct letters for 1-2-1 might be A - DG - K
    // But for this generic demo we just use A,B,C...

    for (int row = startRow; row <= endRow; row++) {
      for (int i = 0; i < seatLetters.length; i++) {
        final seatLetter = seatLetters[i];
        final seatNumber = '$row$seatLetter';

        seats.add(
          ss_models.AircraftSeat(
            seatNumber: seatNumber,
            compartment: section,
            seatType: _determineSeatType(seatLetter, seatLetters),
            seatPosition: ss_models.SeatPosition.mid,
            fareClass: section == 'First'
                ? 'F'
                : section == 'Business'
                ? 'J'
                : 'Y',
            price: _calculateSeatPrice(section, row),
            seatPitch: section == 'Economy' ? 31.0 : 70.0,
            seatWidth: 17.0,
            isExitRow: row == 20,
            isBulkhead: row == startRow,
            isExtraLegroom: section == 'Economy' && row == 20,
            isPreferred: false,
            hasPowerOutlet: section != 'Economy',
            hasInSeatScreen: true,
            hasWifi: true,
            isLavatoryAdjacent: false,
            isGalleyAdjacent: false,
            isInfantAllowed: true,
            isBassinetLocation: false,
            isCrewRest: false,
            isBlocked: false,
            isOccupied: (seatNumber.hashCode % 10 < 3), // 30% random occupancy
            passengerName: '',
            passengerId: '',
            amenities: [],
            seatMapCoordinate: '',
            reclineAngle: 0,
            isLieFlat: section != 'Economy',
            seatFeature: '',
            seatManufacturer: '',
            seatModel: '',
            seatWeight: 0,
            isSelected: false,
            isAvailable: !(seatNumber.hashCode % 10 < 3),
          ),
        );
      }
    }

    return seats;
  }

  ss_models.SeatType _determineSeatType(String letter, List<String> letters) {
    if (letter == letters.first || letter == letters.last)
      return ss_models.SeatType.window;
    if (letter == 'C' || letter == 'D' || letter == 'G' || letter == 'H')
      return ss_models.SeatType.aisle;
    return ss_models.SeatType.middle;
  }

  double _calculateSeatPrice(String section, int row) {
    if (section == 'First') return 0;
    if (section == 'Business') return 100;
    if (row == 20) return 50; // Exit row
    return 0;
  }
}
