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

class AddNewCardViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate, UITextViewDelegate{
    
    @IBOutlet weak var cardBarCode: UIImageView!
    @IBOutlet weak var cardBackImage: UIImageView!
    @IBOutlet weak var cardFrontImage: UIImageView!
    @IBOutlet weak var cardNameTextField: UITextField!
    @IBOutlet weak var cardNumberTextField: UITextField!
    @IBOutlet weak var cardDescriptionTextView: UITextView!
    @IBOutlet weak var barcodeImageView: UIImageView!
    @IBOutlet weak var barcodeButton: UIButton!

    
    var cardsManager = CardsManager()
    var editCard: Card?
    var addCard: Card?
    var TapOnImage : String?
    var button = RoundButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cardFrontImage?.isUserInteractionEnabled = true
        self.cardBackImage?.isUserInteractionEnabled = true
        addCardRoundCorners()
        loadImage()
        
        if UserDefaults.standard.bool(forKey: "tableViewAnimate") == true {
            addViewAnimation()
        }
    
        self.cardNameTextField.delegate = self
        self.cardNumberTextField.delegate = self
        self.cardDescriptionTextView.delegate = self
    }
    
    @IBAction func tapToCreateBarcode(_ sender: UIButton) {
        barcodeImageView.image = RSUnifiedCodeGenerator.shared.generateCode(cardNumberTextField.text!, machineReadableCodeObjectType: AVMetadataObject.ObjectType.ean13.rawValue)
    }
    
    @IBAction func createCardButton(_ sender: UIButton) {
        guard let context = cardsManager.context else {
            return
        }
        
        if editCard == nil {
            if cardNameTextField?.text != "" && cardNumberTextField?.text != "" &&  cardFrontImage.image != nil &&  cardBackImage.image != nil {
                let addUserCard = Card(context: context)
                addUserCard.cardNumber = cardNumberTextField?.text ?? ""
                addUserCard.cardName = cardNameTextField?.text ?? ""
                addUserCard.cardDescription  = cardDescriptionTextView?.text ?? ""
                addUserCard.cardDate = Date()
                if let image = cardFrontImage?.image {
                    addUserCard.cardFrontImage = CardsManager.convertImageToBase64(image: image)
                }
                if let image = cardBackImage?.image {
                    addUserCard.cardBackImage = CardsManager.convertImageToBase64(image: image)
                }
                cardsManager.saveCard(card: addUserCard)
                
            } else {
                let alertController = UIAlertController(title: "OOPS", message: "You need to give all the informations required to save new card", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                self.present(alertController, animated: true, completion: nil)
            }
            
        } else {
            editCard?.cardName = cardNameTextField?.text ?? ""
            editCard?.cardNumber = cardNumberTextField?.text ?? ""
            editCard?.cardDescription = cardDescriptionTextView?.text ?? ""
            
            if let image = cardFrontImage?.image {
                editCard?.cardFrontImage = CardsManager.convertImageToBase64(image: image)
            }
            if let image = cardBackImage?.image {
                editCard?.cardBackImage = CardsManager.convertImageToBase64(image: image)
            }
        }
    }
    
    @IBAction func tapFrontImage(_ sender: UITapGestureRecognizer) {
        TapOnImage = "frontImage"
        pickerCardImage()
    }
    @IBAction func tapBackImage(_ sender: UITapGestureRecognizer) {
        TapOnImage = "backImage"
        pickerCardImage()
    }
    
    // Load Data from full view to add card
    func loadImage() {
        guard editCard != nil else {
            return
        }
        
        cardNameTextField.text = editCard?.cardName
        cardDescriptionTextView.text = editCard?.cardDescription
        cardNumberTextField.text = editCard?.cardNumber
        cardBarCode?.image = RSUnifiedCodeGenerator.shared.generateCode(cardNumberTextField.text!, machineReadableCodeObjectType: AVMetadataObject.ObjectType.ean13.rawValue)
        
        if let base64string = editCard?.cardFrontImage {
            cardFrontImage.image = CardsManager.convertBase64ToImage(base64String: base64string)
        }
        if let base64string = editCard?.cardBackImage {
            cardBackImage.image = CardsManager.convertBase64ToImage(base64String: base64string)
        }
    }
    
    // round corners and bordercolor
    func addCardRoundCorners(){
        cardFrontImage.layer.cornerRadius = 12
        cardFrontImage.layer.borderColor = #colorLiteral(red: 0.2013760805, green: 0.5983245969, blue: 0.5465805531, alpha: 1)
        cardFrontImage.layer.borderWidth = 2
        
        cardBackImage.layer.cornerRadius = 12
        cardBackImage.layer.borderColor = #colorLiteral(red: 0.2013760805, green: 0.5983245969, blue: 0.5465805531, alpha: 1)
        cardBackImage.layer.borderWidth = 2
        
        barcodeImageView.layer.cornerRadius = 12
        barcodeImageView.layer.borderColor = #colorLiteral(red: 0.2013760805, green: 0.5983245969, blue: 0.5465805531, alpha: 1)
        barcodeImageView.layer.borderWidth = 2
        
        cardDescriptionTextView.layer.cornerRadius = 12
        cardDescriptionTextView.layer.borderColor = #colorLiteral(red: 0.2013760805, green: 0.5983245969, blue: 0.5465805531, alpha: 1)
        cardDescriptionTextView.layer.borderWidth = 2
        
        cardNameTextField.layer.cornerRadius = 12
        cardNameTextField.layer.borderColor = #colorLiteral(red: 0.2013760805, green: 0.5983245969, blue: 0.5465805531, alpha: 1)
        cardNameTextField.layer.borderWidth = 2
        
        cardNumberTextField.layer.cornerRadius = 12
        cardNumberTextField.layer.borderColor = #colorLiteral(red: 0.2013760805, green: 0.5983245969, blue: 0.5465805531, alpha: 1)
        cardNumberTextField.layer.borderWidth = 2
        
        barcodeButton.layer.cornerRadius = 15
        
    }
    
    // MARK: - Press "Return" to hide keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        cardNumberTextField.resignFirstResponder()
        cardNameTextField.resignFirstResponder()
        cardDescriptionTextView.resignFirstResponder()
        
        return true
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

    func addViewAnimation(){
        
        cardBarCode.center.x = self.view.frame.width + 30
        
        UIView.animate(withDuration: 1.0, delay: 0.4, usingSpringWithDamping: 2.0, initialSpringVelocity: 1.0, options: .allowAnimatedContent, animations: {
            self.cardBarCode.center.x = self.view.frame.width / 2
        }, completion: nil)
        
        cardNameTextField.center.x = self.view.frame.width + 30
        
        UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 2.0, initialSpringVelocity: 1.0, options: .allowAnimatedContent, animations: {
            self.cardNameTextField.center.x = self.view.frame.width / 2
        }, completion: nil)
        
        cardFrontImage.center.x = self.view.frame.width + 30
        
        UIView.animate(withDuration: 1.0, delay: 0.1, usingSpringWithDamping: 2.0, initialSpringVelocity: 1.0, options: .allowAnimatedContent, animations: {
            self.cardFrontImage.center.x = self.view.frame.width / 2
        }, completion: nil)
        
        cardBackImage.center.x = self.view.frame.width + 30
        
        UIView.animate(withDuration: 1.0, delay: 0.2, usingSpringWithDamping: 2.0, initialSpringVelocity: 1.0, options: .allowAnimatedContent, animations: {
            self.cardBackImage.center.x = self.view.frame.width / 2
        }, completion: nil)
        
        barcodeImageView.center.x = self.view.frame.width + 30
        
        UIView.animate(withDuration: 1.0, delay: 0.3, usingSpringWithDamping: 2.0, initialSpringVelocity: 1.0, options: .allowAnimatedContent, animations: {
            self.barcodeImageView.center.x = self.view.frame.width / 2
        }, completion: nil)
        
        cardNumberTextField.center.x = self.view.frame.width + 30
        
        UIView.animate(withDuration: 1.0, delay: 0.5, usingSpringWithDamping: 2.0, initialSpringVelocity: 1.0, options: .allowAnimatedContent, animations: {
            self.cardNumberTextField.center.x = self.view.frame.width / 2
        }, completion: nil)
        
        barcodeButton.center.x = self.view.frame.width + 30
        
        UIView.animate(withDuration: 1.0, delay: 0.6, usingSpringWithDamping: 2.0, initialSpringVelocity: 1.0, options: .allowAnimatedContent, animations: {
            self.barcodeButton.center.x = self.view.frame.width / 2
        }, completion: nil)
        
        cardDescriptionTextView.center.x = self.view.frame.width + 30
        
        UIView.animate(withDuration: 1.0, delay: 0.7, usingSpringWithDamping: 2.0, initialSpringVelocity: 1.0, options: .allowAnimatedContent, animations: {
            self.cardDescriptionTextView.center.x = self.view.frame.width / 2
        }, completion: nil)
        
    }

}

