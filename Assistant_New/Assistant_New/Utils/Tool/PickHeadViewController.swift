//
//  PickHeadViewController.swift
//  Assistant
//
//  Created by lxy on 2018/12/10.
//  Copyright © 2018年 lxy. All rights reserved.
//

import UIKit

class PickHeadViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    var firtsTitle:String?
    var secondTitle:String?
    var threedTitlt:String?
    var getImageBlock:((_ image:UIImage) -> ())?
    
    
    init(firtsTitle:String,secondTitle:String,threedTitlt:String) {
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .custom
        self.firtsTitle = firtsTitle
        self.secondTitle = secondTitle
        self.threedTitlt = threedTitlt
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
//
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clear
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setAlertController(firtsTitle: self.firtsTitle!, secondTitle: self.secondTitle!, threedTitlt: self.threedTitlt!)
    }
 
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    func setAlertController(firtsTitle:String,secondTitle:String,threedTitlt:String) -> Void {
        let AlertSheet = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
//        weak var weakSelf = self

        let PhotoAction = UIAlertAction.init(title: firtsTitle, style: UIAlertActionStyle.default) { (action:UIAlertAction) in
            let pic = UIImagePickerController.init()
            pic.delegate = self;
            pic.sourceType = UIImagePickerControllerSourceType.photoLibrary
            pic.modalPresentationStyle = UIModalPresentationStyle.fullScreen
            pic.modalTransitionStyle = UIModalTransitionStyle.coverVertical
            pic.allowsEditing = true
            self.present(pic, animated: false, completion: nil)
            
        }

        let CamarAction = UIAlertAction.init(title: secondTitle, style: UIAlertActionStyle.default) { (action:UIAlertAction) in
            
            let pic = UIImagePickerController.init()
            pic.delegate = self;
            pic.sourceType = UIImagePickerControllerSourceType.camera
            pic.modalPresentationStyle = UIModalPresentationStyle.fullScreen
            pic.modalTransitionStyle = UIModalTransitionStyle.coverVertical
            pic.allowsEditing = true
            self.present(pic, animated: false, completion: nil)
        }

        let CancelAction = UIAlertAction.init(title: threedTitlt, style: UIAlertActionStyle.default) { (action:UIAlertAction) in
            self.dismiss(animated: false, completion: {
                self.dismiss(animated: false, completion: nil)
            })
        }
        AlertSheet.addAction(PhotoAction)
        AlertSheet.addAction(CamarAction)
        AlertSheet.addAction(CancelAction)
        DispatchQueue.main.async {
            self.present(AlertSheet, animated: true, completion: nil)
        }
       
        
    }
    
    //MARK: - ImageVCDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.dismiss(animated: true) {
            self.dismiss(animated: false, completion: nil)
        }
        let image:UIImage = info["UIImagePickerControllerEditedImage"] as! UIImage
//        let cutImage = UIImage.imagewithImage(image)
        if (self.getImageBlock != nil) {
            self.getImageBlock!(image)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true) {
            self.dismiss(animated: false, completion: nil)
        }
    }
    
//    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
//        print(navigationController.viewControllers)
//        if navigationController.viewControllers.count == 3 {
//
//            let methoh = class_getInstanceMethod(object_getClass(self), #selector(draw(rect:)))
////            let didAddMethod : Bool = class_addMethod(object_getClass(self), #selector(self.drawWitnArc), method_getImplementation(methoh), method_getTypeEncoding(methoh))
//
//            class_replaceMethod(object_getClass(navigationController.viewControllers[2].view.subviews[1].subviews[0]), #selector(draw(rect:)), method_getImplementation(methoh!), method_getTypeEncoding(methoh!))
//        }
//    }

//    @objc dynamic func draw(rect:CGRect) {
//
//        print("要替换的方法")
//
//    }
//        let ref = UIGraphicsGetCurrentContext()
////        let rect = CGRect.init(x: 0, y: 0, width: SCREEN_W, height: SCREEN_H)
//
//        ref?.addRect(rect)
//        ref?.addArc(center: CGPoint.init(x: SCREEN_W/2, y: SCREEN_H/2), radius: CGFloat(SCREEN_W/2), startAngle: CGFloat(Double.pi*0), endAngle: CGFloat(Double.pi*2), clockwise: false)
//        UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5).setFill()
//        ref?.drawPath(using: CGPathDrawingMode.eoFill)
    
    

}
