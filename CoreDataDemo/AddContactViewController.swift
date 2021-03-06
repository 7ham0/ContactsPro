//
//  AddContactViewController.swift
//  ContactsPro
//
//  Created by Giorgi Shamugia on 1/21/20.
//  Copyright © 2020 7ham0. All rights reserved.
//

import UIKit



//TODO - Add validations  +
class AddContactViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var mailTextField: UITextField!
    
    
    var imagePicker = UIImagePickerController()
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var isUpdate: Bool = false
    var contactIndex: Int = 0
    
    var name: String?
    var phone: String?
    var image: UIImage?
    var mail: String?
    
    
    @IBAction func save(_ sender: UIButton) {
        if nameTextField.text == "" || phoneTextField.text == "" || mailTextField.text == "" || profileImageView.image?.pngData() == nil {
            
            nameTextField.attributedPlaceholder = NSAttributedString(string: "Name",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
            nameTextField.shake()
            phoneTextField.attributedPlaceholder = NSAttributedString(string: "Phone Number",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
            phoneTextField.shake()
            mailTextField.attributedPlaceholder = NSAttributedString(string: "E-mail",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
            mailTextField.shake()
            
            let alertController = UIAlertController(title: "Missing Information", message:"You left one or more fields empty. Please make sure that all fields are filled before attempting to save.", preferredStyle: UIAlertController.Style.alert)
            let OKAction = UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default, handler: nil)
        
            alertController.addAction(OKAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        } else {

            let contact = Contact(context: context)
            contact.name = nameTextField.text
            contact.phone = phoneTextField.text
            contact.mail = mailTextField.text
            contact.profile = profileImageView.image?.pngData()
            
            appDelegate.saveContext()
            print("contact created")
        
        
        self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Settings of radius end round corners))
        profileImageView.makeRounded()
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(browseImage))
        profileImageView.addGestureRecognizer(tapGesture)

        
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary;
        imagePicker.allowsEditing = false
        imagePicker.view.backgroundColor = UIColor.darkGray
        
    }
    
    @objc func browseImage() {
        self.present(imagePicker, animated: true, completion: nil)
        print("tapped picker")
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        
//convert
let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
        if let pickedImage = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage {
            profileImageView.contentMode = .right
            profileImageView.image = pickedImage
            profileImageView.layer.masksToBounds = true
            profileImageView.contentMode = UIView.ContentMode.scaleAspectFit;
            profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
            profileImageView.clipsToBounds = true

        }
        
        dismiss(animated: true, completion: nil)
        print("image picked")
    }
    

    

}




//convert
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
	return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
	return input.rawValue
}
