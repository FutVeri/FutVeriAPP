import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:futveri/core/theme/app_theme.dart';
import 'package:futveri/features/auth/presentation/viewmodels/auth_viewmodel.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PersonalInfoPage extends ConsumerStatefulWidget {
  const PersonalInfoPage({super.key});

  @override
  ConsumerState<PersonalInfoPage> createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends ConsumerState<PersonalInfoPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _bioController;
  bool _isEditing = false;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    final authState = ref.read(authProvider);
    _nameController = TextEditingController(text: authState.userName ?? '');
    _bioController = TextEditingController(
      text: authState.userProfile?['bio'] ?? '',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;
    
    setState(() => _isSaving = true);
    
    try {
      final supabase = Supabase.instance.client;
      final userId = supabase.auth.currentUser?.id;
      
      if (userId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Lütfen önce giriş yapın')),
        );
        return;
      }

      await supabase.from('users').upsert({
        'id': userId,
        'name': _nameController.text.trim(),
        'bio': _bioController.text.trim(),
        'updated_at': DateTime.now().toIso8601String(),
      });

      // Refresh auth state
      await ref.read(authProvider.notifier).refreshUserProfile();

      setState(() => _isEditing = false);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profil başarıyla güncellendi'),
            backgroundColor: AppTheme.primaryGreen,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Hata: ${e.toString()}'),
            backgroundColor: AppTheme.errorRed,
          ),
        );
      }
    } finally {
      setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kişisel Bilgiler'),
        actions: [
          if (authState.isAuthenticated && !_isEditing)
            IconButton(
              icon: const Icon(LucideIcons.pencil),
              onPressed: () => setState(() => _isEditing = true),
            ),
          if (_isEditing)
            IconButton(
              icon: const Icon(LucideIcons.x),
              onPressed: () => setState(() => _isEditing = false),
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              if (!_isEditing) ...[
                _buildInfoCard(
                  label: 'Görünen Ad',
                  value: authState.userName ?? 'Giriş Yapılmadı',
                  icon: LucideIcons.user,
                ),
                Gap(16.h),
                _buildInfoCard(
                  label: 'E-posta Adresi',
                  value: authState.userEmail ?? 'Giriş Yapılmadı',
                  icon: LucideIcons.mail,
                ),
                Gap(16.h),
                _buildInfoCard(
                  label: 'Biyografi',
                  value: authState.userProfile?['bio']?.toString().isNotEmpty == true 
                      ? authState.userProfile!['bio'] 
                      : 'Henüz bir biyografi eklenmemiş.',
                  icon: LucideIcons.fileText,
                ),
              ] else ...[
                _buildEditableField(
                  label: 'Görünen Ad',
                  controller: _nameController,
                  icon: LucideIcons.user,
                  hint: 'Adınızı girin',
                ),
                Gap(16.h),
                _buildInfoCard(
                  label: 'E-posta Adresi',
                  value: authState.userEmail ?? 'Giriş Yapılmadı',
                  icon: LucideIcons.mail,
                  isDisabled: true,
                ),
                Gap(16.h),
                _buildEditableField(
                  label: 'Biyografi',
                  controller: _bioController,
                  icon: LucideIcons.fileText,
                  hint: 'Kendiniz hakkında bir şeyler yazın...',
                  maxLines: 4,
                ),
              ],
              Gap(32.h),
              if (!authState.isAuthenticated)
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: Colors.amber.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.amber.withOpacity(0.3)),
                  ),
                  child: Row(
                    children: [
                      Icon(LucideIcons.alertTriangle, color: Colors.amber, size: 20.sp),
                      Gap(12.w),
                      Expanded(
                        child: Text(
                          'Profilinizi düzenlemek için lütfen giriş yapın.',
                          style: TextStyle(
                            color: Colors.amber,
                            fontSize: 13.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              else if (_isEditing)
                SizedBox(
                  width: double.infinity,
                  height: 56.h,
                  child: ElevatedButton(
                    onPressed: _isSaving ? null : _saveProfile,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryGreen,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: _isSaving
                        ? SizedBox(
                            width: 20.w,
                            height: 20.w,
                            child: const CircularProgressIndicator(
                              color: Colors.black,
                              strokeWidth: 2,
                            ),
                          )
                        : const Text('Kaydet', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                )
              else
                SizedBox(
                  width: double.infinity,
                  height: 56.h,
                  child: ElevatedButton(
                    onPressed: () => setState(() => _isEditing = true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryGreen,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Profili Düzenle', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required String label, 
    required String value, 
    required IconData icon,
    bool isDisabled = false,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Opacity(
        opacity: isDisabled ? 0.5 : 1.0,
        child: Row(
          children: [
            Icon(icon, color: AppTheme.primaryGreen, size: 24.sp),
            Gap(16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: TextStyle(color: AppTheme.textGrey, fontSize: 12.sp)),
                  Gap(4.h),
                  Text(value, style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w500)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEditableField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    required String hint,
    int maxLines = 1,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.primaryGreen.withOpacity(0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppTheme.primaryGreen, size: 24.sp),
          Gap(16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: TextStyle(color: AppTheme.textGrey, fontSize: 12.sp)),
                Gap(8.h),
                TextFormField(
                  controller: controller,
                  maxLines: maxLines,
                  style: TextStyle(color: Colors.white, fontSize: 16.sp),
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: TextStyle(color: AppTheme.textGrey.withOpacity(0.5)),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                  validator: (value) {
                    if (label == 'Görünen Ad' && (value == null || value.trim().isEmpty)) {
                      return 'Ad boş bırakılamaz';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
