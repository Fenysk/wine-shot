import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomDropdownField<T> extends FormField<T> {
  /// La liste des éléments disponibles
  final List<T> items;

  /// Fonction pour obtenir le texte à afficher pour un élément
  final String Function(T item) itemLabelBuilder;

  /// Le label du champ
  final String label;

  /// Placeholder pour le champ de recherche
  final String? searchHint;

  /// Texte affiché quand aucun résultat n'est trouvé
  final String? emptyText;

  /// Texte affiché quand aucune valeur n'est sélectionnée
  final String? placeholderText;

  /// Hauteur maximale du dropdown (en pourcentage de la hauteur de l'écran)
  final double maxHeightFactor;

  CustomDropdownField({
    super.key,
    required this.items,
    required this.itemLabelBuilder,
    required this.label,
    super.initialValue,
    super.validator,
    super.autovalidateMode,
    this.searchHint,
    this.emptyText,
    this.placeholderText,
    this.maxHeightFactor = 0.4,
  }) : super(
          builder: (FormFieldState<T> field) {
            return _CustomDropdownFieldContent<T>(
              field: field,
              items: items,
              itemLabelBuilder: itemLabelBuilder,
              label: label,
              searchHint: searchHint ?? '',
              emptyText: emptyText ?? '',
              placeholderText: placeholderText ?? '',
              maxHeightFactor: maxHeightFactor,
            );
          },
        );
}

class _CustomDropdownFieldContent<T> extends StatefulWidget {
  final FormFieldState<T> field;
  final List<T> items;
  final String Function(T item) itemLabelBuilder;
  final String label;
  final String searchHint;
  final String emptyText;
  final String placeholderText;
  final double maxHeightFactor;

  const _CustomDropdownFieldContent({
    required this.field,
    required this.items,
    required this.itemLabelBuilder,
    required this.label,
    required this.searchHint,
    required this.emptyText,
    required this.placeholderText,
    required this.maxHeightFactor,
  });

  @override
  State<_CustomDropdownFieldContent<T>> createState() => _CustomDropdownFieldContentState<T>();
}

class _CustomDropdownFieldContentState<T> extends State<_CustomDropdownFieldContent<T>> {
  final TextEditingController _searchController = TextEditingController();
  final LayerLink _layerLink = LayerLink();
  bool _isDropdownOpen = false;
  OverlayEntry? _overlayEntry;

  @override
  void dispose() {
    _searchController.dispose();
    _removeOverlay();
    super.dispose();
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _showOverlay(BuildContext context) {
    _removeOverlay();
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) => _CustomDropdownOverlay<T>(
        layerLink: _layerLink,
        width: size.width,
        offset: Offset(0, size.height + 4),
        items: widget.items,
        searchController: _searchController,
        itemLabelBuilder: widget.itemLabelBuilder,
        searchHint: widget.searchHint,
        emptyText: widget.emptyText,
        placeholderText: widget.placeholderText,
        maxHeightFactor: widget.maxHeightFactor,
        onSelect: (item) {
          widget.field.didChange(item);
          setState(() {
            _isDropdownOpen = false;
            _searchController.clear();
          });
          _removeOverlay();
        },
        onClose: () {
          setState(() {
            _isDropdownOpen = false;
            _searchController.clear();
          });
          _removeOverlay();
        },
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: InkWell(
        onTap: () {
          setState(() {
            _isDropdownOpen = !_isDropdownOpen;
            if (_isDropdownOpen) {
              _showOverlay(context);
            } else {
              _removeOverlay();
              _searchController.clear();
            }
          });
        },
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: widget.label,
            border: const OutlineInputBorder(),
            suffixIcon: Icon(_isDropdownOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down),
            errorText: widget.field.errorText,
          ),
          isEmpty: widget.field.value == null,
          child: Text(
            widget.field.value != null ? widget.itemLabelBuilder(widget.field.value!) : widget.placeholderText,
            style: widget.field.value == null
                ? Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).hintColor,
                    )
                : null,
          ),
        ),
      ),
    );
  }
}

class _CustomDropdownOverlay<T> extends StatefulWidget {
  final LayerLink layerLink;
  final double width;
  final Offset offset;
  final List<T> items;
  final TextEditingController searchController;
  final String Function(T item) itemLabelBuilder;
  final String searchHint;
  final String emptyText;
  final String placeholderText;
  final double maxHeightFactor;
  final ValueChanged<T> onSelect;
  final VoidCallback onClose;

  const _CustomDropdownOverlay({
    required this.layerLink,
    required this.width,
    required this.offset,
    required this.items,
    required this.searchController,
    required this.itemLabelBuilder,
    required this.searchHint,
    required this.emptyText,
    required this.placeholderText,
    required this.maxHeightFactor,
    required this.onSelect,
    required this.onClose,
  });

  @override
  State<_CustomDropdownOverlay<T>> createState() => _CustomDropdownOverlayState<T>();
}

class _CustomDropdownOverlayState<T> extends State<_CustomDropdownOverlay<T>> {
  late List<T> _filteredItems;

  @override
  void initState() {
    super.initState();
    _filteredItems = widget.items;
  }

  void _filterItems(String query) {
    setState(() {
      _filteredItems = widget.items.where((item) => widget.itemLabelBuilder(item).toLowerCase().contains(query.toLowerCase())).toList();
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
              maxHeight: MediaQuery.of(context).size.height * widget.maxHeightFactor,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: KeyboardListener(
                    focusNode: FocusNode(),
                    onKeyEvent: (event) {
                      if (event is KeyDownEvent && event.logicalKey == LogicalKeyboardKey.escape) {
                        widget.onClose();
                      }
                    },
                    child: TextField(
                      controller: widget.searchController,
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: widget.searchHint,
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                      ),
                      onChanged: _filterItems,
                      onEditingComplete: () => widget.onClose(),
                      onSubmitted: (_) => widget.onClose(),
                      onTapOutside: (_) => widget.onClose(),
                    ),
                  ),
                ),
                if (_filteredItems.isEmpty)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      widget.emptyText,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).hintColor,
                          ),
                    ),
                  )
                else
                  Flexible(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: _filteredItems.length,
                      itemBuilder: (context, index) {
                        final item = _filteredItems[index];
                        return ListTile(
                          dense: true,
                          title: Text(widget.itemLabelBuilder(item)),
                          onTap: () {
                            widget.onSelect(item);
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
