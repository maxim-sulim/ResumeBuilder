//
//  EditSkillCell.swift
//  testSurf
//
//  Created by Максим Сулим on 03.08.2023.
//

import UIKit

class EditSkillCollectionCell: UICollectionViewCell {
    
    weak var delegate: UpdateSkillsColletcionProtocol?
    
    @IBOutlet weak var backEditSkilllView: UIImageView!
    @IBOutlet weak var buttonEdit: UIButton!
    @IBOutlet weak var titleEditSkillLable: UILabel!
    
    @IBAction func tabButtonEdit(_ sender: Any) {
        
        delegate?.deleteSkill(index: buttonEdit.tag)
    }
    
    func configure(index: Int) {
        backEditSkilllView.layer.backgroundColor = Resources.Color.bacgroundTop.cgColor
        backEditSkilllView.layer.cornerRadius = 12
        titleEditSkillLable.textColor = Resources.Color.text
        let image = UIImage(named: "deleteImage")
        buttonEdit.setImage(image, for: .normal)
        buttonEdit.tag = index
    }
}
