//
//  EyeshadowItem.swift
//  MPFinal
//
//  Created by 陳映紅 on 2018/6/8.
//  Copyright © 2018年 陳映紅. All rights reserved.
//

import Foundation

struct EyeshadowItem {
    var type: Int?           //0 for eyebrow, 1 for eyeshadow
    var id: Int?             //id of eyeshadow
    var stepCount: Int?
    var step: [Int]         //type of line (for eyeshadow)
    var color: [Int]        //color of eyeshadow
    
    init(type: Int? = nil, id: Int? = nil, stepCount: Int? = nil, step: [Int] = [], color: [Int] = []) {
        self.type = type
        self.id = id
        self.stepCount = stepCount
        self.step = step
        self.color = color
    }
}
