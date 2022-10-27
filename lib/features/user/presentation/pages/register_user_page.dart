import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/validator/form_validator.dart';
import '../../../../injection_container.dart';
import '../../../productCatalog/presentation/pages/product_catalog_page.dart';
import '../../domain/entities/user.dart';
import '../bloc/user_bloc.dart';
import '../cubit/register_user_form_validation_cubit.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_form_field.dart';
import '../widgets/submitting_form_status.dart';

class RegisterUserPage extends StatelessWidget {
  const RegisterUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => sl<UserBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<RegisterUserFormValidationCubit>(),
        ),
      ],
      child: const RegisterUserView(),
    );
  }
}

class RegisterUserView extends StatefulWidget {
  const RegisterUserView({super.key});
  @override
  State<RegisterUserView> createState() => _RegisterUserViewState();
}

class _RegisterUserViewState extends State<RegisterUserView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      listener: (context, state) {
        if (state is UserSuccess) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (_) => const ProductCatalogPage()));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Cadastrar usuário"),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const _NameInput(),
              const SizedBox(
                height: 16,
              ),
              const _EmailInput(),
              const SizedBox(
                height: 16,
              ),
              const _PasswordInput(),
              const SizedBox(
                height: 16,
              ),
              const _RegisterButton(),
              const SizedBox(
                height: 24,
              ),
              TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Já uma conta? Faça login",
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class _NameInput extends StatelessWidget {
  const _NameInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterUserFormValidationCubit,
        RegisterUserFormValidationState>(
      builder: (context, state) {
        return CustomTextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textInputAction: TextInputAction.next,
          labelText: "Nome de usuário",
          hintText: "Nome de usuário",
          onChanged: (String username) {
            context
                .read<RegisterUserFormValidationCubit>()
                .usernameChanged(username);
          },
          validator: (_) {
            if (state.username.invalid) {
              return state.username.errorMessage;
            } else {
              return null;
            }
          },
        );
      },
    );
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterUserFormValidationCubit,
        RegisterUserFormValidationState>(
      builder: (context, state) {
        return CustomTextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          labelText: "E-mail",
          hintText: "E-mail",
          onChanged: (String email) {
            context.read<RegisterUserFormValidationCubit>().emailChanged(email);
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
    return BlocBuilder<RegisterUserFormValidationCubit,
        RegisterUserFormValidationState>(
      builder: (context, state) {
        return CustomTextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          labelText: "Senha",
          hintText: "Senha",
          onChanged: (String password) {
            context
                .read<RegisterUserFormValidationCubit>()
                .passwordChanged(password);
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

class _RegisterButton extends StatelessWidget {
  const _RegisterButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterUserFormValidationCubit,
        RegisterUserFormValidationState>(
      builder: (context, state) {
        return CustomButton(
            onPressed: state.status.isValidated
                ? () {
                    final user = User(
                        username: state.username.value,
                        email: state.email.value,
                        password: state.password.value);

                    context.read<UserBloc>().add(UserRegistered(user: user));
                  }
                : null,
            child: const SubmittingFormStatus(
              labelText: "Cadastrar",
            ));
      },
    );
  }
}
