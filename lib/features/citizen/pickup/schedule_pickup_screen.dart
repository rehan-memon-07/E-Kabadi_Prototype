import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/constants/app_constants.dart';
import '../../../shared/widgets/custom_card.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/widgets/custom_text_field.dart';
import '../../../shared/widgets/custom_app_bar.dart';
import '../../../models/scrap_item_model.dart';
import '../../../providers/scrap_provider.dart';
import '../../../providers/pickup_provider.dart';
import '../../../core/utils/responsive_utils.dart';

class SchedulePickupScreen extends ConsumerStatefulWidget {
  const SchedulePickupScreen({super.key});

  @override
  ConsumerState<SchedulePickupScreen> createState() => _SchedulePickupScreenState();
}

class _SchedulePickupScreenState extends ConsumerState<SchedulePickupScreen> {
  String _selectedDate = 'Today, 18 Sep';
  String _selectedTimeSlot = AppConstants.timeSlots[1]; // 11 AM - 1 PM
  final TextEditingController _instructionsController = TextEditingController(text: 'Call me when you arrive');
  final String _address = 'Flat 402, Green Valley Apts, Sector 62, Noida, UP - 201301';

  void _onConfirmPickup() async {
    final items = ref.read(scrapScanProvider).analyzedItems;
    await ref.read(pickupProvider.notifier).createRequest(
      items: items.isEmpty
          ? [
              const ScrapItemModel(
                id: 'DEMO-1',
                category: 'Plastic',
                subType: 'PET Bottles',
                weightKg: 1.4,
                pricePerKg: 50,
                estimatedTotal: 70,
                confidenceScore: 0.94,
              ),
              const ScrapItemModel(
                id: 'DEMO-2',
                category: 'Paper',
                subType: 'Cardboard Boxes',
                weightKg: 3.2,
                pricePerKg: 15,
                estimatedTotal: 48,
                confidenceScore: 0.91,
              ),
            ]
          : items,
      date: _selectedDate,
      timeSlot: _selectedTimeSlot,
      address: _address,
      instructions: _instructionsController.text,
    );

    if (mounted) {
      context.push('/citizen/collector-matching');
    }
  }

  @override
  Widget build(BuildContext context) {
    final fs = Responsive.fontScale(context);
    final hp = Responsive.horizontalPadding(context);
    final p = Responsive.padding(context);
    final screenW = Responsive.screenWidth(context);

    return Scaffold(
      appBar: const CustomAppBar(title: 'Schedule Doorstep Pickup'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(hp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Pickup Address Card
              Text('Pickup Address', style: AppTypography.titleMedium.copyWith(fontSize: 18 * fs)),
              SizedBox(height: 10 * fs),
              CustomCard(
                padding: EdgeInsets.all(p * 0.8),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10 * fs),
                      decoration: const BoxDecoration(
                        color: AppColors.primaryLight,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(LucideIcons.mapPin, color: AppColors.primary, size: Responsive.iconSize(context, 24)),
                    ),
                    SizedBox(width: 14 * fs),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Home Address', style: AppTypography.titleSmall.copyWith(fontSize: 16 * fs)),
                          SizedBox(height: 2 * fs),
                          Text(
                            _address,
                            style: AppTypography.bodySmall.copyWith(fontSize: 12 * fs),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text('Change', style: AppTypography.labelLarge.copyWith(color: AppColors.primary, fontSize: 14 * fs)),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24 * fs),

              // Date Selection
              Text('Select Pickup Date', style: AppTypography.titleMedium.copyWith(fontSize: 18 * fs)),
              SizedBox(height: 10 * fs),
              Row(
                children: [
                  _buildDateTile('Today, 18 Sep', fs),
                  SizedBox(width: 10 * fs),
                  _buildDateTile('Tomorrow, 19 Sep', fs),
                  SizedBox(width: 10 * fs),
                  _buildDateTile('20 Sep', fs),
                ],
              ),
              SizedBox(height: 24 * fs),

              // Time Slot Selection
              Text('Select Preferred Time Slot', style: AppTypography.titleMedium.copyWith(fontSize: 18 * fs)),
              SizedBox(height: 10 * fs),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10 * fs,
                  mainAxisSpacing: 10 * fs,
                  childAspectRatio: screenW < 360 ? 2.0 : 2.5,
                ),
                itemCount: AppConstants.timeSlots.length,
                itemBuilder: (context, index) {
                  final slot = AppConstants.timeSlots[index];
                  final isSelected = _selectedTimeSlot == slot;
                  return CustomCard(
                    padding: EdgeInsets.symmetric(horizontal: 12 * fs),
                    color: isSelected ? AppColors.primaryLight : AppColors.surface,
                    border: Border.all(
                      color: isSelected ? AppColors.primary : AppColors.border,
                      width: isSelected ? 2 : 1,
                    ),
                    onTap: () {
                      setState(() {
                        _selectedTimeSlot = slot;
                      });
                    },
                    child: Center(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          slot,
                          style: AppTypography.titleSmall.copyWith(
                            color: isSelected ? AppColors.primaryDark : AppColors.textPrimary,
                            fontSize: 16 * fs,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 24 * fs),

              // Additional Instructions
              CustomTextField(
                label: 'Pickup Instructions (Optional)',
                hint: 'e.g., Ring bell twice, items kept at gate',
                controller: _instructionsController,
                prefixIcon: const Icon(LucideIcons.messageSquare, color: AppColors.textMuted),
              ),
              SizedBox(height: 32 * fs),

              CustomButton(
                text: 'Confirm Pickup Request',
                onPressed: _onConfirmPickup,
                icon: LucideIcons.checkCircle,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateTile(String label, double fs) {
    final isSelected = _selectedDate == label;
    return Expanded(
      child: CustomCard(
        padding: EdgeInsets.symmetric(vertical: 14 * fs),
        color: isSelected ? AppColors.primaryLight : AppColors.surface,
        border: Border.all(
          color: isSelected ? AppColors.primary : AppColors.border,
          width: isSelected ? 2 : 1,
        ),
        onTap: () {
          setState(() {
            _selectedDate = label;
          });
        },
        child: Center(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4 * fs),
              child: Text(
                label,
                style: AppTypography.titleSmall.copyWith(
                  color: isSelected ? AppColors.primaryDark : AppColors.textPrimary,
                  fontSize: 13 * fs,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
