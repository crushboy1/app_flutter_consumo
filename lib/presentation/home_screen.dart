import 'package:consumo_electrico_app/widget/form.dart';
import 'package:flutter/material.dart';
import 'package:consumo_electrico_app/widget/consts.dart';

enum NavCat {
  cocina,
  sala,
  dormitorio,
  bano,
  lavanderia,
}

class Appliance {
  final String name;
  final IconData icon;
  final String category;

  const Appliance({
    required this.name,
    required this.icon,
    required this.category,
  });
}

extension NavCatExtension on NavCat {
  String get name {
    switch (this) {
      case NavCat.cocina:
        return 'Cocina';
      case NavCat.sala:
        return 'Sala';
      case NavCat.dormitorio:
        return 'Dormitorio';
      case NavCat.bano:
        return 'Baño';
      case NavCat.lavanderia:
        return 'Lavandería';
    }
  }

  IconData get icon {
    switch (this) {
      case NavCat.cocina:
        return Icons.kitchen;
      case NavCat.sala:
        return Icons.weekend;
      case NavCat.dormitorio:
        return Icons.bed;
      case NavCat.bano:
        return Icons.bathroom;
      case NavCat.lavanderia:
        return Icons.local_laundry_service;
    }
  }

  List<Appliance> get appliances {
    switch (this) {
      case NavCat.cocina:
        return [
          const Appliance(
              name: 'Cocina Eléctrica',
              icon: Icons.countertops,
              category: 'cocina'),
          const Appliance(
              name: 'Hervidor de Agua',
              icon: Icons.coffee_maker,
              category: 'cocina'),
          const Appliance(
              name: 'Microondas', icon: Icons.microwave, category: 'cocina'),
          const Appliance(
              name: 'Tostadora',
              icon: Icons.breakfast_dining,
              category: 'cocina'),
          const Appliance(
              name: 'Olla Arrocera',
              icon: Icons.soup_kitchen,
              category: 'cocina'),
          const Appliance(
              name: 'Wafflera',
              icon: Icons.breakfast_dining,
              category: 'cocina'),
          const Appliance(
              name: 'Cafetera', icon: Icons.coffee, category: 'cocina'),
          const Appliance(
              name: 'Licuadora', icon: Icons.blender, category: 'cocina'),
          const Appliance(
              name: 'Refrigeradora', icon: Icons.kitchen, category: 'cocina'),
          const Appliance(
              name: 'Batidora', icon: Icons.blender, category: 'cocina'),
          const Appliance(
              name: 'Foco Ahorrador',
              icon: Icons.lightbulb_outline,
              category: 'cocina'),
        ];
      case NavCat.sala:
        return [
          const Appliance(
              name: 'Aire Acondicionado',
              icon: Icons.ac_unit,
              category: 'sala'),
          const Appliance(
              name: 'Foco Ahorrador',
              icon: Icons.lightbulb_outline,
              category: 'sala'),
          const Appliance(name: 'Televisor', icon: Icons.tv, category: 'sala'),
          const Appliance(
              name: 'Equipo de Sonido', icon: Icons.speaker, category: 'sala'),
          const Appliance(name: 'Laptop', icon: Icons.laptop, category: 'sala'),
          const Appliance(
              name: 'DVD', icon: Icons.video_library, category: 'sala'),
        ];
      case NavCat.dormitorio:
        return [
          const Appliance(
              name: 'Computadora',
              icon: Icons.computer,
              category: 'dormitorio'),
          const Appliance(
              name: 'Ventilador',
              icon: Icons.wind_power,
              category: 'dormitorio'),
          const Appliance(
              name: 'PlayStation',
              icon: Icons.sports_esports,
              category: 'dormitorio'),
          const Appliance(
              name: 'Cargador de Celular',
              icon: Icons.phone_android,
              category: 'dormitorio'),
        ];
      case NavCat.bano:
        return [
          const Appliance(
              name: 'Ducha Eléctrica', icon: Icons.shower, category: 'bano'),
          const Appliance(
              name: 'Terma Eléctrica', icon: Icons.hot_tub, category: 'bano'),
          const Appliance(
              name: 'Secador de Cabello', icon: Icons.dry, category: 'bano'),
        ];
      case NavCat.lavanderia:
        return [
          const Appliance(
              name: 'Secadora de Ropa',
              icon: Icons.local_laundry_service,
              category: 'lavanderia'),
          const Appliance(
              name: 'Plancha', icon: Icons.iron, category: 'lavanderia'),
          const Appliance(
              name: 'Aspiradora',
              icon: Icons.cleaning_services,
              category: 'lavanderia'),
          const Appliance(
              name: 'Lavadora',
              icon: Icons.local_laundry_service,
              category: 'lavanderia'),
        ];
      default:
        return [];
    }
  }
}

class ApplianceResult {
  final Appliance appliance;
  final double kwh;
  final double kwhPerMonth;
  final double cost;

  ApplianceResult({
    required this.appliance,
    required this.kwh,
    required this.kwhPerMonth,
    required this.cost,
  });
}

class ResultsScreen extends StatefulWidget {
  final List<ApplianceResult> results;
  final VoidCallback onReset;

  const ResultsScreen({
    super.key,
    required this.results,
    required this.onReset,
  });

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  List<ApplianceResult> get _results => widget.results;

  void _removeResult(int index) {
    setState(() {
      _results.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    double totalKwhPerMonth =
        _results.fold(0, (sum, item) => sum + item.kwhPerMonth);
    double totalCost = _results.fold(0, (sum, item) => sum + item.cost);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Resultados del Consumo Eléctrico'),
      ),
        body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _results.length,
              itemBuilder: (context, index) {
                final result = _results[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                  child: ListTile(
                    leading: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.red),
                          onPressed: () => _removeResult(index),
                          //add remove funcionality,
                        ),
                        Icon(result.appliance.icon),
                      ],
                    ),
                    title: Text(
                      result.appliance.name,
                    ),
                    titleTextStyle: const TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(result.kwh.toStringAsFixed(2),
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(width: 16),
                        Text('${result.kwhPerMonth.toStringAsFixed(2)}  ',
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(width: 16),
                        Text('S/. ${result.cost.toStringAsFixed(2)}',
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            //ADD FUNCIONALITY
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.green,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total Consumo Kwh / mes',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      totalKwhPerMonth.toStringAsFixed(2),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total Costo Mensual S/.',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      totalCost.toStringAsFixed(2),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: widget.onReset,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                  child: const Text('Reiniciar'),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // Regresar a la pantalla de inicio sin perder datos
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomeScreen(results: _results)),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                  child: const Text('Agregar más Artefáctos'),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

double calculateKWh(Map<String, int> formData) {
  final potencia = formData['potencia']!.toDouble();
  final cantidad = formData['cantidad']!.toDouble();
  final horas = formData['horas']!.toDouble();
  final minutos = formData['minutos']!.toDouble();
  final dias = formData['dias']!.toDouble();

  //convertir minutos a horas
  final totalHoras = horas + (minutos / 60);

  //calcular kwh: (potencia *cantidad * horas * dias ) / 1000
  return (potencia * cantidad * totalHoras * dias / 1000);
}

class HomeScreen extends StatefulWidget {
  final List<ApplianceResult> results;
  const HomeScreen({super.key, this.results = const []});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<ApplianceResult> _results;
  NavCat? _selectedCat;
  Appliance? _selectedAppliance;

  @override
  void initState() {
    super.initState();
    _results = List<ApplianceResult>.from(
        widget.results); // Asegúrate de que sea una lista modificable
  }

  void _addApplianceResult(Appliance appliance, Map<String, int> formData) {
    final Appliance appliance = _selectedAppliance!;
    final kWh = calculateKWh(formData);
    final kwHPerMonth = kWh * 1; //asumiendo 10 meses
    final cost = kwHPerMonth * 0.67; //valor del costo en electricidad en perú

    setState(() {
      _results.add(ApplianceResult(
        appliance: appliance,
        kwh: kWh,
        kwhPerMonth: kwHPerMonth,
        cost: cost,
      ));
    });
  }

  Future<void> _goToCalculator() async {
    if (_results.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('No se ha seleccionado artefactos para calcular'),
      ));
      return;
    }

    final newResults = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultsScreen(
          results: _results,
          onReset: () {
            setState(() {
              _results.clear();
            });
            Navigator.of(context).pop();
          },
        ),
      ),
    );

    // Si se devuelven resultados, actualizamos la lista
    if (newResults != null) {
      setState(() {
        _results.clear();
        _results.addAll(newResults); // Agregar los resultados a la lista actual
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Calcular Consumo Eléctrico'),
      ),
      body: Column(
        children: [
          Container(
            height: 120,
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: NavCat.values.length,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemBuilder: (context, index) {
                  final category = NavCat.values[index];
                  final isSelected = category == _selectedCat;

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _selectedCat = category;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: 80,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Theme.of(context).primaryColor
                              : Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.4),
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  )
                                ]
                              : null,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              category.icon,
                              size: 32,
                              color:
                                  isSelected ? Colors.white : Colors.grey[600],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              category.name,
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                    : Colors.grey[600],
                                fontSize: 12,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ),
          if (_selectedCat != null)
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: _selectedCat!.appliances.length,
                itemBuilder: (context, index) {
                  final appliance = _selectedCat!.appliances[index];
                  return Card(
                    elevation: 2,
                    child: InkWell(
                      onTap: () async {
                        _selectedAppliance = appliance;
                        // agregar funcion
                        await showDialog<Map<String, int>>(
                          context: context,
                          builder: (context) => ApplianceFormDialog(
                            appliance: appliance,
                            onAddApplianceToCalculation: _addApplianceResult,
                          ),
                        );
                        /* if (result != null) {
                                  _handleAddResult(appliance, result);
                                    }
                                     */
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            appliance.icon,
                            size: 40,
                            color: Theme.of(context).primaryColor,
                          ),
                          const SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Text(
                              appliance.name,
                              style: const TextStyle(fontSize: 12),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          else
            const Center(
              child: Text('Porfavor seleccionar categoria'),
            ),
          if (_results.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: _goToCalculator,
                style: ElevatedButton.styleFrom(
                    backgroundColor:  g2,
                    foregroundColor: Colors.white),
                child: const Text('Ir a Calculadora'),
              ),
            ),
        ],
      ),
    );
  }
}
