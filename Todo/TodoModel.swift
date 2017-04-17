//
//  TodoModel.swift
//  Todo
//
//  Created by 何育昆 on 2017/4/14.
//  Copyright © 2017年 何育昆. All rights reserved.
//
import UIKit

class TodoModel : NSObject{
    
    var id: String
    var image : String
    var title: String
    var date : Date
    
    init(id:String,image:String,title:String,date:Date) {
        self.id = id
        self.image = image
        self.title = title
        self.date = date
    }
    
    
}
