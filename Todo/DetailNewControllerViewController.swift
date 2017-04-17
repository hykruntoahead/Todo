//
//  DetailNewControllerViewController.swift
//  Todo
//
//  Created by 何育昆 on 2017/4/15.
//  Copyright © 2017年 何育昆. All rights reserved.
//

import UIKit

class DetailNewControllerViewController: UIViewController ,UITextFieldDelegate{

    
    @IBOutlet weak var childButton: UIButton!
    @IBOutlet weak var phoneButtton: UIButton!
    @IBOutlet weak var shoppingCartButton: UIButton!
    @IBOutlet weak var travelButton: UIButton!
    @IBOutlet weak var todoItem: UITextField!
    
    @IBOutlet weak var todoDate: UIDatePicker!
    
    var todo : TodoModel?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todoItem.delegate = self;
        
        if todo == nil{
            childButton.isSelected = true
            navigationController?.title = "新增Todo"
            
        }else{
            navigationController?.title = "修改Todo"
            if todo?.image == "child-selected"{
                childButton.isSelected = true
           }else if todo?.image == "phone-selected"{
                phoneButtton.isSelected = true
            }else if todo?.image == "shopping-cart-selected"{
                shoppingCartButton.isSelected = true
            }else if todo?.image == "travel-selected"{
                travelButton.isSelected = true
            }
            
            todoItem.text = todo?.title
            todoDate.setDate(todo!.date, animated: false)
            
      }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func resetButtons(){
         childButton.isSelected = false
         phoneButtton.isSelected = false
         shoppingCartButton.isSelected = false
         travelButton.isSelected = false
    }
    

    @IBAction func childTapped(_ sender: Any) {
        resetButtons();
        childButton.isSelected = true
    }
    @IBAction func phoneTapped(_ sender: Any) {
        resetButtons();
        phoneButtton.isSelected = true

    }
    @IBAction func shoppingCartTapped(_ sender: Any) {
        resetButtons();
        shoppingCartButton.isSelected = true
    }
    
    @IBAction func travelTapped(_ sender: Any) {
        resetButtons();
        travelButton.isSelected = true
    }
    @IBAction func okTApped(_ sender: Any) {
         var image = "";
        if childButton.isSelected{
            image = "child-selected"
            
        }else if phoneButtton.isSelected{
            image = "phone-selected"
        }else if shoppingCartButton.isSelected{
            image = "shopping-cart-selected"
        }else{
            image = "travel-selected"
        }
        
        if todo != nil{
           todo?.title = todoItem.text!
           todo?.date = todoDate.date
           todo?.image = image
        }else{
            let uuid = UUID.init().uuidString;
            let todo = TodoModel(id:uuid,image:image,title:todoItem.text!,date:todoDate.date);
            todos.append(todo)
        }
    }
    
    //点击键盘return 隐藏键盘
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        return true;
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        todoItem.resignFirstResponder()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
