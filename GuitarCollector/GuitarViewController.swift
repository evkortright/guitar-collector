//
//  GuitarViewController.swift
//  GuitarCollector
//
//  Created by Enrique V. Kortright on 5/2/17.
//  Copyright © 2017 Enrique V. Kortright. All rights reserved.
//

import UIKit

class GuitarViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var guitarImageView: UIImageView!
    
    @IBOutlet weak var guitarNameTextField: UITextField!
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
    }

    @IBAction func cameraTapped(_ sender: Any) {
        print("cameraTapped")
    }
    
    @IBAction func photosTapped(_ sender: Any) {
        print("photosTapped")
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
  
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        guitarImageView.image = image
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addTapped(_ sender: Any) {
        print("addTapped")
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        let guitar = Guitar(context: context)
        guitar.name = guitarNameTextField.text
        guitar.image = UIImagePNGRepresentation(guitarImageView.image!) as NSData?
        delegate.saveContext()
        navigationController?.popViewController(animated: true)
    }
        
}
