//
//  ViewController.swift
//  SwiftyRouter
//
//  Created by duzhe on 2017/8/4.
//  Copyright © 2017年 duzhe. All rights reserved.
//

import UIKit

enum RouterPath: RouterPathable {
  case avc
  case bvc(String)
  case rvc(Demo)
  
  var any: AnyClass {
    switch self {
    case .avc:
      return AVC.self
    case .bvc:
      return BVC.self
    case .rvc:
      return RVC.self
    }
  }
  
  var params: RouterParameter? {
    switch self {
    case .bvc(let name):
      return ["name":name]
    case .rvc(let demo):
      return ["demo":demo]
    default:
      return nil
    }
  }
}


class ViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.rowHeight = 50
  }
  
  @IBAction func nomalPush(_ sender: Any) {
    Router.open(RouterPath.avc)
  }
  
  
  @IBAction func pushWithParams(_ sender: Any) {
    let demo = Demo(name: "RVC title", id: 1)
    Router.open(RouterPath.rvc(demo))
  }

  @IBAction func xpresent(_ sender: Any) {
    Router.open(RouterPath.bvc("BVC title"), present: true)
  }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DemoCell
    return cell
  }
  
}












class AVC: UIViewController, Routable{
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor.red
  }

  static func initWithParams(params: RouterParameter?) -> UIViewController {
    return AVC()
  }
}

class BVC: UIViewController, Routable{
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor.blue
  }
  let name: String
  init(name: String) {
    self.name = name
    super.init(nibName: nil, bundle: nil)
  }
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  static func initWithParams(params: RouterParameter?) -> UIViewController {
    guard let name = params?["name"] as? String else {
      fatalError("params is wrong")
    }
    let bvc = BVC(name: name)
    return bvc
  }
}

struct Demo {
  var name: String
  var id: Int
}

class RVC: UIViewController {
  let demo:Demo
  init(demo:Demo) {
    self.demo = demo
    super.init(nibName: nil, bundle: nil)
  }
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor.white
    navigationItem.title = demo.name
  }
}

extension RVC: Routable {
  static func initWithParams(params: RouterParameter?) -> UIViewController {
    guard let demo = params?["demo"] as? Demo else {
      fatalError("params is wrong")
    }
    let rvc = RVC(demo: demo)
    return rvc
  }
}





















