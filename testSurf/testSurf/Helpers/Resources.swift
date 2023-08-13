//
//  TitleResume.swift
//  testSurf
//
//  Created by Максим Сулим on 01.08.2023.
//

import UIKit


enum TitleResume: String {
    case profile = "Профиль"
    case skills = "Мои навыки"
    case about = "О себе"
}

enum Resources {
    enum Color {
        static var userGray = UIColor(hexString: "#96959B")
        static var bacgroundTop = UIColor(hexString: "#F3F3F5")
        static var text = UIColor(hexString: "#313131")
    }
}

enum ProfileTableRow: Int {
    case userInfoCell = 0
    case editSkillCell
    case skillsCell
    case aboutCell
}

enum EditUserTableRow: Int {
    case nameUserCell = 0
    case proffessionCell
    case locationUSerCell
    case aboutUserCell
}

