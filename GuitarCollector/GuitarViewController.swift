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
    
    @IBOutlet weak var addUpdateButton: UIButton!
    
    @IBOutlet weak var deleteButton: UIButton!
    
    var imagePicker = UIImagePickerController()
    
    var guitar : Guitar? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        
        if (guitar != nil) {
            print("guitar is not nil")
            guitarImageView.image = UIImage(data: guitar!.image! as Data)
            guitarNameTextField.text = guitar!.name
            addUpdateButton.setTitle("Update", for: .normal)
        } else {
            print("guitar is nil")
            deleteButton.isHidden = true
        }
    }

    @IBAction func cameraTapped(_ sender: Any) {
        print("cameraTapped")
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
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
        if (guitar == nil) {
            let context = delegate.persistentContainer.viewContext
            guitar = Guitar(context: context)
        }
        guitar!.name = guitarNameTextField.text
        guitar!.image = UIImagePNGRepresentation(guitarImageView.image!) as NSData?
        delegate.saveContext()
        navigationController?.popViewController(animated: true)
    }
        
    @IBAction func deleteTapped(_ sender: Any) {
        print("deleteTapped")
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        context.delete(guitar!)
        delegate.saveContext()
        navigationController?.popViewController(animated: true)
    }
    
}
