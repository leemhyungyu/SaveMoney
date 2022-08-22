//
//  AppTabBarController.swift
//  SaveMoney
//
//  Created by 임현규 on 2022/06/19.
//

import UIKit

class AppTabbarController: UITabBarController {

    let homeTab: UITabBarItem = {
        
        let tabBarItem = UITabBarItem(
            title: "홈",
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill"))
        
        return tabBarItem
    }()
    
    let calendarTab: UITabBarItem = {
        
        let tabBarItem = UITabBarItem(
            title: "캘린더",
            image: UIImage(systemName: "calendar"),
            selectedImage: UIImage(systemName: "calendar.fill"))
        
        return tabBarItem
    }()

    let UserTab: UITabBarItem = {
        
        let tabBarItem = UITabBarItem(
            title: "마이페이지",
            image: UIImage(systemName: "person"),
            selectedImage: UIImage(systemName: "person.fill"))
        
        return tabBarItem
    }()
    
    override func viewDidLoad() {
           super.viewDidLoad()
           setting()
       }
    
    func setting() {
        
        let homeVC = UINavigationController(rootViewController: HomeViewController())
        
        let calendarVC = UINavigationController(rootViewController: CalendarViewController())
        
        let myPageVC = UINavigationController(rootViewController: MyPageViewController())
    
        tabBar.tintColor = .systemPink
        tabBar.backgroundColor = .white
        
        viewControllers = [homeVC, calendarVC, myPageVC]
        
        homeVC.tabBarItem = homeTab
        calendarVC.tabBarItem = calendarTab
        myPageVC.tabBarItem = UserTab
    }
}
