//
//  CardContentViewController.swift
//  CaNew
//
//  Created by 홍성호 on 2017. 9. 8..
//  Copyright © 2017년 홍성호. All rights reserved.
//

import UIKit

class CardContentViewController: UIViewController {

    var mode: CardMode = .square
    var index = 0
    var text: String?

    var bgImageView: UIImageView?
    var textLabel: UILabel?
    var textView: UITextView?
    var edgeView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setContentsView()
        self.setGesture()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func parse(card: CNCard){
        self.mode = card.mode
        self.text = card.text
    }
    
    func setGesture(){
        if let imageView = self.bgImageView{
            imageView.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer.init(target: self, action: #selector(handleImageTap(_:)))
            imageView.addGestureRecognizer(tap)
        }
        
        if let textLabel = self.textLabel{
            textLabel.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer.init(target: self, action: #selector(handleTextLabelTap(_:)))
            textLabel.addGestureRecognizer(tap)
        }
    }
    
    @objc func handleKeyboardDoneBtn(){
        self.textView?.endEditing(true)
    }
    
    func setContentsView(){

        let imageSize = CGSize.init(width: view.frame.width, height: view.frame.width)
        let bgImage = UIImage.init(named: "jesun")?.resizeImage(targetSize: imageSize)
        
        let bgImageView = UIImageView.init(image: bgImage)
        bgImageView.frame = CGRect.init(x: 0, y: 0, width: view.frame.width, height: view.frame.width)
        bgImageView.contentMode = .scaleAspectFill
        bgImageView.clipsToBounds = true
        self.bgImageView = bgImageView

        let textLabel = UILabel.init()
        textLabel.font = UIFont.init(customFont: .SDMiSaeng, withSize: 35)
        textLabel.text = text
        textLabel.numberOfLines = 0
        textLabel.textAlignment = .center
        textLabel.textColor = UIColor.white
        self.textLabel = textLabel
        
        let textView = UITextView()
        textView.isHidden = true
        textView.delegate = self
        textView.backgroundColor = UIColor.clear
        textView.font = textLabel.font
        textView.textColor = textLabel.textColor
        textView.textAlignment = .center
        self.textView = textView
        
        let toolbarFrame = CGRect.init(x: 0, y: 0, width: self.view.frame.size.width, height: 30)
        let toolbar: UIToolbar = UIToolbar.init(frame: toolbarFrame)
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBtn = UIBarButtonItem.init(title: "완료", style: .done, target: self, action: #selector(handleKeyboardDoneBtn))
        toolbar.setItems([flexSpace, doneBtn], animated: true)
        toolbar.sizeToFit()
        textView.inputAccessoryView = toolbar
        
        let edgeView = UIView()
        self.edgeView = edgeView
        edgeView.layer.borderWidth = 1.0
        edgeView.layer.borderColor = UIColor.white.cgColor
        
        self.view.addSubview(bgImageView)
        self.view.addSubview(edgeView)
        self.view.addSubview(textLabel)
        self.view.addSubview(textView)

        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        bgImageView.translatesAutoresizingMaskIntoConstraints = false
        edgeView.translatesAutoresizingMaskIntoConstraints = false
        
        if self.mode == .square{
            
            bgImageView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
            bgImageView.heightAnchor.constraint(equalTo: view.widthAnchor).isActive = true
            
            textLabel.topAnchor.constraint(equalTo: bgImageView.topAnchor, constant: Constants.Margin.base * 2).isActive = true
            textLabel.bottomAnchor.constraint(equalTo: bgImageView.bottomAnchor, constant: -Constants.Margin.base * 2).isActive = true
            textLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.Margin.base * 2).isActive = true
            textLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.Margin.base * 2).isActive = true
            
            edgeView.topAnchor.constraint(equalTo: bgImageView.topAnchor, constant: Constants.Margin.base * 2).isActive = true
            edgeView.bottomAnchor.constraint(equalTo: bgImageView.bottomAnchor, constant: -Constants.Margin.base * 2).isActive = true
            edgeView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.Margin.base * 2).isActive = true
            edgeView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.Margin.base * 2).isActive = true
            
        }else if self.mode == .movie {
            
            bgImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            bgImageView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
            bgImageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 9/16).isActive = true
            
            textLabel.font = UIFont.init(customFont: .SDMiSaeng, withSize: 25)
            textLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.Margin.base * 2).isActive = true
            textLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.Margin.base * 2).isActive = true
            textLabel.bottomAnchor.constraint(equalTo: bgImageView.bottomAnchor, constant: -Constants.Margin.base / 2).isActive = true
            
        }else if self.mode == .rectangle{
            
            bgImageView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
            bgImageView.heightAnchor.constraint(equalTo: view.widthAnchor).isActive = true
            
            textLabel.topAnchor.constraint(equalTo: bgImageView.bottomAnchor).isActive = true
            textLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            textLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            textLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/3).isActive = true
            textLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        }
        
        textView.topAnchor.constraint(equalTo: textLabel.topAnchor).isActive = true
        textView.leadingAnchor.constraint(equalTo: textLabel.leadingAnchor).isActive = true
        textView.trailingAnchor.constraint(equalTo: textLabel.trailingAnchor).isActive = true
        textView.bottomAnchor.constraint(equalTo: textLabel.bottomAnchor).isActive = true
        textView.heightAnchor.constraint(equalTo: textLabel.heightAnchor).isActive = true
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

extension CardContentViewController: UIGestureRecognizerDelegate{
    @objc func handleImageTap(_ sender: UITapGestureRecognizer? = nil){
        print("image tap")
        
        let imagePicker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary), let mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary){
            
            imagePicker.allowsEditing = true
            imagePicker.mediaTypes = mediaTypes
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @objc func handleTextLabelTap(_ sender: UITapGestureRecognizer? = nil){
        print("text tap")
        
        if let textLabel = self.textLabel{
            textLabel.isHidden = true
            textView?.isHidden = false
            textView?.text = textLabel.text
            textView?.becomeFirstResponder()
        }
    }
}

extension CardContentViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pickedImage = info[UIImagePickerControllerEditedImage] as? UIImage,
            let imageView = self.bgImageView {

            imageView.image = pickedImage
        }

        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)

    }
}

extension CardContentViewController: UITextViewDelegate{
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        
        textLabel?.isHidden = false

        if let textView = self.textView{
            textView.isHidden = true
            textLabel?.text = textView.text
        }
        return true
    }
    
//    func textViewShouldReturn(_ textView: UItextView) -> Bool {
//
//        textLabel?.isHidden = false
//
//        if let textView = self.textView{
//            textView.isEnabled = true
//            textLabel?.text = textView.text
//        }
//
//        return true
//    }
}
