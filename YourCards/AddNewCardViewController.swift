//
//  AddNewCardViewController.swift
//  YourCards
//
//  Created by Andrew on 11/5/17.
//  Copyright © 2017 Andrew Konchak. All rights reserved.
//

import UIKit
import RSBarcodes_Swift
import AVFoundation



class AddNewCardViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var cardBarCode: UIImageView!
    @IBOutlet weak var cardBackImage: UIImageView!
    @IBOutlet weak var cardFrontImage: UIImageView!
    @IBOutlet weak var cardNameTextField: UITextField!
    @IBOutlet weak var cardNumberTextField: UITextField!
    
    var userCards = CardsManager()
    var editCard: Card?
    var addCard: Card?
    var TapOnImage : String?
    
    @IBOutlet weak var barcodeImageView: UIImageView!
    
    @IBAction func tapToCreateBarcode(_ sender: UIButton) {
        barcodeImageView.image = RSUnifiedCodeGenerator.shared.generateCode(cardNumberTextField.text!, machineReadableCodeObjectType: AVMetadataObject.ObjectType.ean13.rawValue)
        
    }
    
    @IBAction func createCardButton(_ sender: UIButton) {
        if cardNameTextField?.text != "" && cardNumberTextField?.text != "" &&  cardFrontImage.image != nil &&  cardBackImage.image != nil {
            let addUserCard = Card(context: userCards.context)
            addUserCard.cardNumber = cardNumberTextField!.text!
            addUserCard.cardName = cardNameTextField!.text!
//           addUserCard.cardDescription  = !.text!
            addUserCard.cardDate = Date()
            addUserCard.cardFrontImage = convertImageToBase64(image: (cardFrontImage?.image)!)
            addUserCard.cardBackImage = convertImageToBase64(image: (cardBackImage?.image)!)
            userCards.createNewCards(createCard: addUserCard)
        } else {
            let alertController = UIAlertController(title: "OOPS", message: "You need to give all the informations required to save this product", preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cardFrontImage?.isUserInteractionEnabled = true
        self.cardBackImage?.isUserInteractionEnabled = true
        
        // UIImage round corners
        cardFrontImage.layer.cornerRadius = 12
        cardBackImage.layer.cornerRadius = 12
        barcodeImageView.layer.cornerRadius = 12
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func tapFrontImage(_ sender: UITapGestureRecognizer) {
        TapOnImage = "frontImage"
        pickerCardImage()
    }
    @IBAction func tapBackImage(_ sender: UITapGestureRecognizer) {
         TapOnImage = "backImage"
        pickerCardImage()
    }
    
    func pickerCardImage() {
        
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = true
        
        let alertController = UIAlertController(title: "Add a Picture", message: "Choose From", preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { (action) in
            pickerController.sourceType = .camera
            self.present(pickerController, animated: true, completion: nil)
            
        }
        let photosLibraryAction = UIAlertAction(title: "Photos Library", style: .default) { (action) in
            pickerController.sourceType = .photoLibrary
            self.present(pickerController, animated: true, completion: nil)
            
        }
        
        let savedPhotosAction = UIAlertAction(title: "Saved Photos Album", style: .default) { (action) in
            pickerController.sourceType = .savedPhotosAlbum
            self.present(pickerController, animated: true, completion: nil)
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        alertController.addAction(cameraAction)
        alertController.addAction(photosLibraryAction)
        alertController.addAction(savedPhotosAction)
        alertController.addAction(cancelAction)
        
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.dismiss(animated: true, completion: nil)
        let image = info[UIImagePickerControllerOriginalImage] as? UIImage
            if TapOnImage == "frontImage"{
                cardFrontImage.image = image
            }else{
                cardBackImage.image = image
            }
        }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    // MARK: - Convert UIImage to base64String
    
    func convertImageToBase64(image: UIImage) -> String {
        let imageData = UIImagePNGRepresentation(image)
        let base64String = imageData?.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        
        return base64String ?? ""
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    
}
