//
//  CardSettingTableView.swift
//  CaNew
//
//  Created by 홍성호 on 2017. 10. 10..
//  Copyright © 2017년 홍성호. All rights reserved.
//

import UIKit

class CardSettingTableView: UITableView {

    var targetCard: CardContentViewController?
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    init(){
        super.init(frame: CGRect.zero, style: .plain)
        
        self.delegate = self as? UITableViewDelegate
        self.dataSource = self as? UITableViewDataSource
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension CardContentViewController: UITableViewDelegate{
    
}

extension CardContentViewController: UITableViewDataSource{

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return UITableViewCell.init()
    }
}
