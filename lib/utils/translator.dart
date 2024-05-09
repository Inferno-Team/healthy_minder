import 'package:get/get.dart';

class Translator extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'ar_SY': {
          Keys.password.name: ' كلمة المرور',
          Keys.loginTitle.name: ' قم بتسجيل الدخول لحسابك',
          Keys.email.name: ' بريد الالكتروني',
          Keys.doNotHaveAccount.name: ' لا تمتلك حساب؟',
          Keys.registerNow.name: ' انشئ حساب',
          Keys.login.name: ' تسجيل الدخول',
          Keys.signup.name: ' إنشاء حساب',
          Keys.signupTitle.name: ' أنشئ حساب لبدء الاستخدام',
          Keys.alreadyHaveAccount.name: ' لديك حساب بالفعل؟',
          Keys.personalInfo.name: ' معلومات شخصية',
          Keys.personalInfoTitle.name: ' قبل البدء، نود أن نحصل على مساعدتك',
          Keys.gender.name: ' :الجنس',
          Keys.diseaseQuestion.name: ' هل تعاني من أي أمراض ',
          Keys.goalsQuestion.name: ' اختر أهدافك البدنية',
          Keys.goodMorning.name: ' يوما سعيدا',
          Keys.strength.name: ',قوة',
          Keys.health.name: ' صحة',
          Keys.andFitness.name: ' ولياقة',
          Keys.yourGoals.name: ' الاهداف الخاصة بك',
          Keys.next.name: ' التالي',
          Keys.firstName.name: ' الاسم الاول',
          Keys.lastName.name: ' الاسم الاخير',
          Keys.male.name: ' ذكر ',
          Keys.male.name: ' أنثى',
          Keys.birthDate.name: ' تاريخ الميلاد',
          Keys.height.name: ' الوزن',
          Keys.weight.name: ' الطول',
          Keys.selectYourDiseases.name: ' اختر الامراض التي تعاني منها',
          Keys.home.name: ' الرئيسية',
          Keys.messages.name: ' الرسائل',
          Keys.premium.name: ' حصري',
          Keys.notification.name: ' الاشعارات',
          Keys.logOut.name: ' تسجيل خروج',
          Keys.coach.name: ' المدرب',
          Keys.exercies.name: ' تمارين',
          Keys.thisWeek.name: ' هذا الاسبوع ',
          Keys.send.name: ' أرسل ',
          Keys.aMessage.name: ' رسالة',
          Keys.update.name: ' قام بتحديث',
          Keys.yourDiet.name: ' الريجيم الخاص بك',
          Keys.add.name: ' أضاف',
          Keys.alarm.name: ' منبه',
          Keys.its.name: ' إنه',
          Keys.time.name: ' وقت',
          Keys.to.name: ' لكي',
          Keys.train.name: ' تتدرب',
          Keys.newMeal.name: ' وجبة جديدة',
          Keys.ago.name: ' مضت',
          Keys.min.name: ' دقيقة',
          Keys.day.name: ' يوم',
          Keys.month.name: ' شهر',
          Keys.justNow.name: ' الان',
          Keys.ksp.name: ' 25K SP',
          Keys.onceAndForAll.name: ' مرة واحدة وللأبد',
          Keys.access.name: ' الحصول',
          Keys.toAll.name: ' على كل ',
          Keys.features.name: ' المزايا',
          Keys.chat.name: ' إجراء محادثة',
          Keys.withAny.name: ' مع أي',
          Keys.private.name: ' الخاص',
          Keys.choose.name: ' اختار',
          Keys.change.name: ' تغيير',
          Keys.your.name: ' الخاص  ',
          Keys.content.name:
              'تتم عملية الدفع عند الضغط على الزر أدناه\n ويتم مسح رمز QR وبذلك تتم عملية الدفع \nمن خلال سيريتل',
          Keys.enter.name: ' أدخل',
          Keys.aText.name: ' نصاً  ',
          Keys.general.name: 'عام ',
          Keys.fullName.name: 'الاسم الكامل ',
          Keys.thereIs.name: 'ليس هناك   ',
          Keys.noChatYet.name: 'أي محادثات بعد  ',
          Keys.pressOn.name: 'اضغط على  ',
          Keys.plusIcon.name: 'الر أدناه  ',
          Keys.toStart.name: 'لبدء  ',
          Keys.neweChat.name: 'محادثة جديدة  ',
        },
        'en_US': {
          Keys.password.name: 'Password ',
          Keys.loginTitle.name: 'Log in to your account ',
          Keys.email.name: 'Email ',
          Keys.doNotHaveAccount.name: 'Don\'t have an account? ',
          Keys.registerNow.name: 'Register now ',
          Keys.login.name: 'Log In ',
          Keys.signup.name: 'Sign Up ',
          Keys.alreadyHaveAccount.name: 'Already Have Account? ',
          Keys.signupTitle.name: 'Sign Up to start ',
          Keys.personalInfo.name: 'Personal Info ',
          Keys.personalInfoTitle.name:
              'Before start We would love to have your help ',
          Keys.gender.name: 'Gender: ',
          Keys.diseaseQuestion.name: 'Do you suffer from any diseases? ',
          Keys.goalsQuestion.name: 'Choose your goals ',
          Keys.goodMorning.name: 'Good Morning ',
          Keys.strength.name: 'Strength, ',
          Keys.health.name: 'Health ',
          Keys.andFitness.name: ' And Fitness ',
          Keys.yourGoals.name: 'Your Goals ',
          Keys.next.name: 'Next ',
          Keys.firstName.name: 'First Name ',
          Keys.lastName.name: 'Last Name ',
          Keys.male.name: 'Male ',
          Keys.female.name: 'Female ',
          Keys.birthDate.name: 'Birth Date ',
          Keys.height.name: 'Height ',
          Keys.weight.name: 'Weight ',
          Keys.selectYourDiseases.name: 'Select Your Diseases ',
          Keys.home.name: 'Home ',
          Keys.messages.name: 'Messages ',
          Keys.premium.name: 'Premium ',
          Keys.notification.name: 'Notification ',
          Keys.logOut.name: 'LogOut ',
          Keys.coach.name: 'Coach ',
          Keys.exercies.name: 'Exercies ',
          Keys.thisWeek.name: 'This Week ',
          Keys.send.name: 'Send ',
          Keys.aMessage.name: 'a message ',
          Keys.update.name: 'Update ',
          Keys.yourDiet.name: 'your Diet ',
          Keys.newMeal.name: 'new meal ',
          Keys.alarm.name: 'Alarm ',
          Keys.its.name: 'Its ',
          Keys.time.name: 'time ',
          Keys.to.name: 'to ',
          Keys.add.name: 'Add ',
          Keys.ago.name: 'ago ',
          Keys.min.name: 'Min ',
          Keys.day.name: 'Day ',
          Keys.month.name: 'Month ',
          Keys.justNow.name: 'Just Now ',
          Keys.ksp.name: '25K SP ',
          Keys.onceAndForAll.name: 'Once and for all ',
          Keys.access.name: 'Access ',
          Keys.toAll.name: 'to all ',
          Keys.features.name: 'features ',
          Keys.chat.name: 'Chat ',
          Keys.withAny.name: 'with any ',
          Keys.private.name: 'private ',
          Keys.choose.name: ' Choose ',
          Keys.change.name: ' Change ',
          Keys.your.name: ' your ',
          Keys.upgrade.name: 'Upgrade ',
          Keys.toPremium.name: 'to premium ',
          Keys.content.name:
              'The payment process takes place when you click the button below and the QR code is scanned, thus the payment process is completed through Syriatel',
          Keys.enter.name: 'Enter ',
          Keys.aText.name: 'a text ',
          Keys.general.name: 'General ',
          Keys.fullName.name: 'Full Name  ',
          Keys.thereIs.name: 'There is   ',
          Keys.noChatYet.name: 'no chat yet  ',
          Keys.pressOn.name: 'Press on  ',
          Keys.plusIcon.name: 'plus icon  ',
          Keys.toStart.name: 'to start  ',
          Keys.neweChat.name: 'new chat  ',
        },
      };
}

enum Keys {
  none,
  password,
  loginTitle,
  email,
  doNotHaveAccount,
  registerNow,
  login,
  signup,
  signupTitle,
  goodMorning,
  strength,
  health,
  andFitness,
  yourGoals,
  alreadyHaveAccount,
  personalInfo,
  personalInfoTitle,
  gender,
  diseaseQuestion,
  goalsQuestion,
  next,
  firstName,
  lastName,
  male,
  female,
  birthDate,
  height,
  weight,
  selectYourDiseases,
  home,
  messages,
  premium,
  notification,
  logOut,
  coach,
  exercies,
  thisWeek,
  send,
  aMessage,
  update,
  yourDiet,
  alarm,
  its,
  time,
  to,
  train,
  newMeal,
  add,
  justNow,
  ago,
  day,
  week,
  month,
  min,
  ksp,
  onceAndForAll,
  access,
  toAll,
  features,
  chat,
  withAny,
  private,
  change,
  choose,
  your,
  content,
  upgrade,
  toPremium,
  enter,
  aText,
  general,
  fullName,
  thereIs,
  noChatYet,
  pressOn,
  plusIcon,
  toStart,
  neweChat,
}
