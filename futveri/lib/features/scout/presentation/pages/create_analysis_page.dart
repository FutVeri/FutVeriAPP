import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:futveri/core/theme/app_theme.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CreateAnalysisPage extends StatefulWidget {
  const CreateAnalysisPage({super.key});

  @override
  State<CreateAnalysisPage> createState() => _CreateAnalysisPageState();
}

class _CreateAnalysisPageState extends State<CreateAnalysisPage> {
  final _formKey = GlobalKey<FormState>();
  final _homeTeamController = TextEditingController();
  final _awayTeamController = TextEditingController();
  final _scorePredictionController = TextEditingController();
  final _analysisController = TextEditingController();
  bool _isSubmitting = false;

  Future<void> _submitAnalysis() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);

    try {
      final user = Supabase.instance.client.auth.currentUser;
      if (user == null) throw Exception('Giriş yapılmadı');

      await Supabase.instance.client.from('match_analyses').insert({
        'user_id': user.id,
        'home_team': _homeTeamController.text,
        'away_team': _awayTeamController.text,
        'score_prediction': _scorePredictionController.text,
        'analysis_content': _analysisController.text,
        'match_date': DateTime.now().toIso8601String(),
        'created_at': DateTime.now().toIso8601String(),
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Analiz başarıyla kaydedildi!')),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Hata: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Maç Analizi & Tahmin'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Maç Detayları',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              Gap(20.h),
              Row(
                children: [
                  Expanded(
                    child: _buildField(
                      controller: _homeTeamController,
                      label: 'Ev Sahibi',
                      hint: 'Örn: Galatasaray',
                    ),
                  ),
                  Gap(12.w),
                  Expanded(
                    child: _buildField(
                      controller: _awayTeamController,
                      label: 'Deplasman',
                      hint: 'Örn: Fenerbahçe',
                    ),
                  ),
                ],
              ),
              Gap(20.h),
              _buildField(
                controller: _scorePredictionController,
                label: 'Skor Tahmini',
                hint: 'Örn: 2-1',
              ),
              Gap(20.h),
              _buildField(
                controller: _analysisController,
                label: 'Analiz ve Yorumlar',
                hint: 'Maç hakkındaki taktiksel öngörüleriniz...',
                maxLines: 5,
              ),
              Gap(40.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isSubmitting ? null : _submitAnalysis,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryGreen,
                    foregroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: _isSubmitting
                      ? const CircularProgressIndicator(color: Colors.black)
                      : const Text('Analizi Yayınla', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String label,
    required String hint,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 14.sp, color: AppTheme.textGrey)),
        Gap(8.h),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.white24),
            filled: true,
            fillColor: AppTheme.surfaceDark,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
            ),
          ),
          validator: (value) => value == null || value.isEmpty ? 'Bu alan boş bırakılamaz' : null,
        ),
      ],
    );
  }
}
