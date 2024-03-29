import 'dart:ui';
// flutter run --enable-software-rendering
const image_link = "http://pabrik.lelenesia.panen-panen.com/";
// logintext
const String titleLoginText = "Pembudidaya";
const String subTitleLoginText =
    "Dapatkan ikan segar yang berkualitas dengan harga yang lebih murah di PanenIkan!";
const String lupaKataSandiText = "Lupa kata sandi?";
const String buttonLoginText = "MASUK";
const String changeButtonText = "  atau masuk dengan  ";
const String buttonGoogleText = "Google";

// DaftarString
// const String titleDaftarText = "Buat Akun";
const String titleDaftarText = "Pembudidaya";
const String subTitleDaftarText ="Buat ikan anda menjadi lebih segar dan sedap bersama kami Panen-panen !";
// const String subTitleDaftarText =
//     "Dapatkan lebih banyak pelanggan tetap dengan bergabung bersama ekosistem kami";
const String buttonDaftarText = "Buat Akun";
const String oneDaftarText = "Dengan membuat akun berarti anda setuju dengan";
const String twoDaftarText = " syarat dan ketentuan";
const String threeDaftarText = " kebijakan privasi";
const String danDaftarText = " dan ";
const String bottomOneText = "Sudah mempunyai akun ? ";
const String bottomTwoText = "Masuk";
const String passwordValidasiText =
    "Kombinasi huruf kapital, huruf kecil dan angka";
const String passwordValidasiTextTwo = "Minimal 8 Karakter";
const String rePasswordValidasiText = "Password yang ada masukkan harus sama";

// forgotpassowrd
const String appBarForgotPassword = "Lupa Sandi";
const String titleForgotPassword = "No Pemulihan";
const String buttonTextForgotPassword = "Reset Password";
const String titleVerifForgotPassword = "Periksa Pesan anda";
const String subTitleVerifForgotPassword =
    "kode verif sudah terkirim ke +6209188212922 masukkan kode tersebut ke dalam form dibawah ini";
const String titleResetForgotPassword = "Reset kata sandi anda";

// laporanhome
const String laporanhometextnull =
    "ups maaf , anda harus mengisi penentuan panen agar dapat melihat fitur ini";

//otptext
const String appBarOtp = "Kode OTP";
const String titleVerifOtp = "Periksa Sms anda";

//firstviewdashboard
const String textNullFirst = "Anda  punya berapa kolam ? ";
const String subTextNullFirst = "Daftarkan kolam anda sendiri untuk menjadi pemasok tetap pakan bangsa indonesia";

var string_bulan = [
  '',
  'Januari',
  'Februari',
  'Maret',
  'April',
  'Mei',
  'Juni',
  "Juli",
  "Agustus",
  "September",
  "Oktober",
  "November",
  "Desember"
];

int tryCoba(String data) {
  try {
    return int.parse(data);
  } catch (_) {
    return -1;
  }
}