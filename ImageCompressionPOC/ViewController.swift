//
//  ViewController.swift
//  ImageCompressionPOC
//
//  Created by Jacari Boboye on 3/18/19.
//  Copyright © 2019 Jacari Boboye. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet var originalImageView: UIImageView!
    @IBOutlet var originalImageLabel: UILabel!
    
    @IBOutlet var compressedImageView: UIImageView!
    @IBOutlet var compressedImageLabel: UILabel!
    
    @IBAction func addActionButton(_ sender: Any) {
        //Repace old image and text
        //Reset compress child image and text
        //Reset title
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            imagePicker.allowsEditing = true
            present(imagePicker, animated: true, completion: nil)
        }
    }
    @IBAction func customCompressionActionButton(_ sender: Any) {
        //Show picker 
        showPickerView()
    }
    
    @IBOutlet var customCompresionOutletButton: UIButton!
}


//MARK: View Life Cycle
extension ViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        customCompresionOutletButton.isEnabled = false
        customCompresionOutletButton.alpha = 0.2
    }
}


extension ViewController{
    
    enum compressionType: String{case high = "high", medium = "medium", low = "low"}
    
    private func showPickerView(){
        
        let alert = UIAlertController(title: "Image Compression Type:", message: "Please Select an Option", preferredStyle: .actionSheet)
        
        alert.view.backgroundColor = .black
        alert.view.tintColor = .darkGray
        
        var selectedProperty = ""
        
        //TODO: Add reusable "addAction" button here and replace code below" 
        alert.addAction(UIAlertAction(title: "High Compression(75%)", style: .default , handler:{ (UIAlertAction)in
            self.setCompressedImage(self.originalImageView.image!, compressionType: compressionType.high)
            selectedProperty = compressionType.high.rawValue
//            let showPercentStr = (selectedProperty.isEmpty) ? "" : "%"
//            self.title = "Image POC - \(selectedProperty.uppercased()) \(showPercentStr)"
            self.title = "\(selectedProperty.uppercased())"
        }))
        alert.addAction(UIAlertAction(title: "Medium Compression(50%)", style: .default , handler:{ (UIAlertAction)in
            self.setCompressedImage(self.originalImageView.image!, compressionType: .medium)
            selectedProperty = compressionType.medium.rawValue
//            let showPercentStr = (selectedProperty.isEmpty) ? "" : "%"
//            self.title = "Image POC - \(selectedProperty.uppercased()) \(showPercentStr)"
            self.title = "\(selectedProperty.uppercased())"
        }))
        alert.addAction(UIAlertAction(title: "Low Compression(25%)", style: .default , handler:{ (UIAlertAction)in
            self.setCompressedImage(self.originalImageView.image!, compressionType: .low)
            selectedProperty = compressionType.low.rawValue
//            let showPercentStr = (selectedProperty.isEmpty) ? "" : "%"
//            self.title = "Image POC - \(selectedProperty.uppercased()) \(showPercentStr)"
            self.title = "\(selectedProperty.uppercased())"
        }))
        alert.addAction(UIAlertAction(title: "Do Nothing", style: .default , handler:{ (UIAlertAction)in
        }))
        self.present(alert, animated: true, completion: {
        })
    }
    
    private func addAlertAction(){}//TODO: Make this a reusable "addAction" button 
    
    private func setCompressedImage(_ image: UIImage, compressionType: compressionType){
        switch compressionType{
        case .high:
            let imageData = originalImageView.image?.jpegData(compressionQuality:0.25)!
            compressedImageView.image = UIImage(data: (originalImageView.image?.jpegData(compressionQuality:0.25))!)
            compressedImageLabel.text = "Compressed Image Size: \n \(Float(Double(imageData!.count)/1024).rounded()) KB"
        case .medium:
            let imageData = originalImageView.image?.jpegData(compressionQuality:0.50)!
            compressedImageView.image = UIImage(data: (originalImageView.image?.jpegData(compressionQuality:0.50))!)
            compressedImageLabel.text = "Compressed Image Size: \n \(Float(Double(imageData!.count)/1024).rounded()) KB"
        case .low:
            let imageData = originalImageView.image?.jpegData(compressionQuality:0.75)!
            compressedImageView.image = UIImage(data: (originalImageView.image?.jpegData(compressionQuality: 0.75))!)
            compressedImageLabel.text = "Compressed Image Size: \n \(Float(Double(imageData!.count)/1024).rounded()) KB"
        }
    }
    
    private func resetForNewImage(){
        compressedImageView.image = nil
        compressedImageLabel.text = "Compressed Image Size:"
    }
}


//UIImag
extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, 
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        guard let selectedImage = info[.editedImage] as? UIImage else {fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")}
        originalImageView.image = selectedImage
        let imageData = originalImageView.image?.jpegData(compressionQuality:0.75)!
        originalImageLabel.text = "Actual Image Size: \n \(Float(Double(imageData!.count)/1024).rounded()) KB"
        resetForNewImage()
        dismiss(animated: true, completion:{
            self.gottaKeepItFun()
            self.customCompresionOutletButton.isEnabled = true
        })
    }
}


extension ViewController{
    
    //TODO(Optional): Add a fun animation to the customCompressOutlet button 
    fileprivate func gottaKeepItFun(){
        UIView.animate(withDuration: 0.7) { 
            self.customCompresionOutletButton.alpha = 0.95 
        }
    }
}
