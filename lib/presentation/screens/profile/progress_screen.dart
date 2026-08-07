import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:nutriplato/infrastructure/entities/health/health_condition.dart';
import 'package:nutriplato/infrastructure/entities/user/user_profile.dart';
import 'package:nutriplato/presentation/provider/user_profile_provider.dart';
import 'package:nutriplato/presentation/screens/profile/widgets/line_chart.dart';
import 'package:provider/provider.dart';

/// Pantalla de progreso: historial y gráficas de peso y medidas.
class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  HealthMetricType _selectedType = HealthMetricType.weight;
  final TextEditingController _valueController = TextEditingController();

  final List<HealthMetricType> _trackableTypes = [
    HealthMetricType.weight,
    HealthMetricType.waistCircumference,
    HealthMetricType.bodyFatPercentage,
    HealthMetricType.bloodGlucose,
  ];

  @override
  void dispose() {
    _valueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(title: const Text('Mi progreso'), centerTitle: false),
      body: Consumer<UserProfileProvider>(
        builder: (context, provider, _) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _buildRegisterCard(provider),
              const SizedBox(height: 16),
              _buildTypeSelector(),
              const SizedBox(height: 16),
              _buildChart(provider),
              const SizedBox(height: 16),
              _buildHistory(provider),
            ],
          );
        },
      ),
    );
  }

  Widget _buildRegisterCard(UserProfileProvider provider) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Registrar medición',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _valueController,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Valor (${_selectedType.unit})',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      suffixText: _selectedType.unit,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton.icon(
                  onPressed: () => _register(provider),
                  icon: const Icon(Icons.add),
                  label: const Text('Guardar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 16,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTypeSelector() {
    return SizedBox(
      height: 44,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: _trackableTypes.map((type) {
          final isSelected = type == _selectedType;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(type.label),
              selected: isSelected,
              onSelected: (_) {
                setState(() {
                  _selectedType = type;
                  _valueController.clear();
                });
              },
              selectedColor: Theme.of(context).colorScheme.primary,
              backgroundColor: Colors.white,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildChart(UserProfileProvider provider) {
    final metrics = provider.getMetricsByType(_selectedType);
    final sorted = List<HealthMetric>.from(metrics)
      ..sort((a, b) => a.date.compareTo(b.date));

    final points = sorted
        .map((m) => ChartPoint(_shortDate(m.date), m.value))
        .toList();

    // Datos actuales del perfil como punto adicional.
    final profile = provider.profile;
    if (points.isEmpty && _currentProfileValue(profile) != null) {
      points.add(
        ChartPoint(_shortDate(DateTime.now()), _currentProfileValue(profile)!),
      );
    }

    final color = _typeColor(_selectedType);

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(_typeIcon(_selectedType), size: 18, color: color),
                const SizedBox(width: 8),
                Text(
                  'Evolución de ${_selectedType.label.toLowerCase()}',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            LineChart(points: points, lineColor: color, fillColor: color),
          ],
        ),
      ),
    );
  }

  Widget _buildHistory(UserProfileProvider provider) {
    final metrics = provider.getMetricsByType(_selectedType);
    if (metrics.isEmpty) {
      return const SizedBox.shrink();
    }

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Historial',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            ...metrics
                .take(10)
                .map(
                  (m) => ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(_typeIcon(m.type), color: _typeColor(m.type)),
                    title: Text(m.value.toStringAsFixed(1)),
                    subtitle: Text(
                      '${DateFormat('d MMM yyyy').format(m.date)} · ${m.type.label}',
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_outline, size: 20),
                      tooltip: 'Eliminar medición',
                      onPressed: () => _delete(provider, m),
                    ),
                  ),
                ),
          ],
        ),
      ),
    );
  }

  double? _currentProfileValue(UserProfile p) {
    switch (_selectedType) {
      case HealthMetricType.weight:
        return p.weightKg;
      case HealthMetricType.waistCircumference:
        return p.waistCm;
      default:
        return null;
    }
  }

  Future<void> _register(UserProfileProvider provider) async {
    final value = double.tryParse(_valueController.text);
    if (value == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Ingresa un valor válido')));
      return;
    }

    await provider.addHealthMetric(
      HealthMetric(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        date: DateTime.now(),
        type: _selectedType,
        value: value,
        unit: _selectedType.unit,
      ),
    );

    _valueController.clear();
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${_selectedType.label} registrado')),
    );
  }

  Future<void> _delete(
    UserProfileProvider provider,
    HealthMetric metric,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Eliminar registro'),
        content: Text(
          '¿Eliminar ${metric.value.toStringAsFixed(1)} ${metric.unit} del ${DateFormat('d MMM yyyy').format(metric.date)}?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );

    if (confirmed != true || !mounted) return;
    await provider.removeHealthMetric(metric);
  }

  String _shortDate(DateTime d) => '${d.day}/${d.month}';

  Color _typeColor(HealthMetricType t) {
    switch (t) {
      case HealthMetricType.weight:
        return Colors.green;
      case HealthMetricType.waistCircumference:
        return Colors.orange;
      case HealthMetricType.bodyFatPercentage:
        return Colors.purple;
      case HealthMetricType.bloodGlucose:
        return Colors.red;
      default:
        return Colors.blue;
    }
  }

  IconData _typeIcon(HealthMetricType t) {
    switch (t) {
      case HealthMetricType.weight:
        return Icons.monitor_weight;
      case HealthMetricType.waistCircumference:
        return Icons.straighten;
      case HealthMetricType.bodyFatPercentage:
        return Icons.percent;
      case HealthMetricType.bloodGlucose:
        return Icons.water_drop;
      default:
        return Icons.monitor_heart;
    }
  }
}
