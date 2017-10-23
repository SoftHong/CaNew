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
    var iconImageView: UIImageView?
    var bgImageView: UIImageView?
    var text: String?{
        didSet{
            if let textLabel = self.textLabel{
                textLabel.text = text
            }
        }
    }
    
    var textLabel: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setContentsView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func parse(card: CNCard){
        self.mode = card.mode
        self.text = card.text
    }
    
    func setContentsView(){

        let imageSize = CGSize.init(width: view.frame.width, height: view.frame.width)
        let bgImage = UIImage.init(named: "jesun")?.resizeImage(targetSize: imageSize)

        let bgImageView = UIImageView.init(image: bgImage)
        bgImageView.frame = CGRect.init(x: 0, y: 0, width: view.frame.width, height: view.frame.width)
        bgImageView.contentMode = .scaleAspectFill
        bgImageView.clipsToBounds = true
        self.view.addSubview(bgImageView)
        self.bgImageView = bgImageView

        let nameFrame = CGRect.init()
        let textLabel = UILabel.init(frame: nameFrame)
        textLabel.font = UIFont.init(customFont: .SDMiSaeng, withSize: 35)
        textLabel.text = text
//        textLabel.backgroundColor = UIColor.init(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        
        textLabel.numberOfLines = 0
        textLabel.textAlignment = .center
        textLabel.textColor = UIColor.white
        
        self.view.addSubview(textLabel)
        self.textLabel = textLabel
        
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        bgImageView.translatesAutoresizingMaskIntoConstraints = false
        
        
        if self.mode == .square{
            
            bgImageView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
            bgImageView.heightAnchor.constraint(equalTo: view.widthAnchor).isActive = true
            
            textLabel.layer.borderColor = UIColor.init(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).cgColor
            textLabel.layer.borderWidth = 1.0
            
            textLabel.topAnchor.constraint(equalTo: bgImageView.topAnchor, constant: Constants.Margin.base * 2).isActive = true
            textLabel.bottomAnchor.constraint(equalTo: bgImageView.bottomAnchor, constant: -Constants.Margin.base * 2).isActive = true
            textLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.Margin.base * 2).isActive = true
            textLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.Margin.base * 2).isActive = true
            
        }else if self.mode == .movie {
            
            textLabel.font = UIFont.init(customFont: .SDMiSaeng, withSize: 25)
            bgImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            bgImageView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
            bgImageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 9/16).isActive = true
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
