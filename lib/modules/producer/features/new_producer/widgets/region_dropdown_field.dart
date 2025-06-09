import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../../../../_shared/domain/entities/region_entity.dart';
import '../../../../region/features/region_list/bloc/region_bloc.dart';

class RegionDropdownField extends StatelessWidget {
  final RegionEntity? selectedRegion;
  final ValueChanged<RegionEntity?> onChanged;

  const RegionDropdownField({
    super.key,
    required this.selectedRegion,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegionBloc, RegionState>(
      builder: (context, state) {
        if (state is RegionLoading) {
          return const CircularProgressIndicator();
        } else if (state is RegionLoaded) {
          final regions = state.regions;
          return FormBuilderDropdown<RegionEntity>(
            name: 'region_id',
            decoration: InputDecoration(
              labelText: context.tr('producersPage.newProducerDialog.regionDropdownField.label'),
              border: OutlineInputBorder(),
            ),
            initialValue: regions.contains(selectedRegion) ? selectedRegion : null,
            items: regions.map<DropdownMenuItem<RegionEntity>>((region) {
              return DropdownMenuItem<RegionEntity>(
                value: region,
                child: Text(region.name),
              );
            }).toList(),
            onChanged: onChanged,
            validator: (value) {
              if (value == null) {
                return context.tr('producersPage.newProducerDialog.regionDropdownField.validator');
              }
              return null;
            },
          );
        } else if (state is RegionError) {
          return Text(state.message, style: const TextStyle(color: Colors.red));
        }
        return const SizedBox.shrink();
      },
    );
  }
}
