//
//  SkillsTableViewCell.swift
//  testSurf
//
//  Created by Максим Сулим on 01.08.2023.
//

import UIKit

protocol UpdateSkillsColletcionProtocol: AnyObject {
    func updaateSkills()
    func presentCreate()
    func deleteSkill(index: Int)
}

class SkillsTableViewCell: UITableViewCell, UpdateSkillsColletcionProtocol {

    
    weak var delegate: UserDataProtocol?
    @IBOutlet weak var colletctionView: UICollectionView!
    
    
     func updaateSkills() {
        colletctionView.reloadData()
    }
    
     func deleteSkill(index: Int) {
        delegate?.deleteSkill(index: index)
        delegate?.updateSkillsRow()
    }
    
    func presentCreate() {
        delegate?.createSkill()
        updaateSkills()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure() {
        colletctionView.delegate = self
        colletctionView.dataSource = self
        let cellCreateSkillTypeNib = UINib(nibName: "NewSkillCollectionCell", bundle: nil)
        colletctionView.register(cellCreateSkillTypeNib, forCellWithReuseIdentifier: "NewSkillCollectionCell")
        colletctionView.collectionViewLayout = configureCollectionLayout()
    }
    
    func configureCollectionLayout() -> UICollectionViewCompositionalLayout {
        
            let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .estimated(120), heightDimension: .estimated(44)))
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(250)), subitems: [item])
            group.interItemSpacing = .fixed(12)
            
            let section = NSCollectionLayoutSection(group: group)
        
            section.interGroupSpacing = 12
            section.contentInsets = .init(top: 12, leading: 12, bottom: 12, trailing: 12)
            
        
        return UICollectionViewCompositionalLayout(section: section)
    }
}

//MARK: collection delegate work
extension SkillsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let count = (delegate?.user.skills.count ?? -1) + 1
        
       return count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
      return configureCell(collectionView: collectionView, indexPath: indexPath)
        
    }
    
    private func configureCell(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell = UICollectionViewCell()
        
        if indexPath.row == delegate?.user.skills.count {
            
            guard let newCell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewSkillCollectionCell", for: indexPath) as? NewSkillCollectionCell else {
                return cell
            }
            newCell.configure(isEditing: delegate?.isEditingSkills ?? false)
            newCell.delegate = self
            cell = newCell
        } else {
            
            if delegate?.isEditingSkills == true {
                
                guard let newCell = collectionView.dequeueReusableCell(withReuseIdentifier: "EditSkillCollectionCell", for: indexPath) as? EditSkillCollectionCell else {
                    return cell
                }
                newCell.titleEditSkillLable.text = delegate?.user.skills[indexPath.row]
                newCell.delegate = self
                newCell.configure(index: indexPath.row)
                cell = newCell
                
                
            } else {
                
                guard let newCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SkillCollectionCell", for: indexPath) as? SkillCollectionCell else {
                    return cell
                }
                newCell.titleSkillLable.text = delegate?.user.skills[indexPath.row]
                newCell.configure()
                cell = newCell
            }
        }
        
        return cell
    }
    
}



