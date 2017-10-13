//
//  ViewController.swift
//  CaNew
//
//  Created by 홍성호 on 2017. 9. 8..
//  Copyright © 2017년 홍성호. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var pageVC: UIPageViewController?
    var cardContents = [CardContentViewController]()
    var settingTableView: CardSettingTableView?
    var pendingVC: CardContentViewController?
    var currentVC: CardContentViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let originFrame = self.view.frame
        let cardFrame = CGRect(x: originFrame.origin.x, y: originFrame.origin.y, width: originFrame.size.width/2, height: originFrame.size.height/2)
        
        let card1 = CardContentViewController()
        card1.name = "안녕"
        card1.view.frame = cardFrame
        
        let card2 = CardContentViewController()
        card2.name = "안녕안녕"
        card2.view.frame = cardFrame
        
        let card3 = CardContentViewController()
        card3.name = "안녕안녕안녕"
        card3.view.frame = cardFrame

        
        self.cardContents.append(card1)
        self.cardContents.append(card2)
        self.cardContents.append(card3)

        self.updateIndex()
        self.setPageVC()
        self.setupPageControl()
        self.setSettingTableView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func updateSettingTableView(targetCard: CardContentViewController){
        self.settingTableView?.targetCard = targetCard
    }
    
    fileprivate func setSettingTableView(){
        
        // init
        let settingTableView = CardSettingTableView.init()
        settingTableView.customDelegate = self
        self.settingTableView = settingTableView
        self.view.addSubview(settingTableView)
        if cardContents.count > 0{
            settingTableView.targetCard = cardContents[0]
            self.currentVC = settingTableView.targetCard
        }
        
        // auto layout
        settingTableView.translatesAutoresizingMaskIntoConstraints = false
        let margins = view.layoutMarginsGuide
        settingTableView.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        settingTableView.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        settingTableView.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
        if let pageVC = self.pageVC{
            settingTableView.topAnchor.constraint(equalTo: pageVC.view.bottomAnchor).isActive = true
        }else{
            settingTableView.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        }
    }
    
    fileprivate func setPageVC(){
        let pageVC = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: [UIPageViewControllerOptionSpineLocationKey:UIPageViewControllerSpineLocation.mid])
        pageVC.dataSource = self
        pageVC.delegate = self
        pageVC.setViewControllers([self.cardContents[0]], direction: .forward, animated: true, completion: nil)
        
        self.addChildViewController(pageVC)
        self.view.addSubview(pageVC.view)
        pageVC.didMove(toParentViewController: self)
        self.pageVC = pageVC
    
        let margins = view.layoutMarginsGuide
        pageVC.view.translatesAutoresizingMaskIntoConstraints = false
        pageVC.view.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        pageVC.view.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        pageVC.view.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        pageVC.view.heightAnchor.constraint(equalTo: margins.widthAnchor).isActive = true
    }
    
    fileprivate func setupPageControl() {
        let appearance = UIPageControl.appearance()
        appearance.pageIndicatorTintColor = UIColor.lightGray
        appearance.currentPageIndicatorTintColor = UIColor.gray
//        appearance.backgroundColor = UIColor.darkGray
    }
    
    fileprivate func updateIndex(){
        for (index,element) in self.cardContents.enumerated(){
            element.index = index
        }
    }
}

extension ViewController: UIPageViewControllerDelegate{
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if !completed{
            return
        }
        
        if let pendingVC = self.pendingVC{
            self.updateSettingTableView(targetCard: pendingVC)
            self.currentVC = pendingVC
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        
        if pendingViewControllers.count > 0, let pendingVC = pendingViewControllers[0] as? CardContentViewController{
            self.pendingVC = pendingVC
        }
    }
}



extension ViewController: UIPageViewControllerDataSource{
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let controller = viewController as? CardContentViewController {
            if controller.index > 0 {
                return cardContents[controller.index - 1]
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let controller = viewController as? CardContentViewController {
            if controller.index < cardContents.count - 1 {
                return cardContents[controller.index + 1]
            }
        }
        return nil
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return cardContents.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
}

extension ViewController: CardSettingTableViewDelegate{
    
    func tableView(didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0{
            self.showNameAlert()
        }else if indexPath.section == 1{
            self.showSubNameAlert()
        }
    }
    
    func showNameAlert(){
        
        let alert = UIAlertController(title: "제목", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "확인", style: UIAlertActionStyle.default, handler: { _ in
            if let textFields = alert.textFields, textFields.count > 0, let text = textFields[0].text, let currentVC = self.currentVC{
                
                currentVC.name = text
                self.settingTableView?.reloadData()
            }
        }))
        alert.addTextField(configurationHandler: {(textField: UITextField!) in
            
            if let currentVC = self.currentVC, let nameText = currentVC.name, nameText != ""{
                textField.text = nameText
            }else{
                textField.placeholder = "제목을 입력해주세요"
            }
        })
        self.present(alert, animated: true, completion: nil)
    }
    
    func showSubNameAlert(){
        let alert = UIAlertController(title: "설명", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "확인", style: UIAlertActionStyle.default, handler: { _ in
            if let textFields = alert.textFields, textFields.count > 0, let text = textFields[0].text, let currentVC = self.currentVC{
                
                currentVC.subName = text
                self.settingTableView?.reloadData()
            }
        }))
        alert.addTextField(configurationHandler: {(textField: UITextField!) in
            
            if let currentVC = self.currentVC, let subNameText = currentVC.subName, subNameText != ""{
                textField.text = subNameText
            }else{
                textField.placeholder = "설명을 입력해주세요"
            }
        })
        self.present(alert, animated: true, completion: nil)
    }
}
