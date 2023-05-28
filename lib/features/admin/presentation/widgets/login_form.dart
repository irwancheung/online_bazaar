import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:online_bazaar/exports.dart';
import 'package:online_bazaar/features/admin/domain/repositories/admin_auth_repository.dart';
import 'package:online_bazaar/features/admin/presentation/cubit/admin_auth_cubit.dart';
import 'package:online_bazaar/features/shared/presentation/widgets/app_elevated_button.dart';
import 'package:online_bazaar/features/shared/presentation/widgets/loading_indicator.dart';
import 'package:online_bazaar/features/shared/presentation/widgets/underline_text_field.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  static const _emailField = 'email';
  static const _passwordField = 'password';

  final _formKey = GlobalKey<FormBuilderState>();

  bool _loggedIn = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_loggedIn) {
        context.go(adminPage);
      }
    });
  }

  void _login() {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final email = _formKey.currentState!.fields[_emailField]!.value as String;
      final password =
          _formKey.currentState!.fields[_passwordField]!.value as String;

      context
          .read<AdminAuthCubit>()
          .logIn(LoginParams(email: email, password: password));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminAuthCubit, AdminAuthState>(
      listener: (context, state) {
        if (state is LoginFailureState) {
          context.showErrorSnackBar(state.errorMessage!);
        }

        if (state is LoginSuccessState) {
          context.go(adminPage);
        }
      },
      builder: (context, state) {
        return FormBuilder(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                UnderlineTextField(
                  name: _emailField,
                  label: 'Email',
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.email(),
                  ]),
                ),
                20.h.height,
                UnderlineTextField(
                  name: _passwordField,
                  label: 'Password',
                  obscureText: true,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.minLength(6),
                  ]),
                ),
                100.h.height,
                BlocBuilder<AdminAuthCubit, AdminAuthState>(
                  builder: (context, state) {
                    if (state is LoginSuccessState) {
                      _loggedIn = true;
                    }

                    if (state is LoginLoadingState) {
                      return const LoadingIndicator();
                    }

                    return AppElevatedButton(
                      label: 'Masuk',
                      onPressed: _login,
                    );
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
