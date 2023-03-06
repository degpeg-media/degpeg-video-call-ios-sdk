//
//  NavigationControllerExtension.swift
//  degpeg-video-call-ios-sdk
//
//  Created by Vignesh S on 04/03/23.
//

import UIKit

extension UIViewController {
    /**
      returns true only if the viewcontroller is presented.
    */
    var isModal: Bool {
        if let index = navigationController?.viewControllers.firstIndex(of: self), index > 0 {
            return false
        } else if presentingViewController != nil {
            if let parent = parent, !(parent is UINavigationController || parent is UITabBarController) {
                return false
            }
            return true
        } else if let navController = navigationController, navController.presentingViewController?.presentedViewController == navController {
            return true
        } else if tabBarController?.presentingViewController is UITabBarController {
            return true
        }
        return false
    }
}
