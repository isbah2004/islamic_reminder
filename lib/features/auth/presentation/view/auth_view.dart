import 'package:azan_reminder/core/constants/exports.dart';
import 'package:azan_reminder/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:azan_reminder/features/auth/presentation/widgets/custom_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _animationController.forward();
    context.read<AuthBloc>().add(AuthInitialEvent());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF10B981), Color(0xFF0D9488)],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: BlocConsumer<AuthBloc, AuthState>(
                    listener: (context, state) {
                      if (state is AuthFailure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.message),
                            backgroundColor: Colors.red,
                          ),
                        );
                      } else if (state is AuthSuccess) {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          RoutesName.home,
                          (route) => false,
                        );
                      }
                    },
                    builder: (context, state) {
                      bool isLogin = state is AuthLoginView;
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 24.0,
                              horizontal: 10,
                            ),
                            child: Column(
                              children: [
                                Text(
                                  'بسم الله الرحمن الرحيم',
                                  style: GoogleFonts.amiri(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'In the name of Allah, the Most Gracious, the Most Merciful',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black54,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 32),
                                Form(
                                  key: _formKey,
                                  child: Column(
                                    children: [
                                      if (!isLogin)
                                        CustomTextField(
                                          controller: _nameController,
                                          label: 'Name',
                                          icon: Icons.person_outline,
                                          focusNode: _nameFocusNode,
                                          nextFocusNode: _emailFocusNode,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter your name';
                                            }
                                            return null;
                                          },
                                        ),
                                      if (!isLogin) const SizedBox(height: 16),
                                      CustomTextField(
                                        controller: _emailController,
                                        label: 'Email',
                                        icon: Icons.email_outlined,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        focusNode: _emailFocusNode,
                                        nextFocusNode: _passwordFocusNode,
                                        validator: (value) {
                                          return Utils.validateEmail(value!);
                                        },
                                      ),
                                      const SizedBox(height: 16),
                                      CustomTextField(
                                        controller: _passwordController,
                                        label: 'Password',
                                        icon: Icons.lock_outline,
                                        obscureText: true,
                                        focusNode: _passwordFocusNode,
                                        validator: (value) {
                                          return Utils.validatePassword(value!);
                                        },
                                      ),
                                      const SizedBox(height: 24),
                                      CustomButton(
                                        text: isLogin ? 'Login' : 'Sign Up',
                                        onPressed: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            if (isLogin) {
                                              context.read<AuthBloc>().add(
                                                AuthLogin(
                                                  email: _emailController.text,
                                                  password:
                                                      _passwordController.text,
                                                ),
                                              );
                                            } else {
                                              context.read<AuthBloc>().add(
                                                AuthSignUp(
                                                  email: _emailController.text,
                                                  password:
                                                      _passwordController.text,
                                                  name: _nameController.text,
                                                ),
                                              );
                                            }
                                          }
                                        },
                                        loading: state is AuthLoading,
                                      ),
                                      const SizedBox(height: 16),
                                      TextButton(
                                        onPressed: () {
                                          context.read<AuthBloc>().add(
                                            isLogin
                                                ? AuthSignUpViewEvent()
                                                : AuthLoginViewEvent(),
                                          );
                                          _animationController.reset();
                                          _animationController.forward();
                                        },
                                        child: Text(
                                          isLogin
                                              ? 'Don\'t have an account? Sign Up'
                                              : 'Already have an account? Login',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 24,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green.shade50,
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(16),
                                bottomRight: Radius.circular(16),
                              ),
                            ),
                            child: const Text(
                              '"Seek knowledge from the cradle to the grave." - Prophet Muhammad (PBUH)',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF065F46),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
