import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/responsive/responsive_utils.dart';
import '../../../core/constants/app_constants.dart';
import '../../../shared/widgets/custom_button.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);

    return Container(
      width: double.infinity,
      padding: ResponsiveUtils.getSectionPadding(context),
      color: AppTheme.darkSurface,
      child: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: ResponsiveUtils.getContentWidth(context),
          ),
          child: Column(
            children: [
              _buildSectionHeader(),
              const SizedBox(height: 60),
              isMobile
                  ? _buildMobileLayout()
                  : _buildDesktopLayout(),
              const SizedBox(height: 60),
              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader() {
    return Column(
      children: [
        Text(
          'Get In Touch',
          style: AppTheme.headingLarge.copyWith(
            color: AppTheme.darkTextPrimary,
          ),
        ).animate().fadeIn().slideY(begin: 30, end: 0),
        
        const SizedBox(height: 16),
        
        Text(
          'Let\'s work together on your next project',
          style: AppTheme.bodyLarge.copyWith(
            color: AppTheme.darkTextSecondary,
          ),
        ).animate(delay: 200.ms).fadeIn().slideY(begin: 20, end: 0),
        
        const SizedBox(height: 16),
        
        Container(
          width: 60,
          height: 4,
          decoration: BoxDecoration(
            gradient: AppTheme.primaryGradient,
            borderRadius: BorderRadius.circular(2),
          ),
        ).animate(delay: 300.ms).scaleX(),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        _buildContactForm(),
        const SizedBox(height: 40),
        _buildContactInfo(),
        const SizedBox(height: 40),
        _buildSocialLinks(),
      ],
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: _buildContactForm(),
        ),
        const SizedBox(width: 60),
        Expanded(
          flex: 2,
          child: Column(
            children: [
              _buildContactInfo(),
              const SizedBox(height: 40),
              _buildSocialLinks(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContactForm() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppTheme.darkCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppTheme.darkBorder,
          width: 1,
        ),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Send a Message',
              style: AppTheme.headingSmall.copyWith(
                color: AppTheme.primaryColor,
              ),
            ).animate(delay: 400.ms).fadeIn().slideX(begin: -30, end: 0),
            
            const SizedBox(height: 24),
            
            Row(
              children: [
                Expanded(
                  child: _buildTextField(
                    controller: _nameController,
                    label: 'Name',
                    icon: Icons.person_outline,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Name is required';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildTextField(
                    controller: _emailController,
                    label: 'Email',
                    icon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Email is required';
                      }
                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value!)) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ).animate(delay: 500.ms).fadeIn().slideY(begin: 20, end: 0),
            
            const SizedBox(height: 16),
            
            _buildTextField(
              controller: _subjectController,
              label: 'Subject',
              icon: Icons.subject_outlined,
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Subject is required';
                }
                return null;
              },
            ).animate(delay: 600.ms).fadeIn().slideY(begin: 20, end: 0),
            
            const SizedBox(height: 16),
            
            _buildTextField(
              controller: _messageController,
              label: 'Message',
              icon: Icons.message_outlined,
              maxLines: 6,
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Message is required';
                }
                return null;
              },
            ).animate(delay: 700.ms).fadeIn().slideY(begin: 20, end: 0),
            
            const SizedBox(height: 32),
            
            SizedBox(
              width: double.infinity,
              child: CustomButtonFactories.gradient(
                text: 'Send Message',
                onPressed: _submitForm,
                icon: Icons.send,
                isLoading: _isLoading,
                size: ButtonSize.large,
              ),
            ).animate(delay: 800.ms).fadeIn().scale(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    int? maxLines,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines ?? 1,
      validator: validator,
      style: AppTheme.bodyMedium.copyWith(
        color: AppTheme.darkTextPrimary,
      ),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: AppTheme.primaryColor),
        labelStyle: AppTheme.bodyMedium.copyWith(
          color: AppTheme.darkTextSecondary,
        ),
        filled: true,
        fillColor: AppTheme.darkBackground,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppTheme.darkBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppTheme.darkBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppTheme.primaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppTheme.errorColor),
        ),
      ),
    );
  }

  Widget _buildContactInfo() {
    final contactItems = [
      {
        'icon': Icons.email_outlined,
        'title': 'Email',
        'value': AppConstants.email,
        'action': () => _launchUrl('mailto:${AppConstants.email}'),
      },
      {
        'icon': Icons.phone_outlined,
        'title': 'Phone',
        'value': AppConstants.phone,
        'action': () => _launchUrl('tel:${AppConstants.phone}'),
      },
      {
        'icon': Icons.location_on_outlined,
        'title': 'Location',
        'value': AppConstants.location,
        'action': null,
      },
    ];

    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppTheme.darkCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppTheme.darkBorder,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Contact Information',
            style: AppTheme.headingSmall.copyWith(
              color: AppTheme.primaryColor,
            ),
          ).animate(delay: 400.ms).fadeIn().slideX(begin: -30, end: 0),
          
          const SizedBox(height: 24),
          
          ...contactItems.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            
            return GestureDetector(
              onTap: item['action'] as VoidCallback?,
              child: Container(
                margin: const EdgeInsets.only(bottom: 20),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.darkBackground,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppTheme.primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        item['icon'] as IconData,
                        color: AppTheme.primaryColor,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['title'] as String,
                            style: AppTheme.bodySmall.copyWith(
                              color: AppTheme.darkTextSecondary,
                            ),
                          ),
                          Text(
                            item['value'] as String,
                            style: AppTheme.bodyMedium.copyWith(
                              color: AppTheme.darkTextPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ].asMap().entries.map((entry) {
          final index = entry.key;
          final widget = entry.value;
          return widget.animate(delay: Duration(milliseconds: 500 + index * 100))
              .fadeIn()
              .slideX(begin: -30, end: 0);
        }).toList(),
      ),
    );
  }

  Widget _buildSocialLinks() {
    final socialLinks = [
      {
        'icon': Icons.code,
        'label': 'GitHub',
        'url': AppConstants.githubUrl,
      },
      {
        'icon': Icons.business,
        'label': 'LinkedIn',
        'url': AppConstants.linkedinUrl,
      },
      {
        'icon': Icons.language,
        'label': 'Portfolio',
        'url': AppConstants.portfolioUrl,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Connect With Me',
          style: AppTheme.headingSmall.copyWith(
            color: AppTheme.primaryColor,
          ),
        ).animate(delay: 800.ms).fadeIn().slideX(begin: -30, end: 0),
        
        const SizedBox(height: 20),
        
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: socialLinks.asMap().entries.map((entry) {
            final index = entry.key;
            final social = entry.value;
            
            return GestureDetector(
              onTap: () => _launchUrl(social['url'] as String),
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: AppTheme.darkCard,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppTheme.darkBorder,
                    width: 1,
                  ),
                ),
                child: Icon(
                  social['icon'] as IconData,
                  color: AppTheme.primaryColor,
                  size: 28,
                ),
              ),
            ).animate(delay: Duration(milliseconds: 900 + index * 100))
                .fadeIn()
                .scale();
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: AppTheme.darkBorder.withOpacity(0.3),
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          Text(
            'Made with ❤️ using Flutter',
            style: AppTheme.bodyMedium.copyWith(
              color: AppTheme.darkTextSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '© 2024 ${AppConstants.name}. All rights reserved.',
            style: AppTheme.caption.copyWith(
              color: AppTheme.darkTextTertiary,
            ),
          ),
        ],
      ),
    ).animate(delay: 1200.ms).fadeIn();
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    // Simulate form submission
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false;
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Message sent successfully!',
            style: AppTheme.bodyMedium.copyWith(color: Colors.white),
          ),
          backgroundColor: AppTheme.successColor,
          behavior: SnackBarBehavior.floating,
        ),
      );

      // Clear form
      _nameController.clear();
      _emailController.clear();
      _subjectController.clear();
      _messageController.clear();
    }
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
