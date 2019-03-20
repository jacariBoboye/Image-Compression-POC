//
//  ViewController.swift
//  ImageCompressionPOC
//
//  Created by Jacari Boboye on 3/18/19.
//  Copyright © 2019 Jacari Boboye. All rights reserved.
//

import UIKit
import SimpleImageViewer


enum compressionType: String{case highest = "highest", medium = "medium", lowest = "lowest"}

enum compressionAmount: CGFloat{case highestCompression = 0.0, highCompression = 0.25, mediumCompression = 0.50, mildCompress = 0.75, lowestCompression = 0.9}


//MARK: Properties
final class ViewController: UIViewController {
    
    @IBOutlet var originalImageView: UIImageView!
    @IBOutlet var originalImageLabel: UILabel!
    
    @IBOutlet var compressedImageView: UIImageView!
    @IBOutlet var compressedImageLabel: UILabel!
    
    @IBOutlet var customCompresionOutletButton: UIButton!
    
    @IBAction func addActionButton(_ sender: Any) {

        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            imagePicker.allowsEditing = true
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func customCompressionActionButton(_ sender: Any) {

        showPickerView()
    }
}


//MARK: View Life Cycle
extension ViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Add an image"
        
        customCompresionOutletButton.isEnabled = false
        customCompresionOutletButton.alpha = 0.2
        
        let imageTapped = UITapGestureRecognizer(target: self, 
                                         action: #selector(presentImageViewer))
        
        compressedImageView.addGestureRecognizer(imageTapped)        
    }
}


//MARK: UI Stuff
extension ViewController{
    
    private func showPickerView(){
        
        let alert = UIAlertController(title: "Image Compression Type:", message: "Please Select an Option", preferredStyle: .actionSheet)
        
        alert.view.backgroundColor = .black
        alert.view.tintColor = .darkGray
                
        alert.addAction(UIAlertAction(title: "High Compression(\(compressionAmount.highestCompression.rawValue))", style: .default , handler:{ (UIAlertAction)in
            self.setCompressedImage(compressionAmount: .highestCompression)
            self.title = "\(compressionType.highest.rawValue.uppercased())"
        }))
        alert.addAction(UIAlertAction(title: "Medium Compression(\(compressionAmount.mediumCompression.rawValue))", style: .default , handler:{ (UIAlertAction)in
            self.setCompressedImage(compressionAmount: .mediumCompression)
            self.title = "\(compressionType.medium.rawValue.uppercased())"
        }))
        alert.addAction(UIAlertAction(title: "Low Compression(\(compressionAmount.lowestCompression.rawValue))", style: .default , handler:{ (UIAlertAction)in
            self.setCompressedImage(compressionAmount: .lowestCompression)
            self.title = "\(compressionType.lowest.rawValue.uppercased())"
        }))
        alert.addAction(UIAlertAction(title: "Do Nothing", style: .default , handler:{ (UIAlertAction)in
        }))
        self.present(alert, animated: true, completion: {
        })
    }
        
    private func setCompressedImage(compressionAmount: compressionAmount){
                
        compressedImageView.image = UIImage(data: (originalImageView.image?.jpegData(compressionQuality: CGFloat(compressionAmount.rawValue)))!)
        
        compressedImageLabel.text = "Compressed Image Size: \n \(compressedImageView.getSize())"
                
        compressedImageView.isUserInteractionEnabled = true
        
        presentImageViewer()
    }

    @objc private func presentImageViewer(){
        
        let configuration = ImageViewerConfiguration { config in
            config.imageView = self.compressedImageView
        }        
        
        let imageViewerController = ImageViewerController(configuration: configuration)
        
        present(imageViewerController, animated: true)
    }
}

//MARK: UIImagePickerControllerDelegate
extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, 
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        
        guard let selectedImage = info[.originalImage] as? UIImage 
            else {fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")}
        
        originalImageView.image = selectedImage
        originalImageLabel.text = "Actual Image Size: \n \(originalImageView.getSize())"
        
        dismiss(animated: true, completion:{
            self.gottaKeepItFun()
            self.customCompresionOutletButton.isEnabled = true
            self.compressedImageView.isUserInteractionEnabled = false
            self.compressedImageView.image = nil
            self.compressedImageLabel.text = "Compressed Image Size:"
            self.title = "Compress image"
        })
    }
}


//MARK: Bonus
extension ViewController{
    
    //TODO(Optional): Add a fun animation to the customCompressOutlet button 
    private func gottaKeepItFun(){
        UIView.animate(withDuration: 0.7) { 
            self.customCompresionOutletButton.alpha = 1.0
        }
    }
}
