//
//  ViewController.swift
//  testSurf
//
//  Created by Максим Сулим on 31.07.2023.
//

import UIKit

protocol UserDataProtocol: AnyObject {
    var user: Resume { get set }
    var isEditingSkills: Bool { get set }
    func useEditingSkills(indexCell: IndexPath)
    func createSkill()
    func updateSkillsRow()
    func addPhotoUser()
    func deleteSkill(index: Int)
    func saveEditProfile(editProfile: Resume)
}

class MainViewController: UIViewController, UserDataProtocol {

    private var heightCellAbout = CGFloat(150)
    private var heightCellSkills = CGFloat(150)
    
    weak var delegate: UpdateSkillsColletcionProtocol?
    weak var imageUserDelegate: UpdateImageUserProtocol?
    
    private var storage: StorageUserProtocol = StorageUser()
    internal var user = Resume.developer()
    
    var isEditingSkills = false
    
    private var profileview: ProfileView! {
        guard isViewLoaded else {
            return nil
        }
        return (view as! ProfileView )
    }
    
    
    override func loadView() {
        super.loadView()
        loadUserData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowEdit" {
            
            let vc = segue.destination as? EditProfileController
            vc?.delegate = self
            
        }
    }
    
}


//MARK: metodths
extension MainViewController {
    
  private func updateHeightAboutRow() {
        let widht = profileview.tableView.frame.width
        let font = UIFont(name: "Helvetica", size: 15)
        let heightRow = user.about.height(withConstrainedWidth: widht, font: font!)
        heightCellAbout = CGFloat(heightRow + 150)
    }
    
   private func updateHeightSkillsRow() {
       
       let widhtScene = self.profileview.tableView.frame.size.width - 48
       var sumWidhtSkills: CGFloat = 0
       let heightSkill = CGFloat(68)
       
       
       if isEditingSkills == false {
           
           for i in user.skills {
               sumWidhtSkills += i.width(withConstrainedHeight: heightSkill, font: UIFont(name: "Helvetica", size: 15)!) * 1.2
           }
           
       } else {
           
           for i in user.skills {
               sumWidhtSkills += (i.width(withConstrainedHeight: heightSkill, font: UIFont(name: "Helvetica", size: 15)!) * 1.2) + 10 + 24
           }
           
       }
       
       let countRowCollectionCell =  (sumWidhtSkills + (CGFloat(user.skills.count * 72)) + 74) / widhtScene
       let resultHeightTableRowSkills = (Int(heightSkill) * Int(countRowCollectionCell))
       
       if resultHeightTableRowSkills > 100 {
           heightCellSkills = CGFloat(resultHeightTableRowSkills)
       } else {
           heightCellSkills = 100
       }
       
    }
    
    func updateSkillsRow() {
        updateHeightSkillsRow()
        self.profileview.tableView.reloadData()
    }
    
    func useEditingSkills(indexCell: IndexPath) {
        updateHeightSkillsRow()
        profileview.tableView.reloadRows(at: [indexCell], with: .none)
        delegate?.updaateSkills()
    }
    
    func deleteSkill(index: Int) {
        storage.deleteSkill(skill: user.skills[index])
        loadUserData()
        delegate?.updaateSkills()
        updateSkillsRow()
    }
    
    func saveEditProfile(editProfile: Resume) {
        storage.save(resumeUser: editProfile)
        loadUserData()
        self.profileview.tableView.reloadData()
    }
}

//MARK: configure controller
extension MainViewController {
    
   private func configure() {
        configureNavigation()
        profileview.tableView.backgroundColor = Resources.Color.bacgroundTop
        profileview.tableView.delegate = self
        profileview.tableView.dataSource = self
        updateHeightAboutRow()
        updateHeightSkillsRow()
    }
    
    func loadUserData() {
        user = storage.load()
    }
    
   private func configureNavigation() {
        self.navigationItem.title = TitleResume.profile.rawValue
        self.navigationItem.titleView?.tintColor = Resources.Color.text
        self.navigationItem.titleView?.tintColor = .black
        self.navigationItem.rightBarButtonItem?.tintColor = .black
        self.navigationItem.rightBarButtonItem?.title = "Ред."
    }
    
}


//MARK: work alert

extension MainViewController {
    
    func createSkill() {
        
        let alertController = UIAlertController(title: "Добавление навыка",
                                                message: "Введите название навыка которым вы владеете", preferredStyle: .alert)
        
        alertController.addTextField {textField in
            textField.placeholder = "Введите название"
        }
        
        let appContact = UIAlertAction(title: "Добавить", style: .default) {_ in
            let result = alertController.textFields?[0].text ?? ""
            self.user.skills.append(result)
            self.storage.insertNewSkill(skill: result)
            
            self.delegate?.updaateSkills()
            self.updateHeightSkillsRow()
            self.profileview.tableView.reloadData()
        }
        
        let cancel = UIAlertAction(title: "Отмена", style: .cancel)
        alertController.addAction(appContact)
        alertController.addAction(cancel)
        self.present(alertController, animated: true)
        
    }
    
    func addPhotoUser() {
        
        let actionSheetController = UIAlertController(title: nil,
                                                      message: nil,
                                                      preferredStyle: .actionSheet)
        
        let photo = UIAlertAction(title: "Фото", style: .default) {_ in
            
            self.chooseImagePicker(source: UIImagePickerController.SourceType.photoLibrary)
        }
        
        let cancel = UIAlertAction(title: "Отмена", style: .cancel)
        
        actionSheetController.addAction(photo)
        actionSheetController.addAction(cancel)
        
        present(actionSheetController, animated: true)
        
    }
    
    
}

//MARK: work image

extension MainViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
   private func chooseImagePicker(source: UIImagePickerController.SourceType) {
        
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker , animated: true)
        }
        
    }
    
     func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as? UIImage
        user.imageUser = (image?.pngData())!
        self.profileview.tableView.reloadData()
        dismiss(animated: true)
    }
    
}


//MARK: work table delegate

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0: return 290
        case 1: return 60
        case 2: return heightCellSkills
        case 3: return heightCellAbout
            
        default:
            return 50
        }
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         4
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         return configureCell(tableView: tableView, indexPath: indexPath)
    }
    
    
    private func configureCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        switch indexPath.row {
        case ProfileTableRow.userInfoCell.rawValue:
            
            guard let newCell = tableView.dequeueReusableCell(withIdentifier: "UserInfoTableViewCell", for: indexPath) as?
                UserInfoTableViewCell else {
                break
            }
            newCell.delegate = self
            newCell.configure(resume: user)
            cell = newCell
            
        case ProfileTableRow.editSkillCell.rawValue:
            
            guard let newCell = tableView.dequeueReusableCell(withIdentifier: "SkillsEditTableViewCell", for: indexPath) as? SkillsEditTableViewCell else {
                break
            }
                newCell.delegate = self
                newCell.indexCell = indexPath
                newCell.configure()
                cell = newCell
            
        case ProfileTableRow.skillsCell.rawValue:
            
            guard let newCell = tableView.dequeueReusableCell(withIdentifier: "SkillsTableViewCell", for: indexPath) as? SkillsTableViewCell else {
                break
            }
                newCell.delegate = self
                delegate = newCell
                newCell.configure()
                cell = newCell
            
        case ProfileTableRow.aboutCell.rawValue:
            
            guard let newCell = tableView.dequeueReusableCell(withIdentifier: "AboutTableViewCell", for: indexPath) as? AboutTableViewCell else {
                break
            }
                newCell.configure(resume: user, indexPath: indexPath)
                cell = newCell

        default:
            return cell
        }
        
        return cell
    }
    
}
