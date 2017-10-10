//
//  ViewController.swift
//  CaNew
//
//  Created by 홍성호 on 2017. 9. 8..
//  Copyright © 2017년 홍성호. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPageViewControllerDataSource {
    
    var pageVC: UIPageViewController?
    var cardContents = [CardContentViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let originFrame = self.view.frame
        let cardFrame = CGRect(x: originFrame.origin.x, y: originFrame.origin.y, width: originFrame.size.width/2, height: originFrame.size.height/2)
        
        let card1 = CardContentViewController()
        card1.index = 0
        card1.view.backgroundColor = UIColor.gray
        card1.view.frame = cardFrame
        
        let card2 = CardContentViewController()
        card2.index = 1
        card2.view.backgroundColor = UIColor.orange
        card2.view.frame = cardFrame
        
        let card3 = CardContentViewController()
        card3.index = 2
        card3.view.backgroundColor = UIColor.green
        card3.view.frame = cardFrame
        
        self.cardContents.append(card1)
        self.cardContents.append(card2)
        self.cardContents.append(card3)
        
        self.setPageVC()
        self.setupPageControl()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setPageVC(){
        let pageVC = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: [UIPageViewControllerOptionSpineLocationKey:UIPageViewControllerSpineLocation.mid])
        pageVC.dataSource = self
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
    
    private func setupPageControl() {
        let appearance = UIPageControl.appearance()
        appearance.pageIndicatorTintColor = UIColor.gray
        appearance.currentPageIndicatorTintColor = UIColor.white
        appearance.backgroundColor = UIColor.darkGray
    }
    
    // MARK: - UIPageViewControllerDataSource
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
    
    // MARK: - Page Indicator
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return cardContents.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
}
