//
//  UserInfoTableViewCell.swift
//  testSurf
//
//  Created by Максим Сулим on 01.08.2023.
//

import UIKit

protocol UpdateImageUserProtocol: AnyObject {
    func updateImage(image: UIImage)
}

class UserInfoTableViewCell: UITableViewCell, UpdateImageUserProtocol {

   private struct UserInfo {
        var image: Data
        var name: String
        var profession: String
        var city: String
    }
    
    weak var delegate: UserDataProtocol?
    
    @IBOutlet weak var backView: UIImageView!
    @IBOutlet weak var imageUser: UIImageView!
    @IBOutlet weak var nameUser: UILabel!
    @IBOutlet weak var professionUser: UILabel!
    @IBOutlet weak var cityUser: UILabel!
    @IBOutlet weak var pinLocationImage: UIImageView!
    
    
    @IBAction func addPhotoUSer(_ sender: Any) {
        delegate?.addPhotoUser()
    }
    
    func updateImage(image: UIImage) {
        self.imageUser.image = image
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    func configure(resume: Resume) {
        
        let user = UserInfo(image: resume.imageUser,
                            name: resume.nameUser,
                            profession: resume.profession,
                            city: resume.city)
        
        backView.layer.backgroundColor = Resources.Color.bacgroundTop.cgColor
        let widht = imageUser.frame.width
        imageUser.image = UIImage(data: user.image)
        imageUser.layer.cornerRadius = widht / 2
        imageUser.contentMode = .scaleAspectFill
        imageUser.clipsToBounds = true
        
        nameUser.text = user.name
        nameUser.textColor = Resources.Color.text
        professionUser.text = user.profession
        professionUser.textColor = Resources.Color.userGray
        cityUser.text = user.city
        cityUser.textColor = Resources.Color.userGray
        let image = UIImage(named: "Frame-3")
        pinLocationImage.image = image
        pinLocationImage.contentMode = .scaleToFill
    }

}
