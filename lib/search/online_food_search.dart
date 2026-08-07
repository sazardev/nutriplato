import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutriplato/infrastructure/entities/food/nutri_food.dart';
import 'package:nutriplato/infrastructure/services/food_api_service.dart';
import 'package:nutriplato/presentation/screens/food/food.view.dart';

/// Búsqueda de alimentos en OpenFoodFacts (en línea).
///
/// Los resultados se muestran con la base local como fallback cuando la red
/// no está disponible o no hay coincidencias.
class OnlineFoodSearchSheet extends StatefulWidget {
  final String initialQuery;

  const OnlineFoodSearchSheet({super.key, this.initialQuery = ''});

  @override
  State<OnlineFoodSearchSheet> createState() => _OnlineFoodSearchSheetState();
}

class _OnlineFoodSearchSheetState extends State<OnlineFoodSearchSheet> {
  final _api = FoodApiService();
  late final TextEditingController _nameController;
  final TextEditingController _barcodeController = TextEditingController();

  List<NutriFood> _results = [];
  bool _loading = false;
  bool _searched = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialQuery);
    if (widget.initialQuery.isNotEmpty) {
      _search();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _barcodeController.dispose();
    _api.dispose();
    super.dispose();
  }

  Future<void> _search() async {
    setState(() {
      _loading = true;
      _searched = true;
      _error = null;
    });

    final results = await _api.searchFoods(_nameController.text);
    if (!mounted) return;

    setState(() {
      _loading = false;
      _results = results;
      if (results.isEmpty) {
        _error =
            'Sin conexión o sin resultados en línea. Usa tu base local de alimentos.';
      }
    });
  }

  Future<void> _searchByBarcode() async {
    setState(() {
      _loading = true;
      _searched = true;
      _error = null;
    });

    final food = await _api.getByBarcode(_barcodeController.text);
    if (!mounted) return;

    setState(() {
      _loading = false;
      _results = food != null ? [food] : [];
      if (food == null) {
        _error =
            'Código no encontrado o sin conexión. Usa tu base local de alimentos.';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.85,
        ),
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.cloud, color: Color(0xFF00838F), size: 22),
                const SizedBox(width: 8),
                Text(
                  'Buscar en OpenFoodFacts',
                  style: GoogleFonts.poppins(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              'Base de datos abierta y gratuita (por 100 g). Tu catálogo local sigue disponible.',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _nameController,
              onSubmitted: (_) => _search(),
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                hintText: 'Buscar por nombre...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.arrow_forward),
                  tooltip: 'Buscar',
                  onPressed: _search,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _barcodeController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _searchByBarcode(),
              decoration: InputDecoration(
                hintText: 'O por código de barras (EAN-13)',
                prefixIcon: Icon(FontAwesomeIcons.barcode.data),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  tooltip: 'Buscar por código de barras',
                  onPressed: _searchByBarcode,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Flexible(child: _buildResults()),
          ],
        ),
      ),
    );
  }

  Widget _buildResults() {
    if (_loading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (!_searched) {
      return Container(
        padding: const EdgeInsets.all(24),
        alignment: Alignment.center,
        child: Text(
          'Busca un alimento o escanea un código para ver resultados en línea.',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey.shade700, fontSize: 13),
        ),
      );
    }

    if (_error != null) {
      return Container(
        padding: const EdgeInsets.all(24),
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.cloud_off, size: 40, color: Colors.grey.shade400),
            const SizedBox(height: 12),
            Text(
              _error!,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
            ),
          ],
        ),
      );
    }

    if (_results.isEmpty) {
      return Center(
        child: Text(
          'Sin resultados',
          style: TextStyle(color: Colors.grey.shade700),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      itemCount: _results.length,
      separatorBuilder: (_, _) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final food = _results[index];
        return _OnlineFoodCard(food: food);
      },
    );
  }
}

class _OnlineFoodCard extends StatelessWidget {
  final NutriFood food;

  const _OnlineFoodCard({required this.food});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (_) => SizedBox(
              height: MediaQuery.of(context).size.height * 0.75,
              child: FoodViewScreen(food: food),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: food.image != null
                    ? Image(
                        image: food.image!.image,
                        fit: BoxFit.cover,
                        errorBuilder: (_, _, _) =>
                            const Icon(Icons.cloud, color: Colors.grey),
                      )
                    : const Icon(Icons.cloud, color: Colors.grey),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      food.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (food.description != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        food.description!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                    const SizedBox(height: 4),
                    Text(
                      '${food.energia} kcal · P ${food.proteina} g · C ${food.hidratosDeCarbono} g · G ${food.lipidos} g (por 100 g)',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.teal.shade700,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
