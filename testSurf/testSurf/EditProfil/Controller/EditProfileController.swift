//
//  EditProfile.swift
//  testSurf
//
//  Created by Максим Сулим on 06.08.2023.
//

import UIKit

protocol UpdateButtonProtocol: AnyObject {
    var isEnabledButtonSave: Bool? { get set }
    var editProfile: Resume? { get set }
}

class EditProfileController: UIViewController, UpdateButtonProtocol {

   weak var delegate: UserDataProtocol?
   var editProfile: Resume?
    
    var isEnabledButtonSave: Bool? {
        didSet {
            updateStateButtonSave()
        }
    }
        
    
   private var editView: EditProfileView! {
       guard isViewLoaded else {
           return nil
       }
       return (view as! EditProfileView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        editProfile = delegate?.user
    }
    

    @IBAction func saveEditProfile(_ sender: Any) {
        
        if let nameUser = editProfile?.nameUser {
            editProfile?.nameUser = nameUser
        }
        if let profession = editProfile?.profession {
            editProfile?.profession = profession
        }
        if let location = editProfile?.city {
            editProfile?.city = location
        }
        if let about = editProfile?.about {
            editProfile?.about = about
        }
        
        delegate?.saveEditProfile(editProfile: editProfile!)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    private func updateStateButtonSave() {
        if isEnabledButtonSave == true {
            self.navigationItem.rightBarButtonItem?.isEnabled = true
        } else {
            self.navigationItem.rightBarButtonItem?.isEnabled = false
            
        }
    }
    
    
}

extension EditProfileController {
    
    private func configureNavigateItem() {
        
        if let topItem = navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            topItem.backBarButtonItem?.tintColor = .black
        }
        self.navigationItem.rightBarButtonItem?.tintColor = .black
        self.navigationItem.rightBarButtonItem?.title = "Сохранить"
        self.navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    private func configure() {
        
        configureNavigateItem()
        editView.tableView.delegate = self
        editView.tableView.dataSource = self
    }
    
}

extension EditProfileController: UITableViewDelegate, UITableViewDataSource {
    
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == EditUserTableRow.aboutUserCell.rawValue {
            return 300
        } else {
            return 50
        }
    }
    
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        
        switch indexPath.row {
            
        case EditUserTableRow.nameUserCell.rawValue,
            EditUserTableRow.proffessionCell.rawValue,
            EditUserTableRow.locationUSerCell.rawValue:
            
            let newCell = tableView.dequeueReusableCell(withIdentifier: "EditTableViewCell", for: indexPath) as! EditTableViewCell
            newCell.delegate = self
            newCell.configure(user: delegate!.user, rowIndex: indexPath.row)
            cell = newCell
            
        case EditUserTableRow.aboutUserCell.rawValue:
            let newCell = tableView.dequeueReusableCell(withIdentifier: "EditAboutTableViewCell", for: indexPath) as!
            EditAboutTableViewCell
            newCell.delegate = self
            newCell.configure(text: delegate?.user.about ?? "кто я")
            cell = newCell
            
        default:
            break
        }
        
        return cell
    }
    
    
}
