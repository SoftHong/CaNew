//
//  CardSettingTableView.swift
//  CaNew
//
//  Created by 홍성호 on 2017. 10. 10..
//  Copyright © 2017년 홍성호. All rights reserved.
//

import UIKit

protocol CardSettingTableViewDelegate{
    func tableView(didSelectRowAt indexPath: IndexPath)
}

class CardSettingTableView: UITableView, UITableViewDelegate, UITableViewDataSource {

    var customDelegate: CardSettingTableViewDelegate?
    var targetCard: CardContentViewController?{
        didSet{
            self.reloadData()
        }
    }
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
        self.estimatedRowHeight = 44.0
        self.rowHeight = UITableViewAutomaticDimension
        self.sectionHeaderHeight = 44.0
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
        
        if let targetCard = targetCard{
            if indexPath.section == 0, let name = targetCard.name{
                cell.textLabel?.text = name
            }else if indexPath.section == 1, let subName = targetCard.subName{
                cell.textLabel?.text = subName
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.deselectRow(at: indexPath, animated: true)
        self.customDelegate?.tableView(didSelectRowAt: indexPath)
    }
    

}
