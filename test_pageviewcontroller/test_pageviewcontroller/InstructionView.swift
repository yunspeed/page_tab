
import UIKit

class InstructionView: UIViewController,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate
{
  
  var pageIndex : Int = 0
  var titleText : String = ""
  var imageFile : String = ""
    
  var tableView : UITableView?
  var items = ["武汉","上海","北京","深圳","广州","重庆","香港","台海","天津","武汉","上海","北京","深圳","广州","重庆","香港","台海","天津"]
  var leftBtn:UIButton?
  var rightButtonItem:UIBarButtonItem?
    
  var startPointY:CGFloat!
  var endPointY:CGFloat!
    
  var responseBlock:FucBlock?
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    initView()
  }
    
  internal func setBlock(responseBlock:FucBlock) -> Void {
       self.responseBlock=responseBlock
  }
    
  func initView(){
        // 初始化tableView的数据
        self.tableView=UITableView(frame:self.view.frame,style:UITableViewStyle.Plain)
        // 设置tableView的数据源
        self.tableView!.dataSource=self
        // 设置tableView的委托
        self.tableView!.delegate = self
        //
        self.tableView!.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(self.tableView!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //总行数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.items.count
    }
    
    //加载数据
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell = tableView .dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        let row=indexPath.row as Int
        cell.textLabel!.text=self.items[row]
        cell.imageView!.image = UIImage(named:"green.png")
        return cell;
        
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView){
        startPointY=scrollView.contentOffset.y
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool){
        endPointY=scrollView.contentOffset.y
        if(endPointY-startPointY>0)
        {
            //收起来
            print("hidden ..")
            //self.responseBlock!(backMsg: "bbb")
        }else{
            //展开
            //self.responseBlock!(backMsg: "bbb")
            print("extend ..")
        }
    }
}
