
import UIKit

//定义block
typealias FucBlock = (backMsg :String) ->Void

class ViewController: UIViewController, UIPageViewControllerDataSource,UIPageViewControllerDelegate
{
  var pageViewController : UIPageViewController?
  var pageTitles : Array<String> = ["God vs Man", "Cool Breeze", "Fire Sky"]
  var pageImages : Array<String> = ["page1.png", "page2.png", "page3.png"]
  var currentIndex : Int = 0
    
  var responseBlock:FucBlock?
    
  var pageTab:PageTab?
  
    @IBOutlet weak var tab_top: UIView!
    @IBOutlet weak var tab_view: UIView!
  override func viewDidLoad()
  {
    super.viewDidLoad()
    
    
    pageTab=PageTab(frame: CGRectMake(0,50, view.frame.size.width,60))
    pageTab?.pageTabLineStyle = .NoLine
    pageTab?.selectFontColor=UIColor.redColor()
    pageTab?.unselectFontColor=UIColor.grayColor()
    pageTab!.initWithData( ["God vs Man", "Cool Breeze", "Fire Sky"])
    pageTab?.responseBlock={ (index) in
        print("\(index)")
        let startingViewController: InstructionView = self.viewControllerAtIndex(index)!
        let viewControllers = [startingViewController]
        self.pageViewController!.setViewControllers(viewControllers , direction: .Reverse, animated: false, completion: nil)
    }
    
    self.responseBlock={(msg) in
        print(msg)
    }

    self.view.addSubview(pageTab!)
    
    pageViewController = UIPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
    pageViewController?.delegate = self
    pageViewController!.dataSource = self
    

    
    let startingViewController: InstructionView = viewControllerAtIndex(0)!
    let viewControllers = [startingViewController]
    pageViewController!.setViewControllers(viewControllers , direction: .Forward, animated: false, completion: nil)
    pageViewController!.view.frame = CGRectMake(0, 110, view.frame.size.width, view.frame.size.height-110);
    
    
    addChildViewController(pageViewController!)
    view.addSubview(pageViewController!.view)
    
    
    pageViewController!.didMoveToParentViewController(self)

  }
    
  func extendHeader(){

    
  }
  
  override func didReceiveMemoryWarning()
  {
    super.didReceiveMemoryWarning()
  }
  
  func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController?
  {
    var index = (viewController as! InstructionView).pageIndex
    
    if (index == 0) || (index == NSNotFound) {
      return nil
    }
    
    index -= 1
    return viewControllerAtIndex(index)
  }
  

    
    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool)
    {
        if (!completed)
        {
            return
        }
        let index:Int = pageViewController.viewControllers!.first!.view.tag //Page Index
        pageTab?.moveToNext(index)
        print( "didFinishAnimating \(index)")
    }
    
  func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController?
  {
    var index = (viewController as! InstructionView).pageIndex
    
    if index == NSNotFound {
      return nil
    }
    
    index += 1
    
    if (index == self.pageTitles.count) {
      return nil
    }
    
    return viewControllerAtIndex(index)
  }
  
  func viewControllerAtIndex(index: Int) -> InstructionView?
  {
    if self.pageTitles.count == 0 || index >= self.pageTitles.count
    {
      return nil
    }
    
    let pageContentViewController = InstructionView()
    pageContentViewController.imageFile = pageImages[index]
    pageContentViewController.titleText = pageTitles[index]
    pageContentViewController.setBlock(self.responseBlock!)
    pageContentViewController.pageIndex = index
    pageContentViewController.view.tag=index
    currentIndex = index
    return pageContentViewController
  }
  
  func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int
  {
    return self.pageTitles.count
  }
  
  func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int
  {
    return 0
  }
  
}
