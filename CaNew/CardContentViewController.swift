//
//  CardContentViewController.swift
//  CaNew
//
//  Created by 홍성호 on 2017. 9. 8..
//  Copyright © 2017년 홍성호. All rights reserved.
//

import UIKit

class CardContentViewController: UIViewController {

    var index = 0
    var iconImageView: UIImageView?
    var bgImageView: UIImageView?
    var name: String?{
        didSet{
            self.nameLabel?.text = name
//            if let name = self.name{
//                let attrString = NSMutableAttributedString(string: name, attributes: [NSBackgroundColorAttributeName: UIColor.init(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)])
//                self.nameLabel?.attributedText = attrString
//            }
        }
    }
    var subName: String?{
        didSet{
            self.subNameLabel?.text = subName
        }
    }
    var nameFontSize = 24
    var subNameFontSize = 20
    var nameLabel: UILabel?
    var subNameLabel: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setContentsView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setContentsView(){
        
        let bgImage = UIImage.init(named: "jesun")
        let bgImageView = UIImageView.init(image: bgImage)
        bgImageView.contentMode = .scaleAspectFit
        self.view.addSubview(bgImageView)
        self.bgImageView = bgImageView

        let iconImage = UIImage.init(named: "hello")
        let iconImageView = UIImageView.init(image: iconImage)
        iconImageView.contentMode = .scaleAspectFit
        self.view.addSubview(iconImageView)
        self.iconImageView = iconImageView
        
        let nameFrame = CGRect.init()
        let nameLabel = UILabel.init(frame: nameFrame)
        nameLabel.font = UIFont.init(customFont: .SDMiSaeng, withSize: 35)
        nameLabel.text = name
        nameLabel.backgroundColor = UIColor.init(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        nameLabel.numberOfLines = 0
        nameLabel.textAlignment = .center
        
        let nameLabelGesture = UIPanGestureRecognizer(target: self, action: #selector(self.tapNameLabel))
        nameLabel.isUserInteractionEnabled = true
        nameLabel.addGestureRecognizer(nameLabelGesture)

        self.view.addSubview(nameLabel)
        self.nameLabel = nameLabel
        
        let subNameFrame = CGRect.init()
        let subNameLabel = UILabel.init(frame: subNameFrame)
        subNameLabel.text = subName
        subNameLabel.numberOfLines = 0
        subNameLabel.textAlignment = .center
        self.view.addSubview(subNameLabel)
        self.subNameLabel = subNameLabel

        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        subNameLabel.translatesAutoresizingMaskIntoConstraints = false
        bgImageView.translatesAutoresizingMaskIntoConstraints = false

        let margins = view.layoutMarginsGuide
//        bgImageView.heightAnchor.constraint(lessThanOrEqualTo: margins.heightAnchor, multiplier: 1.0).isActive = true
//        bgImageView.widthAnchor.constraint(lessThanOrEqualTo: margins.widthAnchor, multiplier: 1.0).isActive = true
        bgImageView.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        bgImageView.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
        bgImageView.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 0.0).isActive = true
        bgImageView.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: 0.0).isActive = true
        
        iconImageView.heightAnchor.constraint(lessThanOrEqualTo: margins.heightAnchor, multiplier: 0.5).isActive = true
        iconImageView.widthAnchor.constraint(lessThanOrEqualTo: margins.widthAnchor, multiplier: 0.5).isActive = true
        iconImageView.centerXAnchor.constraint(equalTo: margins.centerXAnchor, constant: 0.0).isActive = true
        iconImageView.centerYAnchor.constraint(equalTo: margins.centerYAnchor, constant: 0.0).isActive = true

//        nameLabel.leadingAnchor.constraint(equalTo: bgImageView.leadingAnchor, constant: 16.0).isActive = true
//        nameLabel.trailingAnchor.constraint(equalTo: bgImageView.trailingAnchor,  constant: -16.0).isActive = true
//        nameLabel.topAnchor.constraint(equalTo: bgImageView.topAnchor, constant: 16.0).isActive = true
//        nameLabel.bottomAnchor.constraint(equalTo: bgImageView.bottomAnchor,  constant: 16.0).isActive = true
    
        nameLabel.widthAnchor.constraint(lessThanOrEqualTo: margins.widthAnchor, multiplier: 0.7).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: margins.centerXAnchor, constant: 0.0).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: margins.centerYAnchor, constant: 0.0).isActive = true
        
//        subNameLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 16.0).isActive = true
//        subNameLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor,  constant: -16.0).isActive = true
//        subNameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 16.0).isActive = true
//        subNameLabel.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -16.0).isActive = true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func tapNameLabel(sender:UITapGestureRecognizer){
        print("\(sender.location(in: sender.view))")
        dump(sender)
    }

}
