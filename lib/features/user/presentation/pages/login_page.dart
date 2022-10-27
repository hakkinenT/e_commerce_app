import 'package:e_commerce_app/features/productCatalog/presentation/pages/product_catalog_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/validator/form_validator.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/user.dart';
import '../bloc/user_bloc.dart';
import '../cubit/login_form_validation_cubit.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_form_field.dart';
import '../widgets/submitting_form_status.dart';

import 'register_user_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => sl<UserBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<LoginFormValidationCubit>(),
        ),
      ],
      child: const LoginView(),
    );
  }
}

class LoginView extends StatefulWidget {
  const LoginView({super.key});
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserSuccess) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (_) => const ProductCatalogPage()));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Login"),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const _EmailInput(),
              const SizedBox(
                height: 16,
              ),
              const _PasswordInput(),
              const SizedBox(
                height: 16,
              ),
              const _LoginButton(),
              const SizedBox(
                height: 24,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const RegisterUserPage()));
                  },
                  child: const Text(
                    "Não tem uma conta? Cadastre-se",
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginFormValidationCubit, LoginFormValidationState>(
      builder: (context, state) {
        return CustomTextFormField(
          key: const ValueKey("emailInput_loginPage"),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          labelText: "E-mail",
          hintText: "E-mail",
          onChanged: (String email) {
            context.read<LoginFormValidationCubit>().emailChanged(email);
          },
          validator: (_) {
            if (state.email.invalid) {
              return state.email.errorMessage;
            } else {
              return null;
            }
          },
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginFormValidationCubit, LoginFormValidationState>(
      builder: (context, state) {
        return CustomTextFormField(
          key: const ValueKey("passwordInput_loginPage"),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          labelText: "Senha",
          hintText: "Senha",
          onChanged: (String password) {
            context.read<LoginFormValidationCubit>().passwordChanged(password);
          },
          validator: (_) {
            if (state.password.invalid) {
              return state.password.errorMessage;
            } else {
              return null;
            }
          },
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginFormValidationCubit, LoginFormValidationState>(
      builder: (context, state) {
        return CustomButton(
            key: const ValueKey("loginButton_loginPage"),
            onPressed: state.status.isValidated
                ? () {
                    final user = User(
                        email: state.email.value,
                        password: state.password.value);
                    BlocProvider.of<UserBloc>(context)
                        .add(UserLogged(user: user));
                  }
                : null,
            child: const SubmittingFormStatus(
              labelText: "Fazer Login",
            ));
      },
    );
  }
}
