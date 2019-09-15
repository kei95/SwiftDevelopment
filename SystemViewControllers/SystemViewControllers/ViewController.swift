//
//  ViewController.swift
//  SystemViewControllers
//
//  Created by Yamashtia Keisuke on 2019-09-05.
//  Copyright © 2019 Yamashtia Keisuke. All rights reserved.
//

import UIKit
import SafariServices
import MessageUI

// UIImagePickerControllerDelegate: will transfer the selected image's info back to your app.
// UINavigationControllerDelegate: will handle the responsibility for dismissing the image picker view
class ViewController: UIViewController, UIImagePickerControllerDelegate,
                    UINavigationControllerDelegate, MFMailComposeViewControllerDelegate {

    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func shareBtnTapped(_ sender: UIButton) {
        guard let image = imageView.image else {return}
        let activityController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        activityController.popoverPresentationController?.sourceView = sender as! UIView
        present(activityController, animated: true, completion: nil)
    }
    
    @IBAction func safariBtnTapped(_ sender: UIButton) {
        // 1. Create an URL
        if let url = URL(string: "http://www.google.com") {
            // 2. Create safari viewController
            let safariViewController = SFSafariViewController(url: url)
            present(safariViewController, animated: true, completion: nil)
        }
    }
    
    @IBAction func cameraBtnTapped(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        let alertController = UIAlertController(title: "Choose Image Source", message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let cameraAction = UIAlertAction(title: "Camera", style: .default) { (action) in
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true, completion: nil)
            }
            alertController.addAction(cameraAction)
        }

        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let photolibAction = UIAlertAction(title: "Photo library", style: .default) { (action) in
                imagePicker.sourceType = .photoLibrary
                self.present(imagePicker, animated: true, completion: nil)
            }
            alertController.addAction(photolibAction)
        }

        alertController.addAction(cancelAction)
        alertController.popoverPresentationController?.sourceView = sender as? UIView
        
        present(alertController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let selectedImage = info[.editedImage] as? UIImage else {return}
        imageView.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //: When user taps cancel
    }
    
    @IBAction func emailBtnTapped(_ sender: UIButton) {
        if MFMailComposeViewController.canSendMail() {
            // You have to use the apple system Mail application(logged in - email account)
            let mailComposer = MFMailComposeViewController()
            mailComposer.mailComposeDelegate = self
            mailComposer.setToRecipients(["kei0613shine.star@gmail.com", "derrick.ciccc@gmail.com"])
            mailComposer.setSubject("Hey")
            mailComposer.setMessageBody("DERRICK", isHTML: false)
            
            present(mailComposer, animated: true, completion: nil)
            return
        }

    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        dismiss(animated: true, completion: nil)
    }
}

