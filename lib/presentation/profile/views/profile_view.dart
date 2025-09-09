import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../cubit/profile_cubit.dart';
import '../../../routes/app_router.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_colors.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().loadProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.profile),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Logout'),
                  content: const Text('Are you sure you want to logout?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text(AppStrings.cancel),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        // TODO: Implement logout
                        context.go(AppRouter.login);
                      },
                      child: const Text(AppStrings.logout),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ProfileError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Colors.red,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    state.message,
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => context.read<ProfileCubit>().loadProfile(),
                    child: const Text(AppStrings.retry),
                  ),
                ],
              ),
            );
          } else if (state is ProfileLoaded) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(AppSizes.paddingM),
              child: Column(
                children: [
                  // Profile Header
                  Container(
                    padding: const EdgeInsets.all(AppSizes.paddingL),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(AppSizes.radiusL),
                    ),
                    child: Column(
                      children: [
                        // Profile Picture
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: AppColors.white,
                          child: state.user.avatar != null
                              ? ClipOval(
                                  child: Image.network(
                                    state.user.avatar!,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Icon(
                                        Icons.person,
                                        size: 50,
                                        color: AppColors.primary,
                                      );
                                    },
                                  ),
                                )
                              : const Icon(
                                  Icons.person,
                                  size: 50,
                                  color: AppColors.primary,
                                ),
                        ),
                        const SizedBox(height: AppSizes.spacingM),
                        
                        // User Name
                        Text(
                          state.user.name,
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: AppSizes.spacingS),
                        
                        // User Email
                        Text(
                          state.user.email,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.white.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSizes.spacingL),
                  
                  // Profile Options
                  _ProfileOptionTile(
                    icon: Icons.person_outline,
                    title: 'Edit Profile',
                    subtitle: 'Coming Soon',
                    onTap: () {
                      _showComingSoonSnackBar(context, 'Edit Profile');
                    },
                  ),
                  _ProfileOptionTile(
                    icon: Icons.shopping_bag_outlined,
                    title: AppStrings.orders,
                    subtitle: 'Coming Soon',
                    onTap: () {
                      _showComingSoonSnackBar(context, 'Orders');
                    },
                  ),
                  _ProfileOptionTile(
                    icon: Icons.favorite_outline,
                    title: 'Favorites',
                    subtitle: 'Your saved items',
                    onTap: () {
                      context.go(AppRouter.favorites);
                    },
                  ),
                  _ProfileOptionTile(
                    icon: Icons.location_on_outlined,
                    title: 'Addresses',
                    subtitle: 'Coming Soon',
                    onTap: () {
                      _showComingSoonSnackBar(context, 'Addresses');
                    },
                  ),
                  _ProfileOptionTile(
                    icon: Icons.payment_outlined,
                    title: 'Payment Methods',
                    subtitle: 'Manage your payment options',
                    onTap: () {
                      _showPaymentMethodsBottomSheet(context);
                    },
                  ),
                  _ProfileOptionTile(
                    icon: Icons.notifications_outlined,
                    title: 'Notifications',
                    subtitle: 'Coming Soon',
                    onTap: () {
                      _showComingSoonSnackBar(context, 'Notifications');
                    },
                  ),
                  _ProfileOptionTile(
                    icon: Icons.help_outline,
                    title: 'Help & Support',
                    subtitle: 'maharramovziya7@gmail.com',
                    onTap: () {
                      _showHelpSupportDialog(context);
                    },
                  ),
                  _ProfileOptionTile(
                    icon: Icons.info_outline,
                    title: 'About',
                    subtitle: 'App version and information',
                    onTap: () {
                      _showAboutDialog(context);
                    },
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  void _showComingSoonSnackBar(BuildContext context, String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$feature - Coming Soon!'),
        backgroundColor: AppColors.primary,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showPaymentMethodsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(AppSizes.paddingL),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Payment Methods',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppSizes.spacingL),
            _PaymentMethodTile(
              icon: Icons.credit_card,
              title: 'Visa Card',
              subtitle: 'Pay with your Visa card',
              onTap: () {
                Navigator.pop(context);
                _showComingSoonSnackBar(context, 'Visa Card Payment');
              },
            ),
            _PaymentMethodTile(
              icon: Icons.money,
              title: 'Cash on Delivery',
              subtitle: 'Pay when you receive your order',
              onTap: () {
                Navigator.pop(context);
                _showComingSoonSnackBar(context, 'Cash on Delivery');
              },
            ),
            const SizedBox(height: AppSizes.spacingL),
          ],
        ),
      ),
    );
  }

  void _showHelpSupportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Help & Support'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('For any questions or support, please contact:'),
            SizedBox(height: 8),
            Text(
              'maharramovziya7@gmail.com',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('About'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'E-Commerce App',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 8),
            Text('Version: 1.0.0'),
            SizedBox(height: 16),
            Text('Created by: Ziya Məhərrəmli'),
            SizedBox(height: 8),
            Text('This is an AI-powered e-commerce application with features like:'),
            SizedBox(height: 8),
            Text('• Product browsing and search'),
            Text('• Shopping cart functionality'),
            Text('• Favorites system'),
            Text('• User authentication'),
            Text('• And much more!'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}

class _ProfileOptionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ProfileOptionTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppSizes.spacingS),
      child: ListTile(
        leading: Icon(
          icon,
          color: AppColors.primary,
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}

class _PaymentMethodTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _PaymentMethodTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppSizes.spacingS),
      child: ListTile(
        leading: Icon(
          icon,
          color: AppColors.primary,
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
