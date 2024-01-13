
/*
 tableView satırlarını özellştiricez
 storyboardda tablViewe sol tıklarız sağ tarafta show the Attributes Inspertor alanında Prototype Cell 0 olarak gelir 1 yaparsak tableView hemen üstünde alan oluşur adı Prototype Cells olur solda ise table View Cell dir bu alanı büyültebiliriz tutamazsak soldan tutabiliriz ve soldan table View Cell seçip sağda show the Attributes Inspertor alanından identifier alanına ulaşmak için isim verdik cell gibi
 
 table view celllerin kendi swift dosyaları oluyor çünkü proje klasörünü seçip sağ seçip-> new File...-> Cocoa Touch Class seçilip next tıklanır -> Class alanına isim verilir ,Subclass of ise UITableViewCell(bura miras alıncak yer aslında) diye girdik-> next dedik -> target seçili lazım create denir. Açılan Swift dosyası table View e bağlamak için soldan eski adıyla table View Cell yenisi yani İdentifiere yazılı adla çıkar seçip yine en sağda show the identity inspector alanından Class yerine o Swift dosyası girilir enterlenir. açılan o alandakiler yeni açılan swifte hepsi tanımlanabilir
 */

import UIKit
import Firebase
import SDWebImage

class FeedViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    
    
    @IBOutlet weak var tableView: UITableView!
    var userEmailArray = [String]()
    var userCommentArray = [String]()
    var likeArray = [Int]()
    var userImageArray = [String]()
    //tıklanınlan like için hangi documentid
    var documentIDArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        getDataFromFirestore()
    }
    
    func getDataFromFirestore(){
        let fireStoreDatabase = Firestore.firestore()
        
        //collection("Posts").document("12314").collection("sdfdsf")... gidilebilirde sorun yok
        //her güncelleme yapıldığında otomatik liste yenilenir
        //liste sıralaması için
        //addSnapshotListener demeden önce  .order(by : "date",descending: true) tarihe göre azalarak çekicektir, "date" burda keydir
        
        fireStoreDatabase.collection("Posts").order(by: "date", descending: true).addSnapshotListener { snapshot, error in
            if error != nil {
                print(error?.localizedDescription)
            }else{
                if snapshot?.isEmpty != true && snapshot != nil {
                    
                    //dizileri temizleyelimki liste yenilensin
                    self.userEmailArray.removeAll()
                    self.userCommentArray.removeAll()
                    self.userImageArray.removeAll()
                    self.likeArray.removeAll()
                    self.documentIDArray.removeAll()
                    
                    for document in snapshot!.documents {
                        let documentID = document.documentID
                        self.documentIDArray.append(documentID)
                        
                        if let postedBy = document.get("postedBy") as? String{
                            self.userEmailArray.append(postedBy)
                        }
                        
                        if let postComment = document.get("postComment") as? String{
                            self.userCommentArray.append(postComment)
                        }
                        if let likes = document.get("likes") as? Int{
                            self.likeArray.append(likes)
                        }
                        if let imageUrl = document.get("imageUrl") as? String{
                            self.userImageArray.append(imageUrl)
                        }
                    }
                    //yenilencek
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    //tableView sayısı
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userEmailArray.count
    }
    
    //satırları gösertmek verileriyle
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Cell diyerek özelleştirilmiş satırı aldık
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
        cell.userEmailLabel.text = userEmailArray[indexPath.row]
        cell.commentLabel.text = userCommentArray[indexPath.row]
        cell.likeLabel.text = String(likeArray[indexPath.row])
        //SDWebImage için
        //documentasyon https://github.com/SDWebImage/SDWebImage
        //File -> Swift Packages -> Add Package Dependency -> DWebImage  <ratın bulunanı ekleyin.  hepsi seçilebilir olmadığındna tümünü ardından Add Package dedik tümü yüklendi. istemediğiz dosyaları çıkarmak için ana klasöre sol tıklayıp -> Build Phases -> Targeststen seçili -> Link Binary With Libraries te hesi çıkıcaktır istemediğmiz seçip eksiye basılmı yeterlidir. bu birden fazla eklendiyse çıkartılabilir.(2sinide yükledik biz)
        //tabi cocoapods ilede yüklenebilir dökümantasyonda yer alıyo
        //cell.userImageView.image = UIImage(named: "selectImage.jpg")
        cell.userImageView.sd_setImage(with: URL(string: self.userImageArray[indexPath.row]), placeholderImage: UIImage(named: "selectImage.jpg"))
        cell.documentIDLabel.text=documentIDArray[indexPath.row]
        return cell
        
    }
    
}
