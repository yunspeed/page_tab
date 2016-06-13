//
//  PageTab.swift
//  test_pageviewcontroller
//
//  Created by John on 16/6/12.
//  Copyright © 2016年 John. All rights reserved.
//

import UIKit


//定义block
typealias TabClickBlock = (index :Int) ->Void

public enum PageTabLineStyle : Int {
    case NoLine
    case Horizontal
}


class PageTab: UIView
{
    //data
    // var tabArray:[String]?
    //config fontColor view hight  line hight 
    var selectFontColor:UIColor?
    var unselectFontColor:UIColor?
    var fontSize:Int?
    
    //style
    var pageTabLineStyle: PageTabLineStyle?
    
    //pageController
    var  currentIndex:Int=0
    
    //view 
    var labelArray:NSMutableArray?
    var lineView:UIView?
    
    //block
    var responseBlock:TabClickBlock?
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)!
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func initWithData(tabArray:[String])
    {
        self.userInteractionEnabled=true
        labelArray=NSMutableArray()
        
        var i=0
        let labelWidth=(self.frame.width)/CGFloat(tabArray.count)
        for tabStr in tabArray
        {
            let label=UILabel(frame:(CGRect(origin: CGPoint(x: labelWidth*CGFloat(i),y:0), size: CGSize(width:labelWidth ,height: self.frame.height))))
            label.textAlignment = .Center
            label.text=tabStr
            self.addSubview(label)
            self.configTabGesture(i, label: label)
            labelArray!.addObject(label)
        
            i += 1
        }
        
        lineView=UIView(frame:(CGRect(origin: CGPoint(x: 0,y:self.frame.height-1), size: CGSize(width:labelWidth ,height: 1))))
        lineView!.backgroundColor=selectFontColor
        self.addSubview(lineView!)
        
        self.moveToNext(0)
    }
    
    private func configTabGesture(index:Int,label:UILabel){
        label.userInteractionEnabled=true
        let gesture_tab_item = UITapGestureRecognizer(target: self, action:#selector(tapTabHandler(_:)))
        gesture_tab_item.numberOfTapsRequired = 1
        label.tag=index
        label.addGestureRecognizer(gesture_tab_item)
    }
    
    func tapTabHandler(gesture:UIGestureRecognizer) {
        let tag:Int = (gesture.view?.tag)!
        self.responseBlock!(index:tag)
    }
    
    
    func swithchTabIndex(index:Int)
    {
        UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.lineView!.frame.origin.x=(self.lineView?.frame.width)!*CGFloat(index)
            self.layoutIfNeeded()
            }, completion: nil)


        for labelView in  (self.labelArray! as NSArray as! [UILabel] )
        {
            labelView.textColor=unselectFontColor
        }
        
        let currentLabel = self.labelArray![index] as! UILabel
        currentLabel.textColor=selectFontColor
    }
    
    
    
    func moveToNext(index:Int){
        self.swithchTabIndex(index)
    }
    
   
    func moveAtIndex(index:Int){
        self.swithchTabIndex(index)
    }
    
    
    func setBlock(responseBlock:TabClickBlock) -> Void {
        self.responseBlock=responseBlock
    }
    
    
}
