//
//  SkillCell.swift
//  testSurf
//
//  Created by Максим Сулим on 03.08.2023.
//

import UIKit

class SkillCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var backSkillView: UIImageView!
    
    @IBOutlet weak var titleSkillLable: UILabel!
    
    
    func configure() {
        backSkillView.layer.backgroundColor = Resources.Color.bacgroundTop.cgColor
        backSkillView.layer.cornerRadius = 12
        titleSkillLable.textColor = Resources.Color.text
    }
    
}
