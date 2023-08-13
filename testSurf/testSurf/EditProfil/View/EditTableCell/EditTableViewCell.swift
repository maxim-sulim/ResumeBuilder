//
//  EditTableViewCell.swift
//  testSurf
//
//  Created by Максим Сулим on 06.08.2023.
//

import UIKit

enum ElementEditProfil: Int {
    case name = 0
    case profession
    case location
}

class EditTableViewCell: UITableViewCell {

    weak var delegate: UpdateButtonProtocol?
    @IBOutlet weak var textFieldEdit: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configure(user: Resume, rowIndex: Int) {
        textFieldEdit.delegate = self
        textFieldEdit.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        
        switch rowIndex {
        case EditUserTableRow.nameUserCell.rawValue:
            
            textFieldEdit.placeholder = user.nameUser
            textFieldEdit.tag = ElementEditProfil.name.rawValue
            
        case EditUserTableRow.proffessionCell.rawValue:
            
            textFieldEdit.placeholder = user.profession
            textFieldEdit.tag = ElementEditProfil.profession.rawValue
            
        case EditUserTableRow.locationUSerCell.rawValue:
            
            textFieldEdit.placeholder = user.city
            textFieldEdit.tag = ElementEditProfil.location.rawValue
            
        default:
            textFieldEdit.placeholder = "сюда"
        }
    }

}

extension EditTableViewCell: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc private func textFieldChanged () {
        
        if textFieldEdit.text?.isEmpty == false {
            delegate?.isEnabledButtonSave = true
            
            switch textFieldEdit.tag {
                
            case ElementEditProfil.name.rawValue:
                delegate?.editProfile?.nameUser = textFieldEdit.text!
            case ElementEditProfil.profession.rawValue:
                delegate?.editProfile?.profession = textFieldEdit.text!
            case ElementEditProfil.location.rawValue:
                delegate?.editProfile?.city = textFieldEdit.text!
                
            default:
                break
            }
            
        } else {
            delegate?.isEnabledButtonSave = false
        }
        
    }
    
}
