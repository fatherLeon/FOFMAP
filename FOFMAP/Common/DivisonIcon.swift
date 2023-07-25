//
//  DivisonIcon.swift
//  FOFMAP
//
//  Created by 강민수 on 2023/07/25.
//

import SwiftUI

enum DivisionIcon {
    static func divisionIcon(_ id: Int) -> Image {
        switch id {
        case 800:
            return Image("SuperChamp")
        case 900:
            return Image("Champ")
        case 1000:
            return Image("SuperChallenger")
        case 1100:
            return Image("Challenger1")
        case 1200:
            return Image("Challenger2")
        case 1300:
            return Image("Challenger3")
        case 2000:
            return Image("WorldClass1")
        case 2100:
            return Image("WorldClass2")
        case 2200:
            return Image("WorldClass3")
        case 2300:
            return Image("Pro1")
        case 2400:
            return Image("Pro2")
        case 2500:
            return Image("Pro3")
        case 2600:
            return Image("SemiPro1")
        case 2700:
            return Image("SemiPro2")
        case 2800:
            return Image("SemiPro3")
        case 2900:
            return Image("Prospect1")
        case 3000:
            return Image("Prospect2")
        case 3100:
            return Image("Prospect3")
        default:
            return Image("Prospect3")
        }
    }
}
