import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../../../_shared/widgets/custom_dropdown_field.dart';
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
          return FormBuilderField<WineTypeEntity>(
            name: 'wine_type_id',
            initialValue: wineTypes.contains(selectedWineType) ? selectedWineType : null,
            validator: (value) {
              if (required && value == null) {
                return context.tr('wineTypesPage.newWineTypeDialog.wineTypeNameField.validator');
              }
              return null;
            },
            builder: (FormFieldState<WineTypeEntity> field) {
              return CustomDropdownField<WineTypeEntity>(
                initialValue: field.value,
                items: wineTypes,
                itemLabelBuilder: (wineType) => wineType.label,
                label: context.tr('wineTypesPage.newWineTypeDialog.wineTypeNameField.label'),
                searchHint: context.tr('common.dropdown.searchPlaceholder'),
                emptyText: context.tr('common.dropdown.noResults'),
              );
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
