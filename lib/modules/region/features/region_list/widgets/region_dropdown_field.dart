import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../../../../_shared/domain/entities/region_entity.dart';
import '../../../../../shared/widgets/custom_dropdown_field.dart';
import '../bloc/region_bloc.dart';

class RegionDropdownField extends StatelessWidget {
  final RegionEntity? selectedRegion;
  final ValueChanged<RegionEntity?> onChanged;
  final bool required;

  const RegionDropdownField({
    super.key,
    required this.selectedRegion,
    required this.onChanged,
    this.required = true,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegionBloc, RegionState>(
      builder: (context, state) {
        if (state is RegionLoading) {
          return const CircularProgressIndicator();
        } else if (state is RegionLoaded) {
          final regions = state.regions;

          return FormBuilderField<RegionEntity>(
            name: 'region_id',
            initialValue: regions.contains(selectedRegion) ? selectedRegion : null,
            validator: (value) {
              if (required && value == null) {
                return context.tr('regionsPage.newRegionDialog.regionNameField.validator');
              }
              return null;
            },
            builder: (FormFieldState<RegionEntity> field) {
              return CustomDropdownField<RegionEntity>(
                initialValue: field.value,
                items: regions,
                itemLabelBuilder: (region) => region.name,
                label: context.tr('regionsPage.newRegionDialog.regionNameField.label'),
                searchHint: context.tr('common.dropdown.searchPlaceholder'),
                emptyText: context.tr('common.dropdown.noResults'),
                validator: required
                    ? (value) {
                        if (value == null) {
                          return context.tr('regionsPage.newRegionDialog.regionNameField.validator');
                        }
                        return null;
                      }
                    : null,
              );
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

class RegionDropdownOverlay extends StatefulWidget {
  final LayerLink layerLink;
  final double width;
  final Offset offset;
  final List<RegionEntity> regions;
  final TextEditingController searchController;
  final ValueChanged<RegionEntity> onSelect;
  final VoidCallback onClose;

  const RegionDropdownOverlay({
    super.key,
    required this.layerLink,
    required this.width,
    required this.offset,
    required this.regions,
    required this.searchController,
    required this.onSelect,
    required this.onClose,
  });

  @override
  State<RegionDropdownOverlay> createState() => _RegionDropdownOverlayState();
}

class _RegionDropdownOverlayState extends State<RegionDropdownOverlay> {
  late List<RegionEntity> _filteredRegions;

  @override
  void initState() {
    super.initState();
    _filteredRegions = widget.regions;
  }

  void _filterRegions(String query) {
    setState(() {
      _filteredRegions = widget.regions.where((region) => region.name.toLowerCase().contains(query.toLowerCase())).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      width: widget.width,
      child: CompositedTransformFollower(
        link: widget.layerLink,
        showWhenUnlinked: false,
        offset: widget.offset,
        child: Material(
          elevation: 4,
          borderRadius: BorderRadius.circular(4),
          child: Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.4,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: widget.searchController,
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: 'Rechercher...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                    onChanged: _filterRegions,
                  ),
                ),
                Flexible(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: _filteredRegions.length,
                    itemBuilder: (context, index) {
                      final region = _filteredRegions[index];
                      return RegionDropdownTile(
                        region: region,
                        onTap: () {
                          widget.onSelect(region);
                          widget.onClose();
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RegionDropdownTile extends StatelessWidget {
  final RegionEntity region;
  final VoidCallback onTap;
  const RegionDropdownTile({super.key, required this.region, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      title: Text(region.name),
      onTap: onTap,
    );
  }
}

// context.read<RegionBloc>().add(CreateNewRegionEvent(NewRegionDto(name: 'Nom de la région', ...)) : Voici la commande à faire pour créer une nouvelle région. Une fois executée, la liste des régions se met toute seule à jour.
