/// يحتوي هذا الكلاس على ثوابت (constants) لأسماء
/// العمليات التي يتم تخزينها في طابور المزامنة (Sync Queue)
/// عند إجراء تعديلات بدون اتصال بالإنترنت.
class PendingOperationType {
  // --- المصادقة والتسجيل (Authentication) ---
  /// تحديث بيانات المستخدم (الاسم/الإيميل)
  static const String updateUser = 'UPDATE_USER';

  /// تحديث توكن الإشعارات
  static const String updateFcmToken = 'UPDATE_FCM_TOKEN';

  /// حذف حساب المستخدم (هذه عملية خاصة جدًا وقد لا تحتاج مزامنة)
  static const String deleteUser = 'DELETE_USER';

  // --- الأطفال (Children) ---
  /// إضافة طفل جديد
  static const String addChild = 'ADD_CHILD';

  /// تعديل بيانات طفل
  static const String updateChild = 'UPDATE_CHILD';

  /// حذف طفل
  static const String deleteChild = 'DELETE_CHILD';

  // --- جدول التطعيمات (Schedule) ---
  /// تحديث حالة تطعيم (تم أخذه، ملاحظات، إلخ)
  static const String updateVaccineStatus = 'UPDATE_VACCINE_STATUS';

  // --- سجلات النمو (Growth) ---
  /// إضافة سجل نمو جديد
  static const String addGrowthRecord = 'ADD_GROWTH_RECORD';

  /// تعديل سجل نمو
  static const String updateGrowthRecord = 'UPDATE_GROWTH_RECORD';

  /// حذف سجل نمو
  static const String deleteGrowthRecord = 'DELETE_GROWTH_RECORD';

  // --- السجلات اليومية (Logs) ---
  /// إضافة سجل يومي (رضاعة، حفاض، نوم)
  static const String addDailyLog = 'ADD_DAILY_LOG';

  /// تعديل سجل يومي
  static const String updateDailyLog = 'UPDATE_DAILY_LOG';

  /// حذف سجل يومي
  static const String deleteDailyLog = 'DELETE_DAILY_LOG';

  // --- يوميات الطفل (Diary) ---
  /// إضافة يومية (ذكرى) جديدة
  static const String addDiaryEntry = 'ADD_DIARY_ENTRY';

  /// تعديل يومية
  static const String updateDiaryEntry = 'UPDATE_DIARY_ENTRY';

  /// حذف يومية
  static const String deleteDiaryEntry = 'DELETE_DIARY_ENTRY';

  // --- الكوميونيتي (Community) ---
  /// إنشاء بوست جديد
  static const String createPost = 'CREATE_POST';

  /// حذف بوست
  static const String deletePost = 'DELETE_POST';

  /// إضافة كومنت
  static const String addComment = 'ADD_COMMENT';

  /// حذف كومنت
  static const String deleteComment = 'DELETE_COMMENT';

  /// إعجاب أو إلغاء إعجاب ببوست
  static const String togglePostLike = 'TOGGLE_POST_LIKE';
}
