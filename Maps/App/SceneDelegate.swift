//
//  SceneDelegate.swift
//  Maps
//
//  Created by Илья Дунаев on 12.06.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var visualEffectView = UIVisualEffectView()
    var window: UIWindow?
    var coordinator: AppCoordinator?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        window?.makeKeyAndVisible()
        
        coordinator = AppCoordinator()
        coordinator?.start()
        
        return
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        self.visualEffectView.removeFromSuperview()
    }

    func sceneWillResignActive(_ scene: UIScene) {
        
        if !self.visualEffectView.isDescendant(of: self.window!) {
                    let blurEffect = UIBlurEffect(style: .light)
                    self.visualEffectView = UIVisualEffectView(effect: blurEffect)
                    self.visualEffectView.frame = (self.window?.bounds)!
                    self.window?.addSubview(self.visualEffectView)
                }
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        self.visualEffectView.removeFromSuperview()
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

