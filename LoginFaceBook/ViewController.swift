//
//  ViewController.swift
//  LoginFaceBook
//
//  Created by KuAnh on 09/05/2018.
//  Copyright © 2018 KuAnh. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit


class ViewController: UIViewController {

    let fbLoginManager: FBSDKLoginManager = FBSDKLoginManager()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginFacebook(_ sender: Any) {
        fbLogin()
    }
    
    func fbLogin() {
        fbLoginManager.logIn(withReadPermissions: ["email"], from: self) {
            (result, err) in
            if (err == nil) {
                print("Loginn Successfully !")
                let fbLoginResult: FBSDKLoginManagerLoginResult = result!
                if fbLoginResult.grantedPermissions != nil {
                    self.getDataLogin()
                }
                
            }else{
                print("Login Failed")
            }
        }
    }
    
    func getDataLogin() {
        if FBSDKAccessToken.current() != nil {
            // lay gia tri (id: co the hien thi anh, name, email) cua fb sau khi login thanh cong
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: {
                (connect, result, err) in
                if err == nil {
                    // luu cac gia tri vao 1 Dictionary
                    let dict = result as! Dictionary<String, Any>
                    print("Info \(dict)")
                    // lay cac gia tri de co the luu thong tin or hien thi
//                    let linkId: String = dict["id"] as! String
//                    let linkName: String = dict["name"] as! String
                    let linkEmail: String = dict["email"] as! String
                    UserDefaults.standard.set(linkEmail, forKey: "email")
                    
                    let appdelegate = UIApplication.shared.delegate as! AppDelegate
                    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let homeViewController = mainStoryboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
                    let nav = UINavigationController(rootViewController: homeViewController)
                    appdelegate.window!.rootViewController = nav
                }
            })
        }
    }
}


