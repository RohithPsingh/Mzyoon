//
//  IntroProfileViewController.swift
//  Mzyoon
//
//  Created by QOL on 26/11/18.
//  Copyright © 2018 QOL. All rights reserved.
//

import UIKit

class IntroProfileViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, ServerAPIDelegate
{

    //POSITION
    var x:CGFloat!
    var y:CGFloat!
    
    var userImage = UIImageView()

    var imagePicker = UIImagePickerController()
    
    var userNameTextField = UITextField()
    
    // Error PAram...
    var DeviceNum:String!
    var UserType:String!
    var AppVersion:String!
    var ErrorStr:String!
    var PageNumStr:String!
    var MethodName:String!
    
    let serviceCall = ServerAPI()
    
    override func viewDidLoad()
    {
        x = 10 / 375 * 100
        x = x * view.frame.width / 100
        
        y = 10 / 667 * 100
        y = y * view.frame.height / 100
        
        introScreenContents()
        
        let disableKeyboard = UITapGestureRecognizer(target: self, action: #selector(self.closeKeyboard(gesture:)))
        self.view.addGestureRecognizer(disableKeyboard)
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @objc func closeKeyboard(gesture : UITapGestureRecognizer)
    {
        self.view.endEditing(true)
    }
    
    func API_CALLBACK_Error(errorNumber: Int, errorMessage: String) {
        print("Intro Profile", errorMessage)
    }
    
    func DeviceError()
    {
        DeviceNum = UIDevice.current.identifierForVendor?.uuidString
        AppVersion = UIDevice.current.systemVersion
        UserType = "customer"
     //   ErrorStr = "Default Error"
        PageNumStr = "IntroProfileViewcontroller"
      //  MethodName = "do"
        
        print("UUID", UIDevice.current.identifierForVendor?.uuidString as Any)
        self.serviceCall.API_InsertErrorDevice(DeviceId: DeviceNum, PageName: PageNumStr, MethodName: MethodName, Error: ErrorStr, ApiVersion: AppVersion, Type: UserType, delegate: self)
    }
    
    
    func API_CALLBACK_InsertErrorDevice(deviceError: NSDictionary)
    {
        let ResponseMsg = deviceError.object(forKey: "ResponseMsg") as! String
        
        if ResponseMsg == "Success"
        {
            let Result = deviceError.object(forKey: "Result") as! String
            print("Result", Result)
        }
    }
    
    func API_CALLBACK_IntroProfile(introProf: NSDictionary)
    {
        let ResponseMsg = introProf.object(forKey: "ResponseMsg") as! String
        
        if ResponseMsg == "Success"
        {
            let Result = introProf.object(forKey: "Result") as! String
            print("Result", Result)
            
            if Result == "1"
            {
                let homeScreen = HomeViewController()
                self.navigationController?.pushViewController(homeScreen, animated: true)
            }
            
        }
        else if ResponseMsg == "Failure"
        {
            let Result = introProf.object(forKey: "Result") as! String
            print("Result", Result)
            
            MethodName = "InsertBuyerName"
            ErrorStr = Result
            DeviceError()
        }
        
    }
    
    func API_CALLBACK_ProfileImageUpload(ImageUpload: NSDictionary)
    {
        let ResponseMsg = ImageUpload.object(forKey: "ResponseMsg") as! String
        
        if ResponseMsg == "Success"
        {
            let Result = ImageUpload.object(forKey: "Result") as! String
            print("Result", Result)
        }
        else if ResponseMsg == "Failure"
        {
            let Result = ImageUpload.object(forKey: "Result") as! String
            print("Result", Result)
            
            MethodName = "ImageUpload"
            ErrorStr = Result
            DeviceError()
        }
    }
    
    func introScreenContents()
    {
        let backgroundImage = UIImageView()
        backgroundImage.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        backgroundImage.image = UIImage(named: "background")
        view.addSubview(backgroundImage)
        
        let introProfileNavigationBar = UIView()
        introProfileNavigationBar.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: (6.4 * y))
        introProfileNavigationBar.backgroundColor = UIColor(red: 0.0392, green: 0.2078, blue: 0.5922, alpha: 1.0)
        view.addSubview(introProfileNavigationBar)
        
        let navigationTitle = UILabel()
        navigationTitle.frame = CGRect(x: 0, y: (2.5 * y), width: introProfileNavigationBar.frame.width, height: (3 * y))
        navigationTitle.text = "PROFILE"
        navigationTitle.textColor = UIColor.white
        navigationTitle.textAlignment = .center
        navigationTitle.font = UIFont(name: "Avenir-Regular", size: 20)
        introProfileNavigationBar.addSubview(navigationTitle)
        
        userImage.frame = CGRect(x: ((view.frame.width - (20 * x)) / 2), y: introProfileNavigationBar.frame.maxY + (5 * y), width: (20 * x), height: (20 * y))
        userImage.layer.cornerRadius = userImage.frame.height / 2
        userImage.backgroundColor = UIColor.red
        userImage.image = UIImage(named: "imgpsh_fullsizebai")
        userImage.layer.masksToBounds = true
        userImage.contentMode = .scaleAspectFill
        view.addSubview(userImage)
        
        let cameraButton = UIButton()
        cameraButton.frame = CGRect(x: userImage.frame.maxX - (5 * x), y: userImage.frame.maxY - (5 * y), width: (5 * x), height: (5 * y))
        cameraButton.backgroundColor = UIColor.white
        cameraButton.layer.cornerRadius = cameraButton.frame.height / 2
        cameraButton.setImage(UIImage(named: "camera"), for: .normal)
        cameraButton.addTarget(self, action: #selector(self.cameraButtonAction(sender:)), for: .touchUpInside)
        view.addSubview(cameraButton)
        
        let userImageIcon = UIImageView()
        userImageIcon.frame = CGRect(x: (2 * x), y: userImage.frame.maxY + (5 * y), width: (3 * x), height: (3 * y))
        userImageIcon.layer.cornerRadius = userImageIcon.frame.height /  2
        userImageIcon.layer.masksToBounds = true
        userImageIcon.backgroundColor = UIColor(red: 0.0392, green: 0.2078, blue: 0.5922, alpha: 1.0)
        userImageIcon.image = UIImage(named: "profile")
        view.addSubview(userImageIcon)
        
        userNameTextField.frame = CGRect(x: userImageIcon.frame.maxX + x, y: userImage.frame.maxY + ( 5 * y), width: view.frame.width - (6 * x), height: (4 * y))
        userNameTextField.placeholder = "Enter your name"
        userNameTextField.textColor = UIColor(red: 0.098, green: 0.302, blue: 0.7608, alpha: 1.0)
        userNameTextField.textAlignment = .left
        userNameTextField.font = UIFont(name: "Avenir-Heavy", size: 18)
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: userNameTextField.frame.height))
        userNameTextField.leftView = paddingView
        userNameTextField.leftViewMode = UITextField.ViewMode.always
        userNameTextField.adjustsFontSizeToFitWidth = true
        userNameTextField.keyboardType = .default
        userNameTextField.clearsOnBeginEditing = true
        userNameTextField.returnKeyType = .done
        userNameTextField.delegate = self
        view.addSubview(userNameTextField)
        
        let underLine = UILabel()
        underLine.frame = CGRect(x: (2 * x), y: userNameTextField.frame.maxY, width: view.frame.width - (4 * x), height: 1)
        underLine.backgroundColor = UIColor.lightGray
        view.addSubview(underLine)
        
        let introProfileNextButton = UIButton()
        introProfileNextButton.frame = CGRect(x: view.frame.width - (13 * x), y: underLine.frame.maxY + (5 * y), width: (10 * x), height: (4 * y))
        introProfileNextButton.backgroundColor = UIColor(red: 0.0392, green: 0.2078, blue: 0.5922, alpha: 1.0)
        introProfileNextButton.setTitle("NEXT", for: .normal)
        introProfileNextButton.setTitleColor(UIColor.white, for: .normal)
        introProfileNextButton.addTarget(self, action: #selector(self.introProfileNextButtonAction(sender:)), for: .touchUpInside)
        view.addSubview(introProfileNextButton)
    }
    
    @objc func cameraButtonAction(sender : UIButton)
    {
        let cameraAlert = UIAlertController(title: "Alert", message: "Choose image from", preferredStyle: .alert)
        cameraAlert.addAction(UIAlertAction(title: "Camera", style: .default, handler: cameraAlertAction(action:)))
        cameraAlert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: galleryAlertAction(action:)))
        cameraAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(cameraAlert, animated: true, completion: nil)
    }
    
    func cameraAlertAction(action : UIAlertAction)
    {
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            print("Button capture")
            
            imagePicker.delegate = self
            imagePicker.sourceType = .camera;
            imagePicker.allowsEditing = false
            
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func galleryAlertAction(action : UIAlertAction)
    {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            print("Button capture")
            
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum;
            imagePicker.allowsEditing = false
            
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.userImage.image = pickedImage
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func introProfileNextButtonAction(sender : UIButton)
    {
        if userNameTextField.text?.isEmpty == true
        {
            let alert = UIAlertController(title: "Empty", message: "Please enter your name to proceed", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else
        {
            FileHandler().saveImageDocumentDirectory(image: userImage.image!)
            UserDefaults.standard.set(userNameTextField.text!, forKey: "UserName")
            let profName = userNameTextField.text
            let profId = 1
            print("ENTERED NAME", userNameTextField.text!)
            serviceCall.API_IntroProfile(Id: profId, Name: userNameTextField.text!, delegate: self)
            UserDefaults.standard.set(userNameTextField.text!, forKey: "Name")
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
