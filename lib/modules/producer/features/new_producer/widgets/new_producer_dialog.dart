import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../_shared/domain/entities/region_entity.dart';
import '../../../../../_shared/widgets/custom_dialog.dart';
import '../../../bloc/producer_bloc.dart';
import '../../../data/dto/new_producer_dto.dart';
import '../bloc/new_producer_bloc.dart';
import '../../../../region/features/region_list/bloc/region_bloc.dart';

class NewProducerDialog extends StatefulWidget {
  const NewProducerDialog({super.key});

  @override
  State<NewProducerDialog> createState() => _NewProducerDialogState();
}

class _NewProducerDialogState extends State<NewProducerDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  RegionEntity? _selectedRegion;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      if (_selectedRegion == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Veuillez sélectionner une région')),
        );
        return;
      }

      final producerDto = NewProducerDto(
        name: _nameController.text,
        regionId: _selectedRegion!.id,
      );

      context.read<NewProducerBloc>().add(AddProducerEvent(producerDto));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NewProducerBloc, NewProducerState>(
      listener: (context, state) {
        if (state.status == NewProducerStatus.success) {
          Navigator.of(context).pop();
          context.read<ProducerBloc>().add(LoadProducersEvent());
        } else if (state.status == NewProducerStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage ?? 'Une erreur est survenue')),
          );
        }
      },
      child: BlocBuilder<NewProducerBloc, NewProducerState>(
        builder: (context, state) {
          return CustomDialog(
            title: 'Nouveau producteur',
            content: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Nom du producteur',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer un nom';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  BlocBuilder<RegionBloc, RegionState>(
                    builder: (context, state) {
                      if (state is RegionLoading) {
                        return const CircularProgressIndicator();
                      } else if (state is RegionLoaded) {
                        final regions = state.regions;
                        return DropdownButtonFormField<RegionEntity>(
                          decoration: const InputDecoration(
                            labelText: 'Région',
                            border: OutlineInputBorder(),
                          ),
                          value: regions.contains(_selectedRegion) ? _selectedRegion : null,
                          items: regions.map<DropdownMenuItem<RegionEntity>>((region) {
                            return DropdownMenuItem<RegionEntity>(
                              value: region,
                              child: Text(region.name),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedRegion = value;
                            });
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Veuillez sélectionner une région';
                            }
                            return null;
                          },
                        );
                      } else if (state is RegionError) {
                        return Text(state.message, style: const TextStyle(color: Colors.red));
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Annuler'),
              ),
              FilledButton(
                onPressed: state.status == NewProducerStatus.loading ? null : _submitForm,
                child: state.status == NewProducerStatus.loading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Ajouter'),
              ),
            ],
          );
        },
      ),
    );
  }
}
