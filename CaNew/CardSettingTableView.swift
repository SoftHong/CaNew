//
//  CardSettingTableView.swift
//  CaNew
//
//  Created by 홍성호 on 2017. 10. 10..
//  Copyright © 2017년 홍성호. All rights reserved.
//

import UIKit

class CardSettingTableView: UITableView, UITableViewDelegate, UITableViewDataSource {

    var targetCard: CardContentViewController?
    let reuseCellId = "reuseCardSettingCellId"
    let sections = ["제목", "설명"]
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    init(){
        super.init(frame: CGRect.zero, style: .plain)
        self.delegate = self
        self.dataSource = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let sectionLabel = UILabel.init()
        sectionLabel.text = self.sections[section]
        
        return sectionLabel
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell.init()
        if let reuseableCell = self.dequeueReusableCell(withIdentifier: reuseCellId){
            cell = reuseableCell
        }
        
        if let targetCard = targetCard, let name = targetCard.name{
            cell.textLabel?.text = name
            print("hi")
        }

        
        return cell
    }
}
