
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_bloc/feature/main/domain/entities/login/state/login_state.dart';
import 'package:sample_bloc/feature/main/injection/injection.dart';
import 'package:sample_bloc/feature/main/presentation/modules/home/home_screen.dart';
import 'package:sample_bloc/feature/main/presentation/modules/login/login_cubit.dart';
import 'package:sample_bloc/feature/main/presentation/widgets/dialog/show_error_dialog.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;
  final GlobalKey<FormState> formKey = GlobalKey();

  final SnackBar snackBar = const SnackBar(
    backgroundColor: Colors.green,
    content: Text('Login Success!'),
  );

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => LoginScreen(title: 'App'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Please login before entering:',
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: TextFormField(
                  controller: _emailController,
                  validator: (value) {
                    return (value == null || value.isEmpty)
                        ? 'Please Enter Email'
                        : null;
                  },
                  decoration: inputDecoration('E-mail', Icons.person),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: TextFormField(
                  validator: (value) {
                    return (value == null || value.isEmpty)
                        ? 'Please Enter Password'
                        : null;
                  },
                  controller: _passwordController,
                  decoration: inputDecoration('Password', Icons.lock),
                  obscureText: true,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              BlocProvider(
                create: (_) => di<LoginCubit>(),
                child: Center(
                  child: BlocConsumer<LoginCubit, LoginState>(
                    listener: (BuildContext context, LoginState state) {
                      if(state is LoginFailed) {
                        showErrorDialog(context, state.message);
                      } else if (state is LoginSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        Navigator.pushReplacement(context, HomeScreen.route());
                      } else { }
                    },
                    builder: (BuildContext ctx, LoginState state) {
                      if (state is LoginLoading) {
                        return CircularProgressIndicator();
                      } else {
                        return ElevatedButton(
                            onPressed: () async {
                              if (formKey.currentState?.validate() ?? false) {
                                await ctx.read<LoginCubit>().loginUser(_emailController.text, _passwordController.text);
                              }
                            },
                            child: Text('Login yuk'),
                        );
                      }
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration inputDecoration(String labelText, IconData iconData,
      {String? prefix, String? helperText}) {
    return InputDecoration(
      contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      helperText: helperText,
      labelText: labelText,
      labelStyle: TextStyle(color: Colors.grey),
      fillColor: Colors.grey.shade200,
      filled: true,
      prefixText: prefix,
      prefixIcon: Icon(
        iconData,
        size: 20,
      ),
      prefixIconConstraints: BoxConstraints(minWidth: 60),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.black)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.black)),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.black)),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.black)),
    );
  }
}
