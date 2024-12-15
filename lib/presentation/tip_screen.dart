import 'package:flutter/material.dart';

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

class TipScreen extends StatefulWidget {
  const TipScreen({super.key});

  @override
  State<TipScreen> createState() => _TipScreenState();
}

class _TipScreenState extends State<TipScreen> {
  NavCat? _selectedCat;

//metodo para que mostrar tarjeta con consejos
  void _showApplianceAdvice(Appliance appliance) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Suggestion Icon
              Image.asset(
                'assets/icons/suggestion.png',
                height: 100,
                width: 100,
              ),
              // Appliance Name
              Text(
                appliance.name,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              // Advice Text
              Text(
                _getApplianceAdvice(appliance),
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cerrar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  //metodo para obtener el consejo especifico para cada artefactp
  String _getApplianceAdvice(Appliance appliance) {
    switch (appliance.name) {
      case 'Refrigeradora':
        return 'Consejo para refrigeradora:\n- Cerrando bien la puerta vamos ahorrando\n- No introduzcas alimentos calientes.';

      case 'Lavadora':
        return 'Consejo para lavadora:\n- Solo lava cuando haya suficiente ropa para llenar tu lavadora\n- No eches más detergente de lo necesario porque no mejorará el lavado,solo estarás utilizando más agua y electricidad para el enjuague.';

      case 'Microondas':
        return 'Consejos para microondas:\n- Utiliza el horno microondas solo para calentar y no para cocinar.\n- No funcionamiento en vacío';

      case 'Cocina Eléctrica':
        return 'Consejos para cocina eléctrica:\n- Utiliza la cocina eléctrica solo si es necesario, consumes menos energía eléctrica cocinando a gas.\n- Revisa regularmente los cables';

      case 'Hervidor de Agua':
        return 'Consejos para hervidor de agua:\n- Hierve el agua necesaria y guárdala en un termo, así evitarás usar el hervidor más de una vez al día.\n- Desconecta después de usar\n- Verifica el estado del cable';

      case 'Tostadora':
        return 'Consejos para tostadora:\n- Mantenla limpia de residuos y desendhúfala cuando no la vayas a usar.\n- Revisa regularmente el cable';

      case 'Olla Arrocera':
        return 'Consejos para olla arrocera:\n- No la dejes conectada todo el día, desenchúfala cuando termine la cocción.\n- Revisa el estado del cable\n';

      case 'Wafflera':
        return 'Consejos para wafflera:\n- Utizala el tiempo necesario y luego desenchúfala\n- Revisa regularmente el cable';

      case 'Cafetera':
        return 'Consejos para cafetera:\n- Te recomendamos utilizar la cafetera una vez al día\n- Guarda el café en un recipiente y calientalo para las demás tomas\n- Más económico será pasar el café gota a gota en las jarras que no utilizan electricidad\n- Desconecta después de usar';

      case 'Licuadora':
        return 'Consejos para licuadora:\n- Utiliza la licuadora en una potencia moderada\n- Picar antes los productos que vas licuar\n- Fijate que las cuchillas no estan gastadas \n- Desconecta antes de limpiar.';

      case 'Batidora':
        return 'Consejos para batidora:\n- Controla el tiempo de uso y luego desenchúfalo\n- Revisa el enchufe regularmente';

      case 'Foco Ahorrador':
        return 'Consejos para foco ahorrador:\n- Apaga cuando no los uses\n- Cambia a focos LED: iluminan igual, consumen menos y no contaminan.\n- Prefiere luz natural';

      case 'Aire Acondicionado':
        return 'Consejos para aire acondicionado:\n- Elige un aparato eficiente, Evita usarlo de noche abre las ventanas para haga corriente y reducirás muchas horas de consumo de energía\n- Usa el modo económico\n- No lo uses constantemente.';

      case 'Televisor':
        return 'Consejos para un televisor:\n- Utiliza el televisor solo cuando lo veas\n- Si vas a dormir prográmalo para que se apague automáticamente y mejor desenchufalo.';

      case 'Equipo de Sonido':
        return 'Consejos para equipo de sonido:\n- Desconecta el equipo cuando no lo estés usando\n- Desconecta cuando no lo uses\n- evitemos el consumo en modo stand by.\n- Revisa cables y conectores';

      case 'Laptop':
        return 'Consejos para laptop:\n- Enciéndela cuando la vayas a usar\n- Cargala solo lo necesario\n- Deschúfala si no la vas a usar.';

      case 'DVD':
        return 'Consejos para DVD:\n- Desconecta el equipo cuando no lo estés usando\n- No lo dejes encendido\n- Evitemos el consumo en modo stand by.';

      case 'Computadora':
        return 'Consejos para computadora:\n- Usa modo de ahorro de energía\n- Apaga cuando no la uses\n- Deschúfala si no la vas a usar\n- Usa protector de voltaje';

      case 'Ventilador':
        return 'Consejos para ventilador:\n- Usa el ventilador en temporadas de extremo calor\n- No lo dejes encendido sin necesidad\n- No lo utilices para secar la ropa o cualquier otro material\n- Usa velocidades moderadas.';

      case 'PlayStation':
        return 'Consejos para PlayStation:\n- No lo dejes encendido\n- Solo conecta el equipo cuando lo utilices\n- Evita el consumo en modo stand by\n- Usa protector de voltaje.';

      case 'Cargador de Celular':
        return 'Consejos para cargador de celular:\n- Desconecta cuando no lo uses\n- No lo dejes conectado toda la noche\n- Revisa el cable regularmente\n- Usa cargadores originales\n- No lo sobrecalientes.';

      case 'Ducha Eléctrica':
        return 'Consejos para ducha eléctrica:\n- Limite su tiempo de baño al mínimo indispensable\n- Mejor sería cambiarla la ducha eléctrica por una a gas.';

      case 'Terma Eléctrica':
        return 'Consejos para terma eléctrica:\n- No dejes encendida todo el día tu terma\n- Aísla tuberías\n- Prendela una hora antes de bañarte\n- Mejor utiliza un temporizador y ahorremos energía!\n- Usa modo económico';

      case 'Secador de Cabello':
        return 'Consejos para secador de cabello:\n- Seca primeramente tu cabello con una toalla\n- Péinelo un poco y luego use la secadora usando solo el soplador de aire o con el nivel más inferior de calentamiento.\n- Desconecta después de usar';

      case 'Secadora de Ropa':
        return 'Consejos para secadora de ropa:\n- Aprende a separar la ropa de acuerdo a la textura\n- No sobrecargues\n- Usa el ciclo adecuado\n- El algón necesitará más calor que la tela sintética\n- activa la opción de auto secado para que se apague apenas temine\n- Mucho mejor sécalas al aire libre.';

      case 'Plancha':
        return 'Consejos para plancha:\n- Plancha primero la ropa gruesa\n- Apaga la plancha y finaliza con la ropa delgada aprovechando el calor residual.\n- Desconecta después de usar';

      case 'Aspiradora':
        return 'Consejos para aspiradora:\n- No uses la aspiradora más de lo necesario\n- Manten limpios los filtros de la aspiradora\n- Limpia regularmente su depósito\n- Si no lo haces, el motor se forzará más de lo necesario y consumirá más energía.';

      default:
        return "No hay consejos específicos disponibles para este electrodoméstico";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Seleccione Categoria'),
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
                      onTap: () => _showApplianceAdvice(appliance),
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
            ),
        ],
      ),
    );
  }
}
