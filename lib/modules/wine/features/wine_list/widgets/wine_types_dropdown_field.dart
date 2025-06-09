import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../domain/entities/wine_type_entity.dart';
import '../bloc/wine-types-list/wine_types_list_bloc.dart';

class WineTypesDropdownField extends StatelessWidget {
  final WineTypeEntity? selectedWineType;
  final ValueChanged<WineTypeEntity?> onChanged;
  final bool required;

  const WineTypesDropdownField({
    super.key,
    required this.selectedWineType,
    required this.onChanged,
    this.required = true,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WineTypesListBloc, WineTypesListState>(
      builder: (context, state) {
        if (state is WineTypesListLoading) {
          return const CircularProgressIndicator();
        } else if (state is WineTypesListLoaded) {
          final wineTypes = state.wineTypes;
          return FormBuilderDropdown<WineTypeEntity>(
            name: 'wine_type_id',
            decoration: InputDecoration(
              labelText: context.tr('wineTypesPage.newWineTypeDialog.wineTypeNameField.label'),
              border: OutlineInputBorder(),
            ),
            initialValue: wineTypes.contains(selectedWineType) ? selectedWineType : null,
            items: wineTypes.map<DropdownMenuItem<WineTypeEntity>>((wineType) {
              return DropdownMenuItem<WineTypeEntity>(
                value: wineType,
                child: Text(wineType.label),
              );
            }).toList(),
            onChanged: onChanged,
            validator: (value) {
              if (required && value == null) {
                return context.tr('wineTypesPage.newWineTypeDialog.wineTypeNameField.validator');
              }
              return null;
            },
          );
        } else if (state is WineTypesListError) {
          return Text(state.message, style: const TextStyle(color: Colors.red));
        }
        return const SizedBox.shrink();
      },
    );
  }
}
