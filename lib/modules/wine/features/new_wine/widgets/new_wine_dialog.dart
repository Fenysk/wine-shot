import 'package:clean_starter/modules/wine/features/new_wine/widgets/alcohol_pourcentage_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../../../_core/di.dart';
import '../../../../../_shared/domain/entities/region_entity.dart';
import '../../../../../_shared/widgets/show_toast_notification.dart';
import '../../../../producer/domain/entities/producer_entity.dart';
import '../../../../producer/widgets/producer_dropdown_field.dart';
import '../../../../region/features/region_list/widgets/region_dropdown_field.dart';
import '../../../data/dto/new_wine_dto.dart';
import '../../../domain/entities/wine_type_entity.dart';
import '../../wine_list/bloc/wine-list/wine_list_bloc.dart';
import '../../wine_list/bloc/wine-list/wine_list_event.dart';
import '../../wine_list/widgets/wine_types_dropdown_field.dart';
import '../bloc/new_wine_bloc.dart';

import 'description_field.dart';
import 'wine_name_field.dart';

class NewWineDialog extends StatefulWidget {
  final Widget Function(BuildContext context, Widget content, List<Widget> actions) builder;

  const NewWineDialog({super.key, required this.builder});

  @override
  State<NewWineDialog> createState() => _NewWineDialogState();
}

class _NewWineDialogState extends State<NewWineDialog> {
  final _formKey = GlobalKey<FormBuilderState>();
  final _nameController = TextEditingController();
  final _alcoholPercentageController = TextEditingController();
  final _descriptionController = TextEditingController();

  RegionEntity? _selectedRegion;
  ProducerEntity? _selectedProducer;
  WineTypeEntity? _selectedWineType;

  @override
  void dispose() {
    _nameController.dispose();
    _alcoholPercentageController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      if (_nameController.text.isEmpty) return;

      final wineDto = NewWineDto(
        name: _nameController.text,
        alcoholPercentage: double.tryParse(_alcoholPercentageController.text),
        volume: null,
        description: _descriptionController.text,
        producerId: _selectedProducer?.id,
        regionId: _selectedRegion?.id,
        wineTypeId: _selectedWineType?.id,
      );

      context.read<NewWineBloc>().add(CreateWineEvent(wineDto));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NewWineBloc, NewWineState>(
      listener: (context, state) {
        if (state.status == NewWineStatus.success) {
          Navigator.of(context).pop();
          context.read<WineListBloc>().add(LoadWinesEvent());
        } else if (state.status == NewWineStatus.failure) {
          CustomToast.showErrorNotification(
            title: 'Oups !',
            description: state.errorMessage ?? 'Une erreur est survenue : ${state.errorMessage}',
          );
        }
      },
      child: BlocBuilder<NewWineBloc, NewWineState>(
        builder: (context, state) {
          final content = FormBuilder(
            key: _formKey,
            child: Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(right: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 16,
                  children: [
                    WineNameField(controller: _nameController),
                    AlcoholPercentageField(controller: _alcoholPercentageController),
                    DescriptionField(controller: _descriptionController),
                    RegionDropdownField(
                      selectedRegion: _selectedRegion,
                      onChanged: _updateSelectRegion,
                      required: false,
                    ),
                    ProducerDropdownField(
                      selectedProducer: _selectedProducer,
                      onChanged: _updateSelectProducer,
                      required: false,
                    ),
                    WineTypesDropdownField(
                      selectedWineType: _selectedWineType,
                      onChanged: _updateSelectWineType,
                      required: false,
                    ),
                  ],
                ),
              ),
            ),
          );

          final actions = [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(context.tr('common.cancel')),
            ),
            FilledButton(
              onPressed: state.status == NewWineStatus.loading ? null : _submitForm,
              child: state.status == NewWineStatus.loading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(context.tr('common.save')),
            ),
          ];

          return widget.builder(context, content, actions);
        },
      ),
    );
  }

  void _updateSelectRegion(RegionEntity? value) {
    setState(() => _selectedRegion = value);
  }

  void _updateSelectProducer(ProducerEntity? value) {
    setState(() => _selectedProducer = value);
  }

  void _updateSelectWineType(WineTypeEntity? value) {
    setState(() => _selectedWineType = value);
  }
}
