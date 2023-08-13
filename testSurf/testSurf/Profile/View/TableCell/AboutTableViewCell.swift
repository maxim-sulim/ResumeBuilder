//
//  AboutTableViewCell.swift
//  testSurf
//
//  Created by Максим Сулим on 01.08.2023.
//

import UIKit

class AboutTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var titleAbout: UILabel!
    
    @IBOutlet weak var aboutLable: UILabel!
    private var indexPathCell: IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configure(resume: Resume, indexPath: IndexPath) {
        titleAbout.text = TitleResume.about.rawValue
        titleAbout.textColor = Resources.Color.text
        aboutLable.text = resume.about
        aboutLable.textColor = Resources.Color.text
        indexPathCell = indexPath
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        aboutLable.layer.contentsGravity = .topLeft
    }
}
