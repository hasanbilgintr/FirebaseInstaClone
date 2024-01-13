//
//  FeedCell.swift
//  FirebaseInstaClone
//
//  Created by hasan bilgin on 5.10.2023.
//

import UIKit
import Firebase

class FeedCell: UITableViewCell {
    
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var documentIDLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func likeClicked(_ sender: Any) {
        
        let fireStoreDatabase = Firestore.firestore()
        
        if let likeCount = Int(likeLabel.text!){
            let likeStore = ["likes" : likeCount + 1] as [String : Any]
            
            //merge burda verdiğim parametre güncelle diğer alanlaara dokunma kasteder
            fireStoreDatabase.collection("Posts").document(documentIDLabel.text!).setData(likeStore, merge: true) { error in
                if error != nil {
                    print(error?.localizedDescription)
                }
            }
        }
        //burda aslında sadece güncelliyor tavleview güncellendiği sürece yenilendiği için oradanda yenileniyor
    }
}
