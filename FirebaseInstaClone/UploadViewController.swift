//
//  UploadViewController.swift
//  FirebaseInstaClone
//
//  Created by hasan bilgin on 4.10.2023.
//

import UIKit
//eklendi
import FirebaseStorage
import Firebase

class UploadViewController: UIViewController ,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var commentText: UITextField!
    @IBOutlet weak var uploadButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //image view tıklanabilir yapma
        imageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        imageView.addGestureRecognizer(gestureRecognizer)
        
    }
    
    //image view tıklandığında yapılcaklar
    @objc func chooseImage(){
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController,animated: true)
    }
    
    //seçildikten sonra
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true)
    }
    
    func makeAlert( titleInput : String, messageInput : String){
        let alert = UIAlertController(title: titleInput, message:messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    

    @IBAction func uploadClicked(_ sender: Any) {
        //resim kayıt için firabase sitesine gidip proje seçilip dashboarddan Storage seçilir -> get Starteed tıklanır -> Start in test Mode seçip  (burada securit kuralları vardır) next tıklanır -> sonraki aşamada appin hangi locasyonda tutmak istersin tabi nerde iş yapıyorsan yakında olması daha iyi olur biz amerika yani nam5 (us-central) seçtik bu arada bu seçim sonradan değiştirilmiyor. Açılan ekranda Create Folder diyip klasör oluşturabiliri manuel olmuş olur yani ama kod ilede yapabiliriz
        
        //resim kayıt için
        let storage = Storage.storage()
        //Ana klasör belirtiyoruz
        let storageReferance = storage.reference()
        
        //storageReferance.child("images") bu şekilde alt klasörüne gitmiş olucaz
        //klasör olmasa bile kendisi oluşturur
        //storageReferance.child("images").chil.... devam edilebilir içine içine....
        let madiaFolder = storageReferance.child("media")
        
        //imageView bir veriye çevirmemiz gerekir
        //compressionQuality sıkıştırma oranıdır 0.5 dersek % 50 sıkıştırmış oluruz
        if let data = imageView.image?.jpegData(compressionQuality: 0.5){
            
            let uuid = UUID().uuidString
            let imageReferance = madiaFolder.child("\(uuid).jpg")
            //resim içeri kayıt edilmesi
            imageReferance.putData(data,metadata: nil) { metadata, error in
                if error != nil {
                    self.makeAlert(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Error")
                } else {
                    //resim url almak için
                    imageReferance.downloadURL { url, error in
                        if error == nil {
                            let imageUrl = url?.absoluteString
                         
                            //databasee kayıt etmek için firebase gidip projeyi seçip dashboarddan build -> Firestore Database tıklayıp -> Create Database diyip -> açılan ekranda start in test mode(security kuralları sonradan değiştirebilir) tıklayıp next demek-> yine databasein tuutlcağı lokasyon soruyor amerika nam5 (us-central) diyip enable dedik. database ooluştuurldu Direk Data Rules İndexes ve usage sekmeleri açıldıysa sorun yok ama farklı açıldıysa kapat sekmeyi tamamen direk o dashboard ekranına gelceksin sonra  Go to google could console  tıkla -> defaulta tıkla -> Swift to Native Mode tıkla düzelcek onay iticek vs onaylarsın kapa en sonda aynı dashboarddan FireStore Database kurallar sınıflar vs gelicektir. database burda collectionlar ve documentler var sınıf ve kayıt diye düşünebiliriz tek farkı kayıta sınıfta eklenebiliyo ama hiç kullanmadık
                            
                            let firestoreDatabase = Firestore.firestore()
                            
                            //kayıt yapılcak yeri için
                            var firestoreReferance : DocumentReference? = nil
                            
                            //FieldValue.serverTimestamp(), anlık zaman gönderildi
                            //verileri böle aldık
                            let firestorePost = ["imageUrl" : imageUrl!, "postedBy" : Auth.auth().currentUser!.email!,"postComment" : self.commentText.text!, "date" : FieldValue.serverTimestamp(), "likes" : 0] as [String : Any]
                            //Post collection yoksa oluşturucak varsa üstüne yazıcak tabi documentleri silmeden....
                            firestoreReferance = firestoreDatabase.collection("Posts").addDocument(data: firestorePost, completion: { error in
                                if error != nil {
                                    self.makeAlert(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Error")
                                }else{
                                    self.clearView()
                                    //olan tabBarContorlllerin 0. yani ilk sayfasını açar
                                    self.tabBarController?.selectedIndex = 0
                                    
                                }
                            })
                            
                            //datarulesten şöle yaptık allow read, write;(son satır)
                            //Firestore Database güvenliği için yukardaki kod herzaman açıktır daha güvenliği hale gerirmke için webde olan yerinde learn more tıklarsanız  hemen  dökümantasyon vardır
                            //allow read, write: if request.auth != null; getirdik webten ardından publish tıkladık kaydetti
                            
                        }
                    }
                }
            }
        }
    
    }
    
    func clearView(){
        self.imageView.image = UIImage(named: "selectImage.jpg")
        self.commentText.text = "";
        
    }
    

    
}
