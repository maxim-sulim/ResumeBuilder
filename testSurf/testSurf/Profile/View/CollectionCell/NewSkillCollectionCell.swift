//
//  NewSkillCollectionCell.swift
//  testSurf
//
//  Created by Максим Сулим on 01.08.2023.
//

import UIKit

class NewSkillCollectionCell: UICollectionViewCell {

    
    weak var delegate: UpdateSkillsColletcionProtocol?
    
    @IBOutlet weak var createButton: UIButton!
    
    
    @IBAction func tapCreateButton(_ sender: Any) {
        delegate?.presentCreate()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(isEditing: Bool) {
        if isEditing == false {
            createButton.isHidden = true
        } else {
            createButton.isHidden = false
        }
    }

}
