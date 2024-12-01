import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignupScreen(),
    );
  }
}

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _termsAccepted = false;
  String? _selectedGender = 'Masculino';
  String? _selectedCivilStatus = 'Soltero';
  final TextEditingController _birthdateController = TextEditingController();
  final TextEditingController _idCardController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Formulario de Registro"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Cédula
                TextFormField(
                  controller: _idCardController,
                  decoration: InputDecoration(
                    labelText: "Cédula",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Por favor ingrese su cédula";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Nombres
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Nombres",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Por favor ingrese su nombre";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Apellidos
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Apellidos",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Por favor ingrese su apellido";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Fecha de nacimiento
                TextFormField(
                  controller: _birthdateController,
                  decoration: InputDecoration(
                    labelText: "Fecha de Nacimiento",
                    border: OutlineInputBorder(),
                  ),
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        _birthdateController.text =
                            "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                      });
                    }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Por favor ingrese su fecha de nacimiento";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Edad
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Edad",
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Por favor ingrese su edad";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Género
                Row(
                  children: [
                    Text("Género: "),
                    Radio<String>(
                      value: 'Masculino',
                      groupValue: _selectedGender,
                      onChanged: (value) {
                        setState(() {
                          _selectedGender = value;
                        });
                      },
                    ),
                    Text("Masculino"),
                    Radio<String>(
                      value: 'Femenino',
                      groupValue: _selectedGender,
                      onChanged: (value) {
                        setState(() {
                          _selectedGender = value;
                        });
                      },
                    ),
                    Text("Femenino"),
                  ],
                ),
                const SizedBox(height: 20),

                // Estado Civil
                Row(
                  children: [
                    Text("Estado Civil: "),
                    Radio<String>(
                      value: 'Soltero',
                      groupValue: _selectedCivilStatus,
                      onChanged: (value) {
                        setState(() {
                          _selectedCivilStatus = value;
                        });
                      },
                    ),
                    Text("Soltero"),
                    Radio<String>(
                      value: 'Casado',
                      groupValue: _selectedCivilStatus,
                      onChanged: (value) {
                        setState(() {
                          _selectedCivilStatus = value;
                        });
                      },
                    ),
                    Text("Casado"),
                    Radio<String>(
                      value: 'Divorciado',
                      groupValue: _selectedCivilStatus,
                      onChanged: (value) {
                        setState(() {
                          _selectedCivilStatus = value;
                        });
                      },
                    ),
                    Text("Divorciado"),
                  ],
                ),
                const SizedBox(height: 20),

                // Aceptar términos y condiciones
                Row(
                  children: [
                    Checkbox(
                      value: _termsAccepted,
                      onChanged: (value) {
                        setState(() {
                          _termsAccepted = value!;
                        });
                      },
                    ),
                    Expanded(
                      child: Text(
                        "Al crear su Formulario, acepta nuestros términos y condiciones.",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Botón para crear formulario
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (!_termsAccepted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Por favor, acepte los términos."),
                          ),
                        );
                      } else {
                        // Navegar a la pantalla de éxito al crear el formulario
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SuccessScreen(),
                          ),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    backgroundColor: Colors.blue,
                  ),
                  child: Text("Crear Formulario"),
                ),
                const SizedBox(height: 20),

                // Botón para salir
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ExitScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    backgroundColor: Colors.red,
                  ),
                  child: Text("Salir"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Formulario Creado"),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle,
              size: 100,
              color: Colors.green,
            ),
            SizedBox(height: 20),
            Text(
              "Formulario creado con éxito!",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ExitScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue, // Fondo celeste
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Pulsa aquí para crear formulario",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navegar al formulario de creación
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignupScreen(),
                  ),
                );
              },
              child: Text("Crear Formulario"),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(200, 50),
                backgroundColor: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
