import 'package:examen_cmo/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterUserScreen extends StatelessWidget {
  const RegisterUserScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulario de Registro'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ChangeNotifierProvider(
                create: (_) => LoginFormProvider(),
                child: const RegisterForm(),
              ),
              const SizedBox(height: 30),
              TextButton(
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, 'login'),
                  style: ButtonStyle(
                    overlayColor:
                        WidgetStateProperty.all(Colors.indigo.withOpacity(0.1)),
                    shape: WidgetStateProperty.all(const StadiumBorder()),
                  ),
                  child: const Text('Ya tienes cuenta? Ingresa'))
            ],
          ),
        ),
      ),
    );
  }
}

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    final registerForm = Provider.of<LoginFormProvider>(context);
    return Form(
      key: registerForm.formkey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFieldRegistro(
            label: 'Email',
            hintText: 'Ingrese su correo',
            prefixIcon: const Icon(
              Icons.mail,
              color: MyTheme.primary,
            ),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              return (value != null && value.length >= 4)
                  ? null
                  : 'Debe ingresar un correo válido';
            },
            onChanged: (value) => registerForm.email = value,
          ),
          const SizedBox(height: 20),
          TextFieldRegistro(
            label: 'Password',
            hintText: '*******************',
            prefixIcon: const Icon(Icons.lock, color: MyTheme.primary),
            obscureText: true,
            validator: (value) {
              return (value != null && value.length >= 6)
                  ? null
                  : 'La contraseña debe tener al menos 6 caracteres';
            },
            onChanged: (value) => registerForm.password = value,
          ),
          const SizedBox(height: 30),
          MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            disabledColor: Colors.grey,
            color: MyTheme.primary,
            elevation: 0,
            onPressed: registerForm.isLoading
                ? null
                : () async {
                    FocusScope.of(context).unfocus();
                    final authService =
                        Provider.of<AuthService>(context, listen: false);
                    if (!registerForm.isValidForm()) return;
                    registerForm.isLoading = true;
                    final String? errorMessage = await authService.createUser(
                      registerForm.email,
                      registerForm.password,
                    );
                    if (errorMessage == null) {
                      Navigator.pushNamed(context, 'login');
                    } else {
                      print(errorMessage);
                    }
                    registerForm.isLoading = false;
                  },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
              child: const Text(
                'Crear',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
