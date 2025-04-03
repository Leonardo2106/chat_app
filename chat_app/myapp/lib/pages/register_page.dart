
import 'package:erospsique/components/my_button.dart';
import 'package:erospsique/components/my_text_field.dart';
import 'package:erospsique/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  //Login do usuário
  void singUp() async {
    if (passwordController.text != confirmPasswordController.text){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("As senhas não estão iguais!"),
        ),
      );
      return;
    }

    final authService = Provider.of<AuthService>(context, listen: false);

    try{
      await authService.singUpWithEmailandPassword(emailController.text, passwordController.text,);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),

                Icon(
                  Icons.home,
                  size: 100,
                  color: Colors.grey,
                ),
            
                const SizedBox(height: 50),

                const Text(
                  "Vamos criar uma conta para você!",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
            
                const SizedBox(height: 25),

                MyTextField(
                  controller: emailController,
                  hintText: 'E-mail',
                  obscureText: false,
                ),
            
                const SizedBox(height: 10),

                MyTextField(
                  controller: passwordController,
                  hintText: 'Senha',
                  obscureText: true,
                ),

                 const SizedBox(height: 10),

                MyTextField(
                  controller: confirmPasswordController,
                  hintText: 'Confirme a senha',
                  obscureText: true,
                ),

                const SizedBox(height: 25),

                MyButton(onTap: singUp, text: "Criar"),

                const SizedBox(height: 50),

                 Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  const Text('É um usuário?'),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      'Entre agora',
                      style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  )
                 ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}