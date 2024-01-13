//
//  SceneDelegate.swift
//  FirebaseInstaClone
//
//  Created by hasan bilgin on 4.10.2023.
//

import UIKit
//eklendi
import Firebase

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
        
        
        //ve UIWindow nwede ise orda durması lazım kodun
        //güncel girişli kullanıcıyı alıcaktır
        let currentUser = Auth.auth().currentUser
        if currentUser != nil {
            //segue yapamıyoruz çünkü view Controller içinde değiliz
            //self.performSegue(withIdentifier: "toFeedVC", sender: nil)
            //Storyboarda ulaştık
            //ondan dolayısıyla storyBoardID den ulaşıcaz
            let board = UIStoryboard(name: "Main", bundle: nil)
            
            //ordan Hangi ViewControllera
            //sınıfı olmadığı için UITabBarController yaptık
            let tabBar = board.instantiateViewController(identifier: "tabBar") as UITabBarController
            //ilk açılcak controller seçmiş olduk
            window?.rootViewController = tabBar
            
        }
        //Navigation Controller yada Tab View Controller StoryBoardID verilebilir oda storyboarddan üstündeki View Controller butouna tıklayıp sağ tarafta açılan pncerede show the identity inspector dan StoryboardID verilebilir id vermemizin nedeni ise storyboardda en solda genelde bir ok var o sahne başlangıcıdır ona ulaşabilmek içindir
        
        
        
        
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

