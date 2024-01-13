
 /*
  FireBase
  -firebase.google.com gidilir
  -giriş yaptıktan sonra Go to Console tıklanır
  -add project yeni açamka için açılmışsa oraya tıklanıpta ilerlenebilir.
   -add project tıklanmışsa isim verilir InstaCloneFirebase dedik    -> Continue tıklanır.
  -google analytics ekranında aktif edip Continue tıklıyoruz    .ardından açılan ekranda google analytis hesabı soracaktır yeni açtık ama eskilerinede bağlanabilir. Analytis location için türkiye seçtik  ve I accept the seçtik. Conntinue seçtik . Ardından dashboardına götürüyor
  -sol tarafta kullanılcak  teknolojiler olur
  -Authentication kullanıcıların giriş yaptığı , kayıt olduğu ve .. paralıların olduğu yerdir
  -Firestore Database databasedir
  -Storage görseller ,videolar .pdf dosyaları vs..
  -dashvoarrda sağ üstlerde goto docs dökümanları açılır
  -dashboarddayken iOS butonu var hemen tıklanır
  -Aple Bundle ID sordu onu projede Ana klasör -> signing & Capabilities -> Targetsten seçili -> All -> bundle identifierde yazar com.hasanbilgin.ProjeName gibi
  -1.App nickname verilebilir vermedik biz
  -App Store ID ise app storede yayınlandıysa yazılır yayın yoksa yazılmaz
  -Register App tıklıyoruz
  -2.Download GoogleServices-info.plist tıklanarak isim değiştirmeden indirilir. Bu dosya proje klasörün içinde olmalı zaten resimdede gösteriyor. Dosyayı atarken Copy items if needed aktif edilir ve finish tıklanır
  -Next tıklanır
  -3.2 yöntem ile sdk yüklenmesi lazım biri Cocopods eski yöntemdir ama endüstri çok kullanır. Diğeri ise Swift Package Manager ile yeni yöntemdir.ikiside bilinmesi gerekir. Dökümantasyonları mevcuttur bakılabilir
  -1.Yöntem. olan https://cocoapods.org tan yüklicez siteye gidilir(bazı m2 çiplilerde hata verebiliyor). Yüklemeyi terminalden yüklicez ondan dolayı command+space tuşuna basıp  terminal.app yazıp enterlenir. Açılan pencerede  sudo gem install cocoapods bu kopyalanıp enterlenir -> password ister MacBook giriş şifresidir yazıp(yazılan görülmez) enterlenir. Bizde hata verdi ondan dolayısıyla homebrew.sh google da search atıyoruz. Bubir Mac ve linuxlarda kullandığımız bir paket yöneticisi program yüklerken vs kullanabiliyoruz. Bu programı yüklemek için ana sayfada satırı kopyalayıp terminale yapıştırıp entera basılır.Tekrar şifre ister girilir.entere basılarak devam edin diyo entera bastık .sonunda yükledi. (Yüklenmemesi error vs yazar). Clear diyip temizleriz terminali.Ardından terminalden devam ediyoruz brew install cocoapods yazık enterledik mağlsef bundada brew not found geldi.  neyse çalışırsa pod yazınca + + + - - - çıkarsa tam yüklenmiştir diyebiliriz.(not found derse yine hatalıdır).Devam ediyoruz terminalden pojenin olduğu dizine gitmemiz lazım git ile detaylı anlatımı var es geçiyorum.ve PROJE AÇIKSA KAPATILIR. Termimalde pod init diyerek çalıştıyoruz. Ardından PodFile dosyası oluşçaktır o dosyayı açalım herhangi program ile. içinde # ile başlayan yorum satırıdır. ve use_frameworks! altına gelerek oraya
  pod 'FirebaseAnalytics'
  pod 'FirebaseAuth'
  pod 'FirebaseFirestore'
  pod 'FirebaseStorage'
  yazılcak. Bunlar liste halinde firebase.google.com -> docs-> Fundamentals-> Add Firebase - Apple platforms (İOS+) ile burda hepsi mevcut en alttadır.Ardından dosya kaydedilip kapatılır. Sonra terminale gelip pod install --repo-update yazıp çalıştırılır error çıkmadığı sürece yüklenmiştir diyebiliriz. terminali kapatabiliriz. projeyi açabiliriz fakat ProjeName.xcodeproj yerine ProjeName.xcworkspace ile çift tıklanarak açılcak..  Biz 2.yöntemle girdik 1. çalışmadı
  -2.Yöntem. olan Swift Package Manager ile Firebase yükleme
 -projede iken en üst çubuktan File-> Add Package Dependencies... -> Aslında bu internetteki dosyaları alıp buraya koymamıza yarıyor. Github taki firebase linki kopyalanıp  add package  .. de  ile pencereye sağ üstte search kısmına yapıştırılır Bulunan firebase-ios-sdk (ismi değişebilir) seçip Add Package tıklanır. Yükleme bittikten sonra sorucaktır hangiler yüklensin diye. Hepsi eklensede sonradan kaldırılabilir tabi yer kaplıcağı için hepsini yüklemek iyi değil. hepsi seçilebilir olmadığındna tümünü ardından Add Package dedik tümü yüklendi. istemediğiz dosyaları çıkarmak için ana klasöre sol tıklayıp -> Build Phases -> Targeststen seçili -> Link Binary With Libraries te hesi çıkıcaktır istemediğmiz seçip eksiye basılmı yeterlidir. bu birden fazla eklendiyse çıkartılabilir bunuda bilmek lazım.Bide AppDelegate.swift de en yukarıda import Firebase ekleyip application fonksiyonuna return yapmadan önce FirebaseApp.configure() yapmak yeterlidir.
  firebase siteisne gelip next tıklanır
  4.Swift seçiyoruz nexyt diyoruz (firebase configre işlemi bir önceki yapıldı)
  5.continues to console tıklabiliriz biter

 
 */

//AppDAlagate.swift ise app çalışırken ilk baş çalışır en başta firebase configre etmiş olduk aslında

//kullanıcı kayıt için başlatmak gerekir bir kez yapmak yeterlidir console.firebase.com.. sitesine gelip olan dasboard açılıp solda Build-> Authentication seçilip get Started -> Açılan ekranda Sign-in method geçilir Add New Provider seçilir Email/Password seçilir En sağ üstte pasif olanı aktif edilir ve Save tıklanır
/*
 Tab Bar Controller (en altta çok butonlu controller)
 - + storyboardda + basılıp yazıldıktan sonra getirtilebilir
 
 -tab bar controller açılan ekranlar için butonalra isim vermek istersek yada resişm vs. o ekranın butonuna (item1) -> Bar Item -> Titleden verilir imageden resimde koyulabilir
 
-eğer Tab Bar Controller e bir ekran eklemek istersek Relations Sqgue olucaktır(View Controllers) eklenmelidir zaten diğer oklarında bilgisi yazar
 */
 
/*
 segue çeşitleri
 
 Kind-> Present As Popover üstten kapanan ekranlardır
 Kind-> Presen Modaly -> Presentation ->  Full Screen tam ekranda herşey açılır istediğimiz
 */
 
import UIKit
import Firebase
 
class ViewController: UIViewController {
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func signInClicked(_ sender: Any) {
        
        if emailText.text != "" && passwordText.text != "" {
            
            Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!) { authdata, error in
                if error != nil {
                    
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                }else{
                  
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        }else{
            makeAlert(titleInput: "Error", messageInput: "Username/Password")
        }
    }
    
    @IBAction func signUpClicked(_ sender: Any) {
        if emailText.text != "" && passwordText.text != "" {
            //kayıt için callbacklidir enter diyip autdata ve error girdik
            Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) { authdata, error in
                if error != nil {
                    // error?.localizedDescription kullanıcıya anlayabilceği hata bilgisidir
                    //error?.localizedDescription ?? "Error" burda hata gelmezzse Error yazdırıcak
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                }else{
                    //tab bar controller açılmış oldu
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        }else{
            makeAlert(titleInput: "Error", messageInput: "Username/Password")
        }
    }
    
    func makeAlert( titleInput : String, messageInput : String){
        let alert = UIAlertController(title: titleInput, message:messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}
