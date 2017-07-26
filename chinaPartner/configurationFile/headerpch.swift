//
//  headerpch.swift
//  Three lane
//
//  Created by sm on 16/11/1.
//  Copyright © 2016年 sm. All rights reserved.
//

import UIKit

///屏幕 高度
let ScreenH = UIScreen.main.bounds.height
///屏幕高度
let ScreenW = UIScreen.main.bounds.width
//域名
let BaseUrl = "http://120.76.192.254/Client/"

let autoSizeScaleX = (ScreenW/320) as CGFloat
let autoSizeScaleY = (ScreenH/568) as CGFloat

func defineRGB(r: CGFloat,g: CGFloat,b: CGFloat,a: CGFloat) -> UIColor{

    return UIColor(red: r/255, green: g/255, blue: b/255, alpha: a)
    
}
