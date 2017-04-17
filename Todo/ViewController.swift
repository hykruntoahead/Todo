//
//  ViewController.swift
//  Todo
//
//  Created by 何育昆 on 2017/4/14.
//  Copyright © 2017年 何育昆. All rights reserved.
//

import UIKit

var todos : [TodoModel] = []
var filteredTodos : [TodoModel] = []


func dateFromString(dateStr:String) -> Date?{
    let dateFormatter = DateFormatter();
    dateFormatter.dateFormat = "yyyy-MM-dd"
    let date = dateFormatter.date(from: dateStr)
    return date;
}

class ViewController: UIViewController , UITableViewDataSource ,UITableViewDelegate ,UISearchDisplayDelegate{
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        todos = [TodoModel(id:"1",image:"child-selected",title:"1.去游乐场",date: dateFromString(dateStr: "2014-11-02")!),
                 TodoModel(id:"2",image:"shopping-cart-selected",title:"2.购物",date: dateFromString(dateStr: "2014-10-28")!),
                 TodoModel(id:"3",image:"phone-selected",title:"3.打电话",date: dateFromString(dateStr: "2014-10-30")!),
                 TodoModel(id:"4",image:"travel-selected",title:"4.travel To Europe",date: dateFromString(dateStr: "2014-10-31")!),
        ]
        //绑定左上角按钮
        navigationItem.leftBarButtonItem = editButtonItem;
        var contentOffset = tableView.contentOffset
        contentOffset.y += (searchDisplayController?.searchBar.frame.size.height)!
        tableView.contentOffset = contentOffset;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //相当于android中 的getViewCount()
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if tableView == self.searchDisplayController?.searchResultsTableView{
            return filteredTodos.count
        }
        return todos.count
    }
    
    
    //  相当于android中的getView
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "todoCell")!
        let todo : TodoModel!;
        if tableView == self.searchDisplayController?.searchResultsTableView{
            todo = filteredTodos[indexPath.row] as TodoModel
        }else{
            todo = todos[indexPath.row] as TodoModel;
        }
        let image = cell.viewWithTag(1) as! UIImageView;
        let title = cell.viewWithTag(2) as! UILabel;
        let date = cell.viewWithTag(3) as! UILabel;
        
        image.image = UIImage(named: todo.image)
        title.text = todo.title
        
        let locale = NSLocale.current
        let dateFormat = DateFormatter.dateFormat(fromTemplate: "yyyy-MM-dd", options: 0, locale: locale)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat;
        
        date.text = dateFormatter.string(from: todo.date);
        
        return cell;
    }
    
    
    // item delete
       
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath){
        if editingStyle == UITableViewCellEditingStyle.delete {
           todos.remove(at: indexPath.row)
//            self.tableView.reloadData();
            self.tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        }
    }
    
    // 在edit状态下才可点击  canMove?
    public func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool{
        return isEditing;
    }
    
    
    public func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath){
        //移除选中源位置数据
        let todo = todos.remove(at: sourceIndexPath.row);
        //插入目标位置数据
        todos.insert(todo, at: destinationIndexPath.row);
    }
    
    //解决搜索后列表高度不规则
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 70;
    
 }
    
    
    
   public func searchDisplayController(_ controller: UISearchDisplayController, shouldReloadTableForSearch searchString: String?) -> Bool{
        filteredTodos = todos.filter(){
            $0.title.range(of: searchString!) != nil
        }
        return true
    }

    
    //Edit Mode
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        self.tableView.setEditing(editing, animated: animated)
    }
    
    
    @IBAction func close(segue:UIStoryboardSegue){
        self.tableView.reloadData();
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if segue.identifier == "editTodo"{
            
            let vc = segue.destination as! DetailNewControllerViewController;
            let indexPath = tableView.indexPathForSelectedRow;
            if let index = indexPath{
                vc.todo = todos[index.row]
            }
      }
     }
    
}

