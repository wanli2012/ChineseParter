//
//  LBEssentialInformationViewController.swift
//  chinaPartner
//
//  Created by 四川三君科技有限公司 on 2017/7/26.
//  Copyright © 2017年 四川三君科技有限公司. All rights reserved.
//

import UIKit

class LBEssentialInformationViewController: UIViewController {

    @IBOutlet weak var contentW: NSLayoutConstraint!
    @IBOutlet weak var contentH: NSLayoutConstraint!
    
    @IBOutlet weak var Pname: UITextField!
    @IBOutlet weak var Pimage: UIImageView!
    @IBOutlet weak var PtypeOne: UITextField!
    @IBOutlet weak var PtypeTwo: UITextField!
    @IBOutlet weak var PsendType: UITextField!
    @IBOutlet weak var Lname: UITextField!
    @IBOutlet weak var Lphobe: UITextField!
    @IBOutlet weak var Pintroduce: UITextField!
    var ishidecotr:Bool = false
    var chooseType:NSInteger = 0
    var datadic:NSDictionary = [:]
    var keyStr:String = ""
    var SecondkeyStr:Int = 0
    let PublicationArr:NSArray = ["类型一","类型二"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "项目信息"
       self.automaticallyAdjustsScrollViewInsets = false
        
        获取项目类型数据()
    }
    //项目图片
    @IBAction func tapgestureImage(_ sender: Any) {
        
        let actionSheet: UIActionSheet = UIActionSheet();
        actionSheet.addButton(withTitle: "取消")
        actionSheet.addButton(withTitle: "相机")
        actionSheet.addButton(withTitle: "相册")
        actionSheet.cancelButtonIndex=0
        actionSheet.delegate = self
        actionSheet.show(in: self.view)
        
    }
    
    @IBAction func 项目一级分类(_ sender: Any) {

        if self.datadic.count <= 0{
           MBProgressHUD.showWarnMessage("暂无数据");
            return
        }
        self.chooseType = 1
        let vc = LBAddrecomdManChooseAreaViewController.init()

        vc.provinceArr = self.datadic["parent"] as! [AnyHashable : Any]
        vc.titlestr = "请选择项目类型"
        vc.returnreslut = {(index) -> Void in
            self.keyStr = index!
            self.PtypeOne.text = (((self.datadic["parent"] as! Dictionary<String, Any>)[self.keyStr] as! Dictionary))["trade_name"]
            self.PtypeTwo.text = ""
        }
        vc.transitioningDelegate = self
        vc.modalPresentationStyle = UIModalPresentationStyle.custom
        self.present(vc, animated: true, completion: nil)
        
    }
    
    @IBAction func 项目二级分类(_ sender: Any) {
        self.chooseType = 2
        let key = self.keyStr as String
        let dic = self.datadic["children"] as! [AnyHashable : Any] as NSDictionary
        if dic.object(forKey: key) == nil {
            MBProgressHUD.showWarnMessage("暂无数据");
            return

        }

        let vc = LBAddrecomdManChooseAreaViewController.init()
        vc.cityArr = (self.datadic["children"] as! [AnyHashable : Any] )[self.keyStr as String] as! [Any]
        vc.titlestr = "请选择二级项目类型"
        vc.returnreslut = {(index) -> Void in
            self.SecondkeyStr = Int(index!)!
            self.PtypeTwo.text = ((((self.datadic["children"] as! Dictionary<String, Any>)[self.keyStr]) as! [Any])[self.SecondkeyStr] as! Dictionary)["trade_name"]
        }
        vc.transitioningDelegate = self
        vc.modalPresentationStyle = UIModalPresentationStyle.custom
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func 选择发布类型(_ sender: Any) {
        if self.PublicationArr.count <= 0 {
            MBProgressHUD.showWarnMessage("暂无数据");
            return
        }
         self.chooseType = 2
        let vc = LBAddrecomdManChooseAreaViewController.init()
        vc.cityArr = self.PublicationArr as! [Any]
        vc.titlestr = "请选择发布类型"
        vc.returnreslut = {(index) -> Void in
            self.PsendType.text = self.PublicationArr[Int(index!)!] as? String
            
        }
        vc.transitioningDelegate = self
        vc.modalPresentationStyle = UIModalPresentationStyle.custom
        self.present(vc, animated: true, completion: nil)
    }
    
    
    func 获取项目类型数据() -> Void {
        var dic : [String:String] = [:]
            dic["uid"] = UserModel.defaultUser().uid
            dic["token"] = UserModel.defaultUser().token
        
        NetworkManager.requestPOST(withURLStr: "Merchantproject/ProjectTrade", paramDic: dic as [AnyHashable : Any], finish: { (obj:Any?) in
             let dic:NSDictionary=obj as! NSDictionary
            if (dic["code"] as! Int)==1{
               self.datadic = dic["data"] as! NSDictionary
            }else{
            
            }
            
        }) { (error:Error?) in
            
        }
        
        
    }
    
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        self.contentW.constant = ScreenW
        self.contentH.constant = 564;
    }

}

extension LBEssentialInformationViewController:UIActionSheetDelegate{
    
    func actionSheet(_ actionSheet: UIActionSheet, clickedButtonAt buttonIndex: Int) {
        if buttonIndex == 1 {//相机
            camera()
        }
        if buttonIndex == 2 {//相册
            photo()
        }
    }
    
    //调用照片方法
    func photo(){
        let pick:UIImagePickerController = UIImagePickerController()
        pick.delegate = self
        pick.allowsEditing = true
        pick.sourceType = UIImagePickerControllerSourceType.savedPhotosAlbum
        
        self.present(pick, animated: true, completion: nil)
        
    }
    
    //调用照相机方法
    func camera(){
        let pick:UIImagePickerController = UIImagePickerController()
        pick.allowsEditing = true
        pick.delegate = self
        pick.sourceType = UIImagePickerControllerSourceType.camera
        self.present(pick, animated: true, completion: nil)
    }
    
}

extension LBEssentialInformationViewController:UIImagePickerControllerDelegate , UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        
        let type:String = (info[UIImagePickerControllerMediaType]as!String)
        
        if type == "public.image"
        {
            let img = info[UIImagePickerControllerEditedImage]as?UIImage
            
            let imgData:Data = (UIImageJPEGRepresentation(img!,0.2)! as Data)
            picker.dismiss(animated:true, completion:nil)
            self.Pimage.image = UIImage(data : imgData)
        }
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension LBEssentialInformationViewController:UIViewControllerTransitioningDelegate,UIViewControllerAnimatedTransitioning{
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        return  editorMaskPresentationController.init(presentedViewController: presented, presenting: presenting)
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.ishidecotr = true
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.ishidecotr = false
        return self
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        if self.chooseType == 1{
          chooseProTypeOne(transitionContext: transitionContext)
        }else if self.chooseType == 2{
            chooseProTypeOne(transitionContext: transitionContext)
        }
        
    }
    
    func chooseProTypeOne(transitionContext:UIViewControllerContextTransitioning) -> Void {
        
        if self.ishidecotr == true{
            let  toview:UIView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
            toview.frame = CGRect(x: -ScreenW, y: (ScreenH - 300)/2, width: ScreenW - 40 , height: 280 )
            toview.layer.cornerRadius = 6
            toview.clipsToBounds = true
            transitionContext.containerView.addSubview(toview)
            UIView.animate(withDuration: 0.3, animations: { 
                toview.frame = CGRect(x: 20, y: (ScreenH - 300)/2, width: ScreenW - 40 , height: 280 )
            }, completion: { (finished:Bool) in
                transitionContext.completeTransition(true)
            })
            
        }else {
            
            let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from)
            UIView.animate(withDuration: 0.3, animations: {
                fromView?.frame = CGRect(x: 20 + ScreenW, y: (ScreenH - 300)/2, width: ScreenW - 40 , height: 280 )
            }, completion: { (finished:Bool) in
                fromView?.removeFromSuperview()
                transitionContext.completeTransition(true)
            })
            
        }
    }

}

