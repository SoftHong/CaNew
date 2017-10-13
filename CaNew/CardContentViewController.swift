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
    var name: String?{
        didSet{
            self.nameLabel?.text = name
        }
    }
    var body: String?
    var nameLabel: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setContentsView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setContentsView(){
        
        if let name = self.name{
            
            let nameFrame = CGRect.init(x: self.view.frame.origin.x, y: self.view.frame.origin.y, width: self.view.frame.width, height: self.view.frame.height)
            let nameLabel = UILabel.init(frame: nameFrame)
            nameLabel.text = name
            nameLabel.textAlignment = .center
            self.view.addSubview(nameLabel)
            self.nameLabel = nameLabel
            
            nameLabel.translatesAutoresizingMaskIntoConstraints = false
            let margins = view.layoutMarginsGuide
            nameLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 16.0).isActive = true
            nameLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor,  constant: -16.0).isActive = true
            nameLabel.centerYAnchor.constraint(equalTo: margins.centerYAnchor).isActive = true
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
