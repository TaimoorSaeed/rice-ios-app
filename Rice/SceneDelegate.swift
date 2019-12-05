//
//  SceneDelegate.swift
//  Rice
//
//  Created by Rachel Chua on 11/11/19.
//  Copyright © 2019 Rice. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseMessaging

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        configureInitialViewController()
        
        guard let _ = (scene as? UIWindowScene) else { return }
        
        
    }
        
            func configureInitialViewController() {
                var initialVC: UIViewController
                let storyboard = UIStoryboard(name: "Welcome", bundle: nil)
        
                if Auth.auth().currentUser != nil {
        
                    initialVC = storyboard.instantiateViewController(withIdentifier: IDENTIFIER_TABBAR)
        
                    } else {
        
                    initialVC = storyboard.instantiateViewController(withIdentifier: IDENTIFIER_WELCOME)
        
                    }
        
                    window?.rootViewController = initialVC
                    window?.makeKeyAndVisible()
                }
        
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.

//        Api.User.isOnline(bool: true)
        
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
        
//        Api.User.isOnline(bool: false)
        
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
        
//        Api.User.isOnline(bool: false)
        Messaging.messaging().shouldEstablishDirectChannel = false
        
    }






