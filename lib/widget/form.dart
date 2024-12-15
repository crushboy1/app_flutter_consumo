import 'package:consumo_electrico_app/presentation/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ApplianceFormDialog extends StatefulWidget {
  final Appliance appliance;
  final Function(Appliance, Map<String, int>) onAddApplianceToCalculation;

  const ApplianceFormDialog({
    Key? key,
    required this.appliance,
    required this.onAddApplianceToCalculation,
  }) : super(key: key);

  @override
  State<ApplianceFormDialog> createState() => _ApplianceFormDialogState();
}

class _ApplianceFormDialogState extends State<ApplianceFormDialog> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for form fields
  final _cantidadController = TextEditingController(text: '1');
  final _potenciaController = TextEditingController(text: '0');
  final _horasController = TextEditingController(text: '1');
  final _minutosController = TextEditingController(text: '0');
  final _diasController = TextEditingController(text: '1');

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(widget.appliance.name),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildNumberField(
                label: 'Cantidad (0-10):',
                controller: _cantidadController,
                maxValue: 10,
              ),
              const SizedBox(height: 16),
              _buildNumberField(
                label: 'Potencia Referencial (0-15000):',
                controller: _potenciaController,
                maxValue: 15000,
              ),
              const SizedBox(height: 16),
              _buildNumberField(
                label: 'Horas (0-24):',
                controller: _horasController,
                maxValue: 24,
              ),
              const SizedBox(height: 16),
              _buildNumberField(
                label: 'Minutos (0-60):',
                controller: _minutosController,
                maxValue: 60,
              ),
              const SizedBox(height: 16),
              _buildNumberField(
                label: 'Días (0-30):',
                controller: _diasController,
                maxValue: 30,
              ),
            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
          ),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              // Here you can process the form data

              // You might want to create a model class to hold this data
              final formData = {
                'cantidad': int.parse(_cantidadController.text),
                'potencia': int.parse(_potenciaController.text),
                'horas': int.parse(_horasController.text),
                'minutos': int.parse(_minutosController.text),
                'dias': int.parse(_diasController.text),
              };
              widget.onAddApplianceToCalculation(widget.appliance, formData);
              Navigator.of(context).pop();
            }
          },
          child: const Text('Agregar a la Calculadora'),
        ),
      ],
    );
  }

  Widget _buildNumberField({
    required String label,
    required TextEditingController controller,
    required int maxValue,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Este campo es requerido';
        }
        final number = int.tryParse(value);
        if (number == null) {
          return 'Ingrese un número válido';
        }
        if (number < 0 || number > maxValue) {
          return 'Ingrese un número entre 0 y $maxValue';
        }
        return null;
      },
    );
  }

  @override
  void dispose() {
    _cantidadController.dispose();
    _potenciaController.dispose();
    _horasController.dispose();
    _minutosController.dispose();
    _diasController.dispose();
    super.dispose();
  }
}
