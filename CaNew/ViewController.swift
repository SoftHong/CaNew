//
//  ViewController.swift
//  CaNew
//
//  Created by 홍성호 on 2017. 9. 8..
//  Copyright © 2017년 홍성호. All rights reserved.
//

import UIKit

enum CardMode{
    case square, movie, diary, rectangle
}

class ViewController: UIViewController {
    
    var cardMode: CardMode = .square
    var pageVC: UIPageViewController?
    var cardContents = [CNCard]()
    var cardVCs = [CardContentViewController]()
    
    var pendingVC: CardContentViewController?
    var currentVC: CardContentViewController?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.setNavi()
        
        self.cardMode = .square
        
        let card1 = CNCard()
        card1.text = "안녕"
        card1.mode = self.cardMode
        
        let card2 = CNCard()
        card2.text = "안녕안녕"
        card2.mode = self.cardMode
        
        let card3 = CNCard()
        card3.text = "안녕안녕안녕"
        card3.mode = self.cardMode

        self.cardContents.append(card1)
        self.cardContents.append(card2)
        self.cardContents.append(card3)
        
        let cardVC1 = CardContentViewController()
        let cardVC2 = CardContentViewController()
        let cardVC3 = CardContentViewController()
        
        cardVC1.index = 0
        cardVC2.index = 1
        cardVC3.index = 2
        
        self.cardVCs.append(cardVC1)
        self.cardVCs.append(cardVC2)
        self.cardVCs.append(cardVC3)

        self.setPageVC()
        self.setupPageControl()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setNavi(){
        let prevPageBtn = UIBarButtonItem.init(title: "prev", style: .plain, target: self, action: #selector(goToPrevPage))

        let nextPageBtn = UIBarButtonItem.init(title: "next", style: .plain, target: self, action: #selector(goToNextPage))

        self.navigationItem.rightBarButtonItems = [nextPageBtn, prevPageBtn]
    }
    
    fileprivate func setPageVC(){
        let pageVC = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: [UIPageViewControllerOptionSpineLocationKey:UIPageViewControllerSpineLocation.mid])
        pageVC.dataSource = self
        pageVC.delegate = self
        
        let firstCard = self.cardContents[0]
        let firstCardVC = CardContentViewController()
        firstCardVC.parse(card: firstCard)

        pageVC.setViewControllers([firstCardVC], direction: .forward, animated: true, completion: nil)
        
        self.addChildViewController(pageVC)
        self.view.addSubview(pageVC.view)
        pageVC.didMove(toParentViewController: self)
        self.pageVC = pageVC
    
        let pageFrame = pageVC.view.layer.frame
        pageVC.view.layer.frame = CGRect.init(x: pageFrame.origin.x, y: pageFrame.origin.y, width: pageFrame.width, height: pageFrame.width)
        
        let margins = view.layoutMarginsGuide
        pageVC.view.translatesAutoresizingMaskIntoConstraints = false
        pageVC.view.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        pageVC.view.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        
        switch(self.cardMode){
        case .square:
            pageVC.view.heightAnchor.constraint(equalTo: margins.widthAnchor, multiplier: 1.0, constant: 40).isActive = true
        case .movie:
            pageVC.view.backgroundColor = UIColor.black
            pageVC.view.heightAnchor.constraint(equalTo: margins.widthAnchor, multiplier: 1.0, constant: 40).isActive = true
        case .diary, .rectangle:
            pageVC.view.heightAnchor.constraint(equalTo: margins.widthAnchor, multiplier: 1.5, constant: 40).isActive = true
        }
        
        pageVC.view.centerYAnchor.constraint(equalTo: margins.centerYAnchor).isActive = true
    }
    
    fileprivate func setupPageControl() {
        let appearance = UIPageControl.appearance()
        appearance.pageIndicatorTintColor = UIColor.lightGray
        appearance.currentPageIndicatorTintColor = UIColor.gray
        appearance.backgroundColor = UIColor.white
    }
    
//    fileprivate func updateIndex(){
//        for (index,element) in self.cardContents.enumerated(){
//            element.index = index
//        }
//    }
    
    @objc func goToNextPage(){
        
        guard let pageVC = self.pageVC else { return }
        guard let currentVC = pageVC.viewControllers?.first else { return }
        guard let nextVC =  pageVC.dataSource?.pageViewController(pageVC, viewControllerAfter: currentVC) as? CardContentViewController else { return }
        
        pageVC.setViewControllers([nextVC], direction: .forward, animated: true, completion: nil)
    }
    
    @objc func goToPrevPage(){
        
        guard let pageVC = self.pageVC else { return }
        guard let currentVC = pageVC.viewControllers?.first else { return }
        guard let prevVC = pageVC.dataSource?.pageViewController(pageVC, viewControllerBefore: currentVC) else { return }
        
        pageVC.setViewControllers([prevVC], direction: .reverse, animated: true, completion: nil)
    }
}

extension ViewController: UIPageViewControllerDelegate{
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if !completed{
            return
        }
        
        if let pendingVC = self.pendingVC{
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
                let currentCardVC = self.cardVCs[controller.index - 1]
                let currentCard = self.cardContents[controller.index - 1]
                
                currentCardVC.parse(card: currentCard)
                return currentCardVC
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let controller = viewController as? CardContentViewController {
            if controller.index < cardContents.count - 1 {
                let currentCardVC = self.cardVCs[controller.index + 1]
                currentCardVC.parse(card: self.cardContents[controller.index + 1])
                return currentCardVC
            }
        }
        
        return nil
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return cardContents.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        
        if let currentVC = pageViewController.viewControllers?.first as? CardContentViewController,
            let index = self.cardVCs.index(of: currentVC){
            return index
        }else{
            return 0
        }
    }
}
