//
//  SceneDelegate.swift
//  LatynLyngo
//
//  Created by NewAgeSMB on 26/03/21.
//  Copyright © 2021 NewAgeSMB. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "checkUpdate"), object: nil)
    }
    
}

