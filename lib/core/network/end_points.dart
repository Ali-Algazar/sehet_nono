class ApiEndpoints {
  // === المصادقة والتسجيل ===
  static const String register = 'auth/register'; // POST
  static const String login = 'auth/login'; // POST
  static const String getMe = 'auth/me'; // GET
  static const String updateMe = 'auth/me'; // PUT
  static const String updateFcmToken = 'auth/fcmtoken'; // PUT
  static const String deleteMe = 'auth/me'; // DELETE

  // === الأطفال ===
  static const String addChild = 'children'; // POST
  static const String getMyChildren = 'children'; // GET
  // للـ PUT و DELETE، هتحتاج تضيف ID الطفل للـ path
  static String updateChild(String childId) => 'children/$childId'; // PUT
  static String deleteChild(String childId) => 'children/$childId'; // DELETE

  // === جدول التطعيمات ===
  // للـ GET، هتحتاج تضيف ID الطفل للـ path
  static String getChildSchedule(String childId) => 'schedule/$childId'; // GET
  // للـ PUT، هتحتاج تضيف ID سجل المتابعة للـ path
  static String updateScheduleItem(String scheduleId) =>
      'schedule/$scheduleId'; // PUT

  // === سجلات النمو ===
  static const String addGrowthRecord = 'growth'; // POST
  // للـ GET، هتحتاج تضيف ID الطفل للـ path
  static String getChildGrowthRecords(String childId) =>
      'growth/child/$childId'; // GET
  // للـ PUT و DELETE، هتحتاج تضيف ID السجل للـ path
  static String updateGrowthRecord(String recordId) =>
      'growth/$recordId'; // PUT
  static String deleteGrowthRecord(String recordId) =>
      'growth/$recordId'; // DELETE

  // === السجلات اليومية (رضاعة/حفاض/نوم) ===
  static const String addDailyLog = 'logs'; // POST
  // للـ GET، هتحتاج تضيف ID الطفل للـ path (وممكن query param ?type=...)
  static String getChildDailyLogs(String childId) =>
      'logs/child/$childId'; // GET
  // للـ PUT و DELETE، هتحتاج تضيف ID السجل للـ path
  static String updateDailyLog(String logId) => 'logs/$logId'; // PUT
  static String deleteDailyLog(String logId) => 'logs/$logId'; // DELETE

  // === يوميات الطفل ===
  static const String addDiaryEntry = 'diary'; // POST
  // للـ GET، هتحتاج تضيف ID الطفل للـ path
  static String getChildDiaryEntries(String childId) =>
      'diary/child/$childId'; // GET
  // للـ PUT و DELETE، هتحتاج تضيف ID اليومية للـ path
  static String updateDiaryEntry(String entryId) => 'diary/$entryId'; // PUT
  static String deleteDiaryEntry(String entryId) => 'diary/$entryId'; // DELETE

  // === الكوميونيتي (المجتمع) ===
  static const String createPost = 'posts'; // POST
  static const String getAllPosts = 'posts'; // GET
  // للـ GET و DELETE، هتحتاج تضيف ID البوست للـ path
  static String getPostById(String postId) => 'posts/$postId'; // GET
  static String deletePost(String postId) => 'posts/$postId'; // DELETE
  // للـ POST، هتحتاج تضيف ID البوست للـ path
  static String addComment(String postId) => 'posts/$postId/comments'; // POST
  // للـ DELETE، هتحتاج تضيف ID الكومنت للـ path
  static String deleteComment(String commentId) =>
      'comments/$commentId'; // DELETE
  // للـ PUT، هتحتاج تضيف ID البوست للـ path
  static String likePost(String postId) => 'posts/$postId/like'; // PUT

  // === المقالات والنصائح ===
  static const String getAllArticles =
      'articles'; // GET (ممكن query param ?category=...)
  // للـ GET، هتحتاج تضيف ID المقال للـ path
  static String getArticleById(String articleId) =>
      'articles/$articleId'; // GET
  // --- Admin Only ---
  static const String createArticle = 'articles'; // POST (Admin)
  static String updateArticle(String articleId) =>
      'articles/$articleId'; // PUT (Admin)
  static String deleteArticle(String articleId) =>
      'articles/$articleId'; // DELETE (Admin)

  // === الأدوية ===
  static const String getAllMedicines =
      'medicines'; // GET (ممكن query params ?category=... & ?search=...)
  // للـ GET، هتحتاج تضيف ID الدواء للـ path
  static String getMedicineById(String medicineId) =>
      'medicines/$medicineId'; // GET
  // --- Admin Only ---
  static const String createMedicine = 'medicines'; // POST (Admin)
  static String updateMedicine(String medicineId) =>
      'medicines/$medicineId'; // PUT (Admin)
  static String deleteMedicine(String medicineId) =>
      'medicines/$medicineId'; // DELETE (Admin)

  // === الأطباء ===
  static const String getNearbyDoctors =
      'doctors/nearby'; // GET (مع query params ?lng=...&lat=...)
  static const String getAllDoctors = 'doctors'; // GET
  // للـ GET، هتحتاج تضيف ID الطبيب للـ path
  static String getDoctorById(String doctorId) => 'doctors/$doctorId'; // GET
  // --- Admin Only ---
  static const String createDoctor = 'doctors'; // POST (Admin)
  static String updateDoctor(String doctorId) =>
      'doctors/$doctorId'; // PUT (Admin)
  static String deleteDoctor(String doctorId) =>
      'doctors/$doctorId'; // DELETE (Admin)

  // === الأسئلة الشائعة (البوت) ===
  static const String searchFaqs = 'faqs/search'; // GET (مع query param ?q=...)
  static const String getAllFaqs =
      'faqs'; // GET (ممكن query param ?category=...)
  // للـ GET، هتحتاج تضيف ID السؤال للـ path
  static String getFaqById(String faqId) => 'faqs/$faqId'; // GET
  // --- Admin Only ---
  static const String createFaq = 'faqs'; // POST (Admin)
  static String updateFaq(String faqId) => 'faqs/$faqId'; // PUT (Admin)
  static String deleteFaq(String faqId) => 'faqs/$faqId'; // DELETE (Admin)

  // === لوحة التحكم (الأدمن) ===
  static const String getAllUsers = 'admin/users'; // GET (Admin)
  static const String getAllChildren = 'admin/children'; // GET (Admin)
  static const String getNotificationLogs =
      'admin/notifications/logs'; // GET (Admin)

  // === وصفات الأكل ===
  static const String getAllRecipes =
      'recipes'; // GET (ممكن query params ?ageGroup=... & ?category=...)
  // للـ GET، هتحتاج تضيف ID الوصفة للـ path
  static String getRecipeById(String recipeId) => 'recipes/$recipeId'; // GET
  // --- Admin Only ---
  static const String createRecipe = 'recipes'; // POST (Admin)
  static String updateRecipe(String recipeId) =>
      'recipes/$recipeId'; // PUT (Admin)
  static String deleteRecipe(String recipeId) =>
      'recipes/$recipeId'; // DELETE (Admin)

  // === الأصوات الهادئة ===
  static const String getAllSounds =
      'sounds'; // GET (ممكن query param ?category=...)
  // للـ GET، هتحتاج تضيف ID الصوت للـ path
  static String getSoundById(String soundId) => 'sounds/$soundId'; // GET
  // --- Admin Only ---
  static const String createSound = 'sounds'; // POST (Admin)
  static String updateSound(String soundId) => 'sounds/$soundId'; // PUT (Admin)
  static String deleteSound(String soundId) =>
      'sounds/$soundId'; // DELETE (Admin)

  // === قائمة التطعيمات الرئيسية ===
  static const String getAllVaccines = 'vaccines'; // GET
  // --- Admin Only ---
  static const String createVaccine = 'vaccines'; // POST (Admin)
  static String updateVaccine(String vaccineId) =>
      'vaccines/$vaccineId'; // PUT (Admin)
  static String deleteVaccine(String vaccineId) =>
      'vaccines/$vaccineId'; // DELETE (Admin)

  // === Vercel Cron Trigger ===
  static const String triggerCronNotifications =
      'cron/send-reminders'; // GET (needs secret key)
}
