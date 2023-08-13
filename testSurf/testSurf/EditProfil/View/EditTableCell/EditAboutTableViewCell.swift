//
//  EditAboutTableViewCell.swift
//  testSurf
//
//  Created by Максим Сулим on 06.08.2023.
//

import UIKit

class EditAboutTableViewCell: UITableViewCell {

    weak var delegate: UpdateButtonProtocol?
    
    @IBOutlet weak var aboutLable: UILabel!
    @IBOutlet weak var aboutTextView: UITextView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(text: String) {
        aboutTextView.delegate = self
        aboutTextView.text = text
        aboutTextView.contentInset = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
    }

}

extension EditAboutTableViewCell: UITextViewDelegate {
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        aboutTextView.resignFirstResponder()
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        delegate?.editProfile?.about = aboutTextView.text
    }
    
}
