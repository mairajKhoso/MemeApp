//
//  ViewController.swift
//  MemeApp
//
//  Created by Apple Macbook on 17/01/2019.
//  Copyright © 2019 Hivelet. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate {
    
    @IBOutlet weak var topTxtField: UITextField!
    @IBOutlet weak var bottomTxtField: UITextField!
    @IBOutlet weak var cameraBtn: UIBarButtonItem!
    let imgPicker = UIImagePickerController()
    
    @IBOutlet weak var memeImg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black
        imgPicker.delegate = self
        
        topTxtField.delegate = self
        topTxtField.text = "TOP"
        bottomTxtField.delegate = self
        bottomTxtField.text = "BOTTOM"
        
        //listen for keyboard events
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIResponder.keyboardWillShowNotification, object: nil)
        
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.tag == 0{
            if topTxtField.text == "TOP" {
                topTxtField.text = ""
                //topTxtField.becomeFirstResponder()
            }
        }
        else if textField.tag == 1{
            if bottomTxtField.text == "BOTTOM" {
                bottomTxtField.text = ""
            }
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.tag == 0{
            if (topTxtField.text?.isEmpty)! {
                //topTxtField.resignFirstResponder()
                topTxtField.text = "TOP"
            }
        }
        else if textField.tag == 1{
            if (bottomTxtField.text?.isEmpty)!{
                bottomTxtField.text = "BOTTOM"
            }
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func keyboardWillChange(notification: Notification){
        print("keyboard will show: \(notification.name.rawValue)")
    }
    override func viewWillAppear(_ animated: Bool) {
                cameraBtn.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    }
    

    @IBAction func pickImage(_ sender: UIBarButtonItem) {
        imgPicker.allowsEditing = false
        imgPicker.sourceType = .photoLibrary
        present(imgPicker, animated: true, completion: nil)
        print("button pressed")
    }
    
    @IBAction func pickImageCamera(_ sender: UIBarButtonItem) {
        
        imgPicker.delegate = self
        
        present(imgPicker, animated: true, completion: nil)
    }
    
    
    //Image picker controller delegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            memeImg.contentMode = .scaleAspectFill
            memeImg.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
}

