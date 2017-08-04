//
//  Router.swift
//  Pods
//
//  Created by duzhe on 2017/8/3.
//
//

import UIKit

public class RouterUtils {
  //获取当前页面
  public class func currentTopViewController() -> UIViewController? {
    if let rootViewController = UIApplication.shared.keyWindow?.rootViewController{
      return currentTopViewController(rootViewController: rootViewController)
    }else{
      return nil
    }
  }
  
  public class func currentTopViewController(rootViewController: UIViewController) -> UIViewController {
    if (rootViewController.isKind(of: UITabBarController.self)) {
      let tabBarController = rootViewController as! UITabBarController
      return currentTopViewController(rootViewController: tabBarController.selectedViewController!)
    }
    if (rootViewController.isKind(of: UINavigationController.self)) {
      let navigationController = rootViewController as! UINavigationController
      return currentTopViewController(rootViewController: navigationController.visibleViewController!)
    }
    if ((rootViewController.presentedViewController) != nil) {
      return currentTopViewController(rootViewController: rootViewController.presentedViewController!)
    }
    return rootViewController
  }
}

public protocol RouterPathable {
  var any: AnyClass { get }
  var params: RouterParameter? { get }
}

public typealias  RouterParameter = [String: Any]
public protocol Routable {
  /**
   类的初始化方法
   - params 传参字典
   */
  static func initWithParams(params: RouterParameter?) -> UIViewController
}


open class Router{
  
  open class func openTel(_ phone:String) {
    if let url = URL(string: "tel://\(phone)") {
      UIApplication.shared.openURL(url)
    }
  }
  
  open class func open(_ path:RouterPathable , present: Bool = false , animated: Bool = true , presentComplete: (()->Void)? = nil){
    if let cls = path.any as? Routable.Type {
      let vc = cls.initWithParams(params: path.params)
      vc.hidesBottomBarWhenPushed = true
      let topViewController = RouterUtils.currentTopViewController()
      if topViewController?.navigationController != nil && !present {
        topViewController?.navigationController?.pushViewController(vc, animated: animated)
      }else{
        topViewController?.present(vc, animated: animated , completion: presentComplete)
      }
    }
  }
}


