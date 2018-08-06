//
//  ViewController.swift
//  One-image Viewer
//
//  Created by chang-che-wei on 2018/8/6.
//  Copyright © 2018年 chang-che-wei. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    var image: UIImageView!
    
    @IBAction func selectPictureButton(_ sender: UIButton) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
        
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        if let pickerImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            imageView.image = pickerImage
        
        }
        dismiss(animated: true, completion: nil)
    }
    
    
    let scrollView: UIScrollView = {
        var scrollView = UIScrollView()
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = UIColor(red: 43/255, green: 43/255, blue: 43/255, alpha: 1)
        return scrollView
    }()
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func setZoomScale() {
        let imageViewSize = self.imageView.bounds.size
        let scrollViewSize = self.scrollView.bounds.size
        let widthScale = scrollViewSize.width / imageViewSize.width
        let heightScale = scrollViewSize.height / imageViewSize.height
        
        self.scrollView.minimumZoomScale = min(widthScale, heightScale)
        self.scrollView.zoomScale = 1.0
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        let imageViewSize = self.imageView.frame.size
        let scrollViewSize = scrollView.bounds.size

        let verticalPadding = imageViewSize.height < scrollViewSize.height ? (scrollViewSize.height - imageViewSize.height) / 2 : 0
        let horizontalPadding = imageViewSize.width < scrollViewSize.width ? (scrollViewSize.width - imageViewSize.width) / 2 : 0

        scrollView.contentInset = UIEdgeInsets(top: verticalPadding, left: horizontalPadding, bottom: verticalPadding, right: horizontalPadding)
    }

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.scrollView)
        self.scrollView.zoomScale = 1.0
        self.scrollView.minimumZoomScale = 0.5
        self.scrollView.maximumZoomScale = 2.0
        self.scrollView.delegate = self
        
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -77).isActive = true
       
        let fullScreenSize = UIScreen.main.bounds.size
        self.image = UIImageView(image: UIImage(named: "icon_photo")?.withRenderingMode(.alwaysTemplate))
        self.image.tintColor = .white
        image.center = CGPoint(
            x: fullScreenSize.width * 0.5 ,
            y: fullScreenSize.height * 0.4)
        

        self.scrollView.contentSize = imageView.bounds.size
        self.scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
 
        
        self.scrollView.addSubview(self.image)
        self.scrollView.addSubview(self.imageView)
        // add the scroll view to self.view
        
        setZoomScale()
        scrollViewDidZoom(self.scrollView)
        
    }
    
    override func viewWillLayoutSubviews() {
        setZoomScale()
    }

    


}

