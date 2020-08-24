//
//  CardCell.swift
//  HomytTaskCards
//
//  Created by Qasem Zreaq on 8/24/20.
//  Copyright © 2020 Qasem Zreaq. All rights reserved.
//

import UIKit

protocol CellButton: class {
    
    func ButtonPressed (index:Int, buttonName: String)
}

//MARK:- class Cell

class CardCell: UICollectionViewCell {
    @IBOutlet weak var cardImage: UIImageView!
    @IBOutlet weak var LikeB: UIButton!
    @IBOutlet weak var DisLikeB: UIButton!
    
    override func awakeFromNib() {

        LikeB.layer.cornerRadius = LikeB.frame.size.height / 4
        DisLikeB.layer.cornerRadius = DisLikeB.frame.size.height / 4

        

    }
    
    weak var cellDelegate : CellButton?
    var index : IndexPath?

    @IBAction func Like(_ sender: UIButton) {
        
        cellDelegate?.ButtonPressed(index: (index?.row)!,buttonName:(sender.titleLabel?.text)!)
    }
    
    @IBAction func DisLike(_ sender: UIButton) {
        
        cellDelegate?.ButtonPressed(index: (index?.row)!,buttonName:(sender.titleLabel?.text)!)

    }
    
}
