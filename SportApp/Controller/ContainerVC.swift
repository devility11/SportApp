//
//  ContainerVC.swift
//  SportApp
//
//  Created by Norbert Czirjak on 2018. 03. 18..
//  Copyright © 2018. Norbert Czirjak. All rights reserved.
//

import UIKit

open class ContainerVC: UIViewController {

    
    //Manipulating container views
    fileprivate weak var MatchDetailVC : UIViewController!
    //Keeping track of containerViews
    fileprivate var containerViewObjects = Dictionary<String,UIViewController>()
    /** Pass in a tuple of required TimeInterval with UIViewAnimationOptions */
    var animationDurationWithOptions:(TimeInterval, UIViewAnimationOptions) = (0,[])
    
    /** Specifies which ever container view is on the front */
    open var currentViewController : UIViewController{
        get {
            return self.MatchDetailVC
        }
    }
    
    fileprivate var segueIdentifier : String!
    
    /*Identifier For First Container SubView*/
    @IBInspectable internal var firstLinkedSubView : String!
    
    override open func viewDidLoad() {
        super.viewDidLoad()
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        if let identifier = firstLinkedSubView{
            segueIdentifierReceivedFromParent(identifier)
        }
    }
    
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func segueIdentifierReceivedFromParent(_ identifier: String){
        self.segueIdentifier = identifier
        self.performSegue(withIdentifier: self.segueIdentifier, sender: nil)
    }
    
    override open func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifier{
            //Remove Container View
            if MatchDetailVC != nil{
                MatchDetailVC.view.removeFromSuperview()
                MatchDetailVC = nil
            }
            //Add to dictionary if isn't already there
            if ((self.containerViewObjects[self.segueIdentifier] == nil)){
                MatchDetailVC = segue.destination
                self.containerViewObjects[self.segueIdentifier] = MatchDetailVC
            }else{
                for (key, value) in self.containerViewObjects{
                    
                    if key == self.segueIdentifier{
                        MatchDetailVC = value
                    }
                }
            }
            UIView.transition(with: self.view, duration: animationDurationWithOptions.0, options: animationDurationWithOptions.1, animations: {
                self.addChildViewController(self.MatchDetailVC)
                self.MatchDetailVC.view.frame = CGRect(x: 0,y: 0, width: self.view.frame.width,height: self.view.frame.height)
                self.view.addSubview(self.MatchDetailVC.view)
            }, completion: { (complete) in
                self.MatchDetailVC.didMove(toParentViewController: self)
            })
        }
    }
}
