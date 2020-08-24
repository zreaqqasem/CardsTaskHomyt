//
//  ViewController.swift
//  HomytTaskCards
//
//  Created by Qasem Zreaq on 8/24/20.
//  Copyright © 2020 Qasem Zreaq. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController,showNotification,UNUserNotificationCenterDelegate {
    
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var CardsCollection: UICollectionView!
    var cards = [Card]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        loadCards()
        profilePicture.layer.cornerRadius = profilePicture.frame.size.height / 2
        CardsCollection.dataSource = self
        CardsCollection.delegate = self
        AppDelegate.notificationDelegate? = self
    }
    
    

    func loadCards () {
        
        let card1 = Card(name: "card1")
        let card2 = Card(name: "card2")
        let card3 = Card(name: "card3")
        let card4 = Card(name: "card4")
        cards.append(card1)
        cards.append(card2)
        cards.append(card3)
        cards.append(card4)

        
    }
    
    func showLocalNotification() {
                
        // create notification content
        
            let content = UNMutableNotificationContent()
            content.title = "Image Got Liked!"
            content.body = "Awsome You Like An Image!"
            content.sound = UNNotificationSound.default
        // triger the notification
        
        let triger = UNTimeIntervalNotificationTrigger(timeInterval: 0.2, repeats: false)

        // make a request for notification
            
        let request = UNNotificationRequest(identifier: "Homyt", content: content, trigger: triger)
            
        // make the request
            
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
        
        
    }
    

}

//MARK:- collection view dataSource and Delegate

extension ViewController: UICollectionViewDataSource,UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = CardsCollection.dequeueReusableCell(withReuseIdentifier: "CardId", for: indexPath) as! CardCell
        cell.cellDelegate = self
        cell.index = indexPath
        if let cardName = cards[indexPath.row].name {
            
            cell.cardImage.image = UIImage(named: cardName)
        }
        
        return cell
        
    }
    
    
}

//MARK: - for delegate using for passing data between cell and view controller.

extension ViewController : CellButton {
    
    func ButtonPressed(index: Int, buttonName: String) {
        
        print(buttonName)
        
        if buttonName == "DisLike" {
            guard let indexPath = CardsCollection.indexPathsForVisibleItems.first.flatMap({
                IndexPath(item: index + 1, section: $0.section)
            }), CardsCollection.cellForItem(at: indexPath) != nil else {
                UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: ["Homyt"])
            
                return

            }
            CardsCollection.scrollToItem(at: indexPath, at: .left, animated: true)
        }
        
        else {
            showLocalNotification()
            
        }
    }
    
}
