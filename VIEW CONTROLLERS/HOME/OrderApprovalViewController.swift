//
//  OrderApprovalViewController.swift
//  Mzyoon
//
//  Created by QOLSoft on 13/12/18.
//  Copyright © 2018 QOL. All rights reserved.
//

import UIKit

class OrderApprovalViewController: CommonViewController
{
    
    let orderApprovalView = UIView()
    let PricingButton = UIButton()
    let DeliveryDetailsButton = UIButton()
   // let searchTextField = UITextField()
   // let searchTextTableView = UITableView()
    let filterView = UIView()

    override func viewDidLoad()
    {
        
        self.navigationBar.isHidden = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { // change 2 to desired number of seconds
            // Your code with delay
             self.tab1Button.backgroundColor = UIColor(red: 0.9098, green: 0.5255, blue: 0.1765, alpha: 1.0)
            self.orderApprovalContent()
        }
        
       
        
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.
    }
    
func orderApprovalContent()
{
        
    self.stopActivity()
    
    orderApprovalView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
    orderApprovalView.backgroundColor = UIColor.white
    //        view.addSubview(dressTypeView)
    
    let dressTypeNavigationBar = UIView()
    dressTypeNavigationBar.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: (6.4 * y))
    dressTypeNavigationBar.backgroundColor = UIColor(red: 0.0392, green: 0.2078, blue: 0.5922, alpha: 1.0)
    view.addSubview(dressTypeNavigationBar)
    
    let backButton = UIButton()
    backButton.frame = CGRect(x: x, y: (3 * y), width: (3 * x), height: (2.5 * y))
    backButton.setImage(UIImage(named: "leftArrow"), for: .normal)
    backButton.addTarget(self, action: #selector(self.otpBackButtonAction(sender:)), for: .touchUpInside)
    backButton.tag = 2
    dressTypeNavigationBar.addSubview(backButton)
    
    let navigationTitle = UILabel()
    navigationTitle.frame = CGRect(x: 0, y: (2.5 * y), width: dressTypeNavigationBar.frame.width, height: (3 * y))
    navigationTitle.text = "ORDER APPROVAL"
    navigationTitle.textColor = UIColor.white
    navigationTitle.textAlignment = .center
    navigationTitle.font = UIFont(name: "Avenir-Regular", size: 20)
    dressTypeNavigationBar.addSubview(navigationTitle)
    
   
    PricingButton.frame = CGRect(x: 0, y: dressTypeNavigationBar.frame.maxY, width: (view.frame.width / 2) - 1, height: 40)
    PricingButton.backgroundColor = UIColor.lightGray
    PricingButton.setTitle("PRICING", for: .normal)
    PricingButton.setTitleColor(UIColor.black, for: .normal)
    PricingButton.tag = 1
    PricingButton.addTarget(self, action: #selector(self.featuresButtonAction(sender:)), for: .touchUpInside)
    view.addSubview(PricingButton)
    
  
    DeliveryDetailsButton.frame = CGRect(x: PricingButton.frame.maxX + 1, y: dressTypeNavigationBar.frame.maxY, width: (view.frame.width / 2), height: 40)
    DeliveryDetailsButton.backgroundColor = UIColor.lightGray
    DeliveryDetailsButton.setTitle("DELIVERY DETAILS", for: .normal)
    DeliveryDetailsButton.setTitleColor(UIColor.black, for: .normal)
    DeliveryDetailsButton.tag = 2
    DeliveryDetailsButton.addTarget(self, action: #selector(self.featuresButtonAction(sender:)), for: .touchUpInside)
    view.addSubview(DeliveryDetailsButton)
    

    let dressTypeScrollView = UIScrollView()
    dressTypeScrollView.frame = CGRect(x: (3 * x), y: DeliveryDetailsButton.frame.maxY + (2 * y), width: view.frame.width - (6 * x), height: (45 * y))
    //        dressTypeScrollView.backgroundColor = UIColor.red
    view.addSubview(dressTypeScrollView)
    
  
    // dressTypeScrollView.contentSize.height = y1 + (20 * y)
  }

@objc func otpBackButtonAction(sender : UIButton)
{
    self.navigationController?.popViewController(animated: true)
}
    
    
@objc func featuresButtonAction(sender : UIButton)
{
    view.endEditing(true)
        
    if sender.tag == 1
    {
        DeliveryDetailsButton.backgroundColor = UIColor.lightGray
        DeliveryDetailsButton.setTitleColor(UIColor.black, for: .normal)
            
    if sender.backgroundColor == UIColor(red: 0.0392, green: 0.2078, blue: 0.5922, alpha: 1.0)
    {
        sender.backgroundColor = UIColor.lightGray
        sender.setTitleColor(UIColor.black, for: .normal)
        //filterViewContents(isHidden: true)
    }
    else
    {
        sender.backgroundColor = UIColor(red: 0.0392, green: 0.2078, blue: 0.5922, alpha: 1.0)
        sender.setTitleColor(UIColor.white, for: .normal)
                
        //filterViewContents(isHidden: false)
      }
    }
    else
    {
        PricingButton.backgroundColor = UIColor.lightGray
        PricingButton.setTitleColor(UIColor.black, for: .normal)
            
        sender.backgroundColor = UIColor(red: 0.0392, green: 0.2078, blue: 0.5922, alpha: 1.0)
        sender.setTitleColor(UIColor.white, for: .normal)
            
           // filterViewContents(isHidden: true)
          //  sortFunc()
        }
        
 }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
