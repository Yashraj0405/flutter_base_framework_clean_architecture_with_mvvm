import 'package:get/get.dart';

class LocalStrings extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        "en_US": {
          "signIn": "Sign In",
          "signUp": "Sign Up",
          "alreadyHaveAnAccount": "Already have an account?",
          "signInWithEmail&Password": "Sign In with Email and Password",
          "signInWithOTP": "Sign In with OTP",
          "getOTP": "Get OTP",
          "don'tHaveAnAccount": "Don't have an account?",
          "forgotPassword": "Forgot Password?",
          "verifyEmail": "Verify Email",
          "verifyAccount": "Verify Account",
          "enterOTP": "Enter OTP",
          "validateOTP": "Validate OTP",
          "enterNewPassword": "Enter New Password",
          "submit": "Submit",
          "pleaseEnter4DigitCode":
              "Please Enter 4 digit Code sent to your registerd mobile number",
          "resendCodeAfter": "Resend Code after",
          "resend": "Resend",
          "validate": "Validate",
          "emailVerification": "Email Verification",
          "contactVerification": "Contact Verification",
          "enterEmailAddressForOTPVerification":
              "Enter Email Address for OTP Verification",
          "enterContactNumberForOTPVerification":
              "Enter Contact number for OTP Verification",
          "registerUsingEmailAddress": "Register Using Email Address",
          "registerUsingContactNumber": "Register Using Contact Number",
          "createAccount": "Create Account",
          "email": "Email",
          "enterRegisteredEmailId": "Enter Registered Email Id",
          "password": "Password",
          "enterPassword": "Enter Password",
          "contactNo": "Contact No.",
          "enterContactNo": "Enter Contact No",

          "firstName": "First Name",
          "enterFirstName": "Enter First Name",
          "lastName": "Last Name",
          "enterLastName": "Enter Last Name",
          "newPassword": "New Password",
          "confirmNewPassword": "Confirm New Password",
          "pleaseEnterAnEmailAddress": "Please enter an email address",
          "pleaseEnteraValidEmailAddressWithLowercaseFirstLetter":
              "Please enter a valid email address with lowercase first letter",

          "pleaseEnteraFirstName": "Please enter a first name",
          "firstNameMustBeAtLeast3CharactersLong":
              "First name must be at least 3 characters long",
          "firstNameShouldStartWithaCapitalLetter":
              "First name should start with a capital letter",

          "pleaseEnteraLastName": "Please enter a last name",
          "lastNameMustBeAtLeast3CharactersLong":
              "Last name must be at least 3 characters long",
          "LastNameShouldStartWithaCapitalLetter":
              "Last name should start with a capital letter",

          "pleaseEnteraPassword": "Please enter a password",
          "passwordMustBeAtLeast6CharactersLong":
              "Password must be at least 6 characters long",

          "pleaseEnteraContactNumber": "Please enter a contact number",
          "pleaseEnteraValid10-digitContactNumber":
              "Please enter a valid 10-digit contact number",

          "pleaseEnterOTPNumber": "Please enter  OTP number",
          "pleaseEntera4-digitOTPNumber": "Please enter a 4-digit OTP number",

          //passwordRequirements
          "passwordRequirements": """
Password must use a combination of these:
I.At least 1 upper case letters (A-Z)
II.Lower case letters (a-z)
III.At least 1 number (0-9)
IV.At least 1 non-alphanumeric symbol (e.g. @'%*!')
""",
        },
        'hi_IN': {
          "signIn": "दाखिल करना",
          "signUp": "साइन अप करें",
          "alreadyHaveAnAccount": "क्या आपके पास पहले से कोई खाता है?",
          "signInWithEmail&Password": "ईमेल और पासवर्ड से साइन इन करें",
          "signInWithOTP": "ओटीपी के साथ साइन इन करें",
          "getOTP": "ओटीपी प्राप्त करें",
          "don'tHaveAnAccount": "कोई खाता नहीं है?",
          "forgotPassword": "पासवर्ड भूल गए?",
          "verifyEmail": "ईमेल सत्यापित करें",
          "verifyAccount": "खाता सत्यापित करें",
          "enterOTP": "ओटीपी दर्ज करें",
          "validateOTP": "ओटीपी मान्य करें",

          "submit": "जमा करना",
          "pleaseEnter4DigitCode":
              "कृपया आपके पंजीकृत मोबाइल नंबर पर भेजा गया 4 अंकों का कोड दर्ज करें",
          "resendCodeAfter": "इसके बाद कोड दोबारा भेजें",
          "resend": "पुन भेजें",
          "validate": "मान्य",
          "emailVerification": "ईमेल सत्यापन",
          "contactVerification": "संपर्क सत्यापन",
          "enterEmailAddressForOTPVerification":
              "ओटीपी सत्यापन के लिए ईमेल पता दर्ज करें",
          "enterContactNumberForOTPVerification":
              "ओटीपी सत्यापन के लिए संपर्क नंबर दर्ज करें",
          "registerUsingEmailAddress": "ईमेल पते का उपयोग करके पंजीकरण करें",
          "registerUsingContactNumber":
              "संपर्क नंबर का उपयोग करके पंजीकरण करें",
          "createAccount": "खाता बनाएं",
          "email": "ईमेल",
          "enterRegisteredEmailId": "पंजीकृत ईमेल आईडी दर्ज करें",
          "password": "पासवर्ड",
          "enterPassword": "पास वर्ड दर्ज करें",
          "contactNo": "संपर्क नंबर।",
          "enterContactNo": "संपर्क नंबर दर्ज करें",

          "enterNewPassword": "नया पासवर्ड दर्ज करें",
          "newPassword": "नया पासवर्ड",
          "confirmNewPassword": "नए पासवर्ड की पुष्टि करें",

          "firstName": "पहला नाम",
          "enterFirstName": "प्रथम नाम दर्ज करें",
          "lastName": "उपनाम",
          "enterLastName": "अंतिम नाम दर्ज करो",

          //Validatione
          "pleaseEnterAnEmailAddress": "कृपया एक ईमेल पता दें",
          "pleaseEnteraValidEmailAddressWithLowercaseFirstLetter":
              "कृपया पहले अक्षर के छोटे अक्षर के साथ एक वैध ईमेल पता दर्ज करें",

          "pleaseEnteraFirstName": "कृपया पहला नाम दर्ज करें",
          "firstNameMustBeAtLeast3CharactersLong":
              "पहला नाम कम से कम 3 अक्षर लंबा होना चाहिए",
          "firstNameShouldStartWithaCapitalLetter":
              "पहला नाम बड़े अक्षर से शुरू होना चाहिए",

          "pleaseEnteraLastName": "कृपया एक अंतिम नाम दर्ज करें",
          "lastNameMustBeAtLeast3CharactersLong":
              "अंतिम नाम कम से कम 3 अक्षर लंबा होना चाहिए",
          "LastNameShouldStartWithaCapitalLetter":
              "अंतिम नाम बड़े अक्षर से शुरू होना चाहिए",

          "pleaseEnteraPassword": "कृपया पासवर्ड दर्ज करें",
          "passwordMustBeAtLeast6CharactersLong":
              "पासवर्ड कम से कम 6 अक्षरों का होना चाहिए",

          "pleaseEnteraContactNumber": "कृपया एक संपर्क नंबर दर्ज करें",
          "pleaseEnteraValid10-digitContactNumber":
              "कृपया एक वैध 10-अंकीय संपर्क नंबर दर्ज करें",

          "pleaseEnterOTPNumber": "कृपया ओटीपी नंबर दर्ज करें",
          "pleaseEntera4-digitOTPNumber":
              "कृपया 4 अंकों का ओटीपी नंबर ओटीपी नंबर दर्ज करेंr",
          //passwordRequirements
          "passwordRequirements": """
पासवर्ड को इनमें से एक संयोजन का उपयोग करना चाहिए:
I. कम से कम 1 अपरकेस अक्षर (A-Z)
II.लोअर केस अक्षर (a-z)
III.कम से कम 1 नंबर (0-9)
IV.कम से कम 1 गैर-अल्फ़ान्यूमेरिक प्रतीक (जैसे @'%*!')
""",
        },
        'kn_IN': {
          "signIn": "ಸೈನ್ ಇನ್ ಮಾಡಿ",
          "signUp": "ಸೈನ್ ಅಪ್ ಮಾಡಿ",
          "alreadyHaveAnAccount": "ಈಗಾಗಲೇ ಖಾತೆ ಹೊಂದಿದ್ದೀರ?",
          "signInWithEmail&Password":
              "ಇಮೇಲ್ ಮತ್ತು ಪಾಸ್ವರ್ಡ್ನೊಂದಿಗೆ ಸೈನ್ ಇನ್ ಮಾಡಿ",
          "signInWithOTP": "OTP ಯೊಂದಿಗೆ ಸೈನ್ ಇನ್ ಮಾಡಿ",
          "getOTP": "OTP ಪಡೆಯಿರಿ",
          "don'tHaveAnAccount": "ಖಾತೆ ಇಲ್ಲವೇ?",
          "forgotPassword": "ಪಾಸ್ವರ್ಡ್ ಮರೆತಿರಾ?",
          "verifyEmail": "ಇಮೇಲ್ ಪರಿಶೀಲಿಸಿ",
          "verifyAccount": "ಖಾತೆಯನ್ನು ಪರಿಶೀಲಿಸಿ",
          "enterOTP": "OTP ನಮೂದಿಸಿ",
          "validateOTP": "OTP ಮೌಲ್ಯೀಕರಿಸಿ",
          "enterNewPassword": "ಹೊಸ ಗುಪ್ತಪದವನ್ನು ನಮೂದಿಸಿ",
          "submit": "ಸಲ್ಲಿಸು",
          "pleaseEnter4DigitCode":
              "ದಯವಿಟ್ಟು ನಿಮ್ಮ ನೋಂದಾಯಿತ ಮೊಬೈಲ್ ಸಂಖ್ಯೆಗೆ ಕಳುಹಿಸಲಾದ 4 ಅಂಕಿಯ ಕೋಡ್ ಅನ್ನು ನಮೂದಿಸಿ",
          "resendCodeAfter": "ನಂತರ ಕೋಡ್ ಅನ್ನು ಮರುಕಳುಹಿಸಿ",
          "resend": "ಮರುಕಳುಹಿಸಿ",
          "validate": "ಮೌಲ್ಯೀಕರಿಸಿ",
          "emailVerification": "ಇಮೇಲ್ ಪರಿಶೀಲನೆ",
          "contactVerification": "ಸಂಪರ್ಕ ಪರಿಶೀಲನೆ",
          "enterEmailAddressForOTPVerification":
              "OTP ಪರಿಶೀಲನೆಗಾಗಿ ಇಮೇಲ್ ವಿಳಾಸವನ್ನು ನಮೂದಿಸಿ",
          "enterContactNumberForOTPVerification":
              "OTP ಪರಿಶೀಲನೆಗಾಗಿ ಸಂಪರ್ಕ ಸಂಖ್ಯೆಯನ್ನು ನಮೂದಿಸಿ",
          "registerUsingEmailAddress": "ಇಮೇಲ್ ವಿಳಾಸವನ್ನು ಬಳಸಿ ನೋಂದಾಯಿಸಿ",
          "registerUsingContactNumber": "ಸಂಪರ್ಕ ಸಂಖ್ಯೆಯನ್ನು ಬಳಸಿ ನೋಂದಾಯಿಸಿ",
          "createAccount": "ಖಾತೆ ತೆರೆ",
          "email": "ಇಮೇಲ್",
          "enterRegisteredEmailId": "ನೋಂದಾಯಿತ ಇಮೇಲ್ ಐಡಿಯನ್ನು ನಮೂದಿಸಿ",
          "password": "ಗುಪ್ತಪದ",
          "enterPassword": "ಪಾಸ್ವರ್ಡ್ ನಮೂದಿಸಿ",
          "contactNo": "ಸಂಪರ್ಕ ಸಂಖ್ಯೆ",
          "enterContactNo": "ಸಂಪರ್ಕ ಸಂಖ್ಯೆ ನಮೂದಿಸಿ",

          "firstName": "ಮೊದಲ ಹೆಸರು",
          "enterFirstName": "ಮೊದಲ ಹೆಸರನ್ನು ನಮೂದಿಸಿ",
          "lastName": "ಕೊನೆಯ ಹೆಸರು",
          "enterLastName": "ಕೊನೆಯ ಹೆಸರನ್ನು ನಮೂದಿಸಿ",
          "newPassword": "ಹೊಸ ಪಾಸ್ವರ್ಡ್",
          "confirmNewPassword": "ಹೊಸ ಗುಪ್ತಪದವನ್ನು ಖಚಿತಪಡಿಸಿ",
          //Validatione
          "pleaseEnterAnEmailAddress": "ದಯವಿಟ್ಟು ಇಮೇಲ್ ವಿಳಾಸವನ್ನು ನಮೂದಿಸಿ",
          "pleaseEnteraValidEmailAddressWithLowercaseFirstLetter":
              "ದಯವಿಟ್ಟು ಮೊದಲ ಅಕ್ಷರದೊಂದಿಗೆ ಮಾನ್ಯವಾದ ಇಮೇಲ್ ವಿಳಾಸವನ್ನು ನಮೂದಿಸಿ",

          "pleaseEnteraFirstName": "ದಯವಿಟ್ಟು ಮೊದಲ ಹೆಸರನ್ನು ನಮೂದಿಸಿ",
          "firstNameMustBeAtLeast3CharactersLong":
              "ಮೊದಲ ಹೆಸರು ಕನಿಷ್ಠ 3 ಅಕ್ಷರಗಳನ್ನು ಹೊಂದಿರಬೇಕು",
          "firstNameShouldStartWithaCapitalLetter":
              "ಮೊದಲ ಹೆಸರು ದೊಡ್ಡ ಅಕ್ಷರದಿಂದ ಪ್ರಾರಂಭವಾಗಬೇಕು",

          "pleaseEnteraLastName": "ದಯವಿಟ್ಟು ಕೊನೆಯ ಹೆಸರನ್ನು ನಮೂದಿಸಿ",
          "lastNameMustBeAtLeast3CharactersLong":
              "ಕೊನೆಯ ಹೆಸರು ಕನಿಷ್ಠ 3 ಅಕ್ಷರಗಳನ್ನು ಹೊಂದಿರಬೇಕು",
          "LastNameShouldStartWithaCapitalLetter":
              "ಕೊನೆಯ ಹೆಸರು ದೊಡ್ಡ ಅಕ್ಷರದಿಂದ ಪ್ರಾರಂಭವಾಗಬೇಕು",

          "pleaseEnteraPassword": "ದಯವಿಟ್ಟು ಪಾಸ್‌ವರ್ಡ್ ನಮೂದಿಸಿ",
          "passwordMustBeAtLeast6CharactersLong":
              "ಪಾಸ್ವರ್ಡ್ ಕನಿಷ್ಠ 6 ಅಕ್ಷರಗಳ ಉದ್ದವಿರಬೇಕು",

          "pleaseEnteraContactNumber": "ದಯವಿಟ್ಟು ಸಂಪರ್ಕ ಸಂಖ್ಯೆಯನ್ನು ನಮೂದಿಸಿ",
          "pleaseEnteraValid10-digitContactNumber":
              "कृपया एक वैध 10-अंकीय संपर्क नंबर दर्ज करें",

          "pleaseEnterOTPNumber": "ದಯವಿಟ್ಟು OTP ಸಂಖ್ಯೆಯನ್ನು ನಮೂದಿಸಿ",
          "pleaseEntera4-digitOTPNumber":
              "ದಯವಿಟ್ಟು 4-ಅಂಕಿಯ OTP ಸಂಖ್ಯೆ OTP ಸಂಖ್ಯೆಯನ್ನು ನಮೂದಿಸಿ",

          //passwordRequirements
          "passwordRequirements": """
ಪಾಸ್ವರ್ಡ್ ಇವುಗಳ ಸಂಯೋಜನೆಯನ್ನು ಬಳಸಬೇಕು:
I. ಕನಿಷ್ಠ 1 ದೊಡ್ಡ ಅಕ್ಷರಗಳು (A-Z)
II. ಲೋವರ್ ಕೇಸ್ ಅಕ್ಷರಗಳು (a-z)
III.ಕನಿಷ್ಠ 1 ಸಂಖ್ಯೆ (0-9)
IV.ಕನಿಷ್ಠ 1 ಆಲ್ಫಾನ್ಯೂಮರಿಕ್ ಅಲ್ಲದ ಚಿಹ್ನೆ (ಉದಾ. @'%*!')
""",
        },
        'mr_IN': {
          "signIn": "साइन इन करा",
          "signUp": "साइन अप करा",
          "alreadyHaveAnAccount": "आधीपासूनच एक खाते आहे?",
          "signInWithEmail&Password": "ईमेल आणि पासवर्डसह साइन इन करा",
          "signInWithOTP": "OTP सह साइन इन करा",
          "getOTP": "OTP मिळवा",
          "don'tHaveAnAccount": "खाते नाही?",
          "forgotPassword": "पासवर्ड विसरलात?",
          "verifyEmail": "ईमेल सत्यापित करा",
          "verifyAccount": "खाते सत्यापित करा",
          "enterOTP": "OTP एंटर करा",
          "validateOTP": "OTP सत्यापित करा",
          "enterNewPassword": "नवीन पासवर्ड टाका",
          "submit": "प्रस्तुत करणे",
          "pleaseEnter4DigitCode":
              "कृपया तुमच्या नोंदणीकृत मोबाईल नंबरवर पाठवलेला 4 अंकी कोड एंटर करा",
          "resendCodeAfter": "नंतर कोड पुन्हा पाठवा",
          "resend": "पुन्हा पाठवा",
          "validate": "प्रमाणित करा",
          "emailVerification": "ई - मेल पडताळणी",
          "contactVerification": "संपर्क सत्यापन",
          "enterEmailAddressForOTPVerification":
              "OTP सत्यापनासाठी ईमेल पत्ता प्रविष्ट करा",
          "enterContactNumberForOTPVerification":
              "OTP पडताळणीसाठी संपर्क क्रमांक प्रविष्ट करा",
          "registerUsingEmailAddress": "ईमेल पत्ता वापरून नोंदणी करा",
          "registerUsingContactNumber": "संपर्क क्रमांक वापरून नोंदणी करा",
          "createAccount": "खाते तयार करा",
          "email": "ईमेल",
          "enterRegisteredEmailId": "नोंदणीकृत ईमेल आयडी प्रविष्ट करा",
          "password": "पासवर्ड",
          "enterPassword": "पासवर्ड टाका",
          "contactNo": "संपर्क क्र.",
          "enterContactNo": "संपर्क क्रमांक प्रविष्ट करा",

          "firstName": "पहिले नाव",
          "enterFirstName": "प्रथम नाव प्रविष्ट करा",
          "lastName": "आडनाव",
          "enterLastName": "आडनाव एंटर करा",
          "newPassword": "नवीन पासवर्ड",
          "confirmNewPassword": "नवीन परवलीच्या शब्दाची खात्री करा",
          //Validatione
          "pleaseEnterAnEmailAddress": "कृपया ईमेल पत्ता प्रविष्ट करा",
          "pleaseEnteraValidEmailAddressWithLowercaseFirstLetter":
              "कृपया लोअरकेस पहिल्या अक्षरासह वैध ईमेल पत्ता प्रविष्ट करा",

          "pleaseEnteraFirstName": "कृपया नाव प्रविष्ट करा",
          "firstNameMustBeAtLeast3CharactersLong":
              "प्रथम नाव किमान 3 वर्ण लांब असणे आवश्यक आहे",
          "firstNameShouldStartWithaCapitalLetter":
              "प्रथम नाव मोठ्या अक्षराने सुरू झाले पाहिजे",

          "pleaseEnteraLastName": "कृपया आडनाव प्रविष्ट करा",
          "lastNameMustBeAtLeast3CharactersLong":
              "आडनाव किमान 3 वर्ण लांब असणे आवश्यक आहे",
          "LastNameShouldStartWithaCapitalLetter":
              "आडनाव मोठ्या अक्षराने सुरू झाले पाहिजे",

          "pleaseEnteraPassword": "कृपया पासवर्ड टाका",
          "passwordMustBeAtLeast6CharactersLong":
              "पासवर्ड किमान ६ वर्णांचा असणे आवश्यक आहे",

          "pleaseEnteraContactNumber": "कृपया संपर्क क्रमांक प्रविष्ट करा",
          "pleaseEnteraValid10-digitContactNumber":
              "कृपया वैध 10-अंकी संपर्क क्रमांक प्रविष्ट करा",

          "pleaseEnterOTPNumber": "कृपया OTP क्रमांक टाका",
          "pleaseEntera4-digitOTPNumber":
              "कृपया 4-अंकी OTP क्रमांक OTP क्रमांक प्रविष्ट करा",

          //passwordRequirements
          "passwordRequirements": """
पासवर्डने यापैकी एक संयोजन वापरणे आवश्यक आहे:
I. किमान 1 अप्पर केस अक्षरे (A-Z)
II.लोअर केस अक्षरे (a-z)
III.किमान 1 संख्या (0-9)
IV. किमान 1 नॉन-अल्फान्यूमेरिक चिन्ह (उदा. @'%*!')
""",
        }
      };
}
