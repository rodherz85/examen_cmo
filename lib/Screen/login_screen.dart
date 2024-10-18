import 'package:examen_cmo/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ChangeNotifierProvider(
                create: (_) => LoginFormProvider(),
                child: const LoginForm(),
              ),
              const SizedBox(height: 30),
              TextButton(
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, 'add_user'),
                  style: ButtonStyle(
                    overlayColor:
                        WidgetStateProperty.all(Colors.indigo.withOpacity(0.1)),
                    shape: WidgetStateProperty.all(const StadiumBorder()),
                  ),
                  child: const Text('No tienes cuenta? Regístrate'))
            ],
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);
    return Form(
      key: loginForm.formkey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFieldRegistro(
            label: 'Email',
            hintText: 'correo@example.cl',
            prefixIcon: const Icon(
              Icons.mail,
              color: MyTheme.primary,
            ),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              return (value != null && value.length >= 4)
                  ? null
                  : 'El usuario no puede estar vacío';
            },
            onChanged: (value) => loginForm.email = value,
          ),
          const SizedBox(height: 20),
          TextFieldRegistro(
            label: 'Password',
            hintText: '*******************',
            prefixIcon: const Icon(
              Icons.lock,
              color: MyTheme.primary,
            ),
            obscureText: true,
            onChanged: (value) => loginForm.password = value,
          ),
          const SizedBox(height: 30),
          MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            disabledColor: Colors.grey,
            color: MyTheme.primary,
            elevation: 0,
            onPressed: loginForm.isLoading
                ? null
                : () async {
                    FocusScope.of(context).unfocus();
                    final authService =
                        Provider.of<AuthService>(context, listen: false);
                    if (!loginForm.isValidForm()) return;
                    loginForm.isLoading = true;
                    final String? errorMessage = await authService.login(
                      loginForm.email,
                      loginForm.password,
                    );
                    if (errorMessage == null) {
                      Navigator.pushReplacementNamed(context, 'home');
                    } else {
                      print(errorMessage);
                    }
                    loginForm.isLoading = false;
                  },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
              child: const Text(
                'Ingresar',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
