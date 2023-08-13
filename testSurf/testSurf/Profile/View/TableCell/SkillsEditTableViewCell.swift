//
//  SkillsEditTableViewCell.swift
//  testSurf
//
//  Created by Максим Сулим on 01.08.2023.
//

import UIKit

class SkillsEditTableViewCell: UITableViewCell {

    
    @IBOutlet weak var titleSkills: UILabel!
    
    @IBOutlet weak var buttonEdit: UIButton!
    
    @IBAction func tapEditSkills(_ sender: Any) {
        
        guard let indexCell = indexCell else {
            return
        }
        
        if delegate?.isEditingSkills == true {
            
            delegate?.isEditingSkills = false
            delegate?.useEditingSkills(indexCell: indexCell)
            
        } else if delegate?.isEditingSkills == false {
            
            delegate?.isEditingSkills = true
            delegate?.useEditingSkills(indexCell: indexCell)
        }
    }
    
    weak var delegate: UserDataProtocol?
    var isEdit: Bool?
    var indexCell: IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure() {
        titleSkills.text = TitleResume.skills.rawValue
        titleSkills.textColor = Resources.Color.text
        if delegate?.isEditingSkills == true {
            let image = UIImage(named: "Frame")
            self.buttonEdit.setImage(image, for: .normal)
            buttonEdit.contentMode = .scaleToFill
        } else {
            
            let image = UIImage(named: "FramePen")
            buttonEdit.setImage(image, for: .normal)
            buttonEdit.contentMode = .scaleToFill
        }
        
    }

}
