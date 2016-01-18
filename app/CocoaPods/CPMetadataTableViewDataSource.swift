import Cocoa

protocol XcodeProjectFlattenable {
  func flattenForTargets(targets: [CPCocoaPodsTarget]) -> [AnyObject]
}

extension CPXcodeProject: XcodeProjectFlattenable {
  func flattenForTargets(targets: [CPCocoaPodsTarget]) -> [AnyObject] {
    return [self] + self.targets.flatMap { $0.flattenForTargets(targets) }
  }
}

extension CPXcodeTarget: XcodeProjectFlattenable {
  func flattenForTargets(targets: [CPCocoaPodsTarget]) -> [AnyObject] {
    return [self] + cocoapodsTargets.flatMap { targetName -> [AnyObject] in
      targets.filter { $0.name == targetName }.flatMap { $0.pods }
    } + ["spacer"]
  }
}

extension Array where Element : XcodeProjectFlattenable {
  func flattenForTargets(targets: [CPCocoaPodsTarget]) -> [AnyObject] {
    return flatMap { element -> [AnyObject] in
      return (element as XcodeProjectFlattenable).flattenForTargets(targets)
    }
  }
}


class CPMetadataTableViewDataSource: NSObject, NSTableViewDataSource, NSTableViewDelegate {

  var flattenedXcodeProject: [AnyObject] = []
  var plugins = ["No plugins"]

  @IBOutlet weak var tableView: NSTableView!

  func setXcodeProjects(projects:[CPXcodeProject], targets:[CPCocoaPodsTarget]) {
    flattenedXcodeProject = flattenXcodeProjects(projects, targets:targets)
    tableView.reloadData()
  }

  private func flattenXcodeProjects(projects:[CPXcodeProject], targets:[CPCocoaPodsTarget]) -> [AnyObject] {
    return projects.flattenForTargets(targets)
  }
  
  // Nothing is selectable except the buttons
  func tableView(tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
    return false
  }

  func numberOfRowsInTableView(tableView: NSTableView) -> Int {
    return flattenedXcodeProject.count
  }

  // Allows the UI to be set up via bindings
  func tableView(tableView: NSTableView, objectValueForTableColumn tableColumn: NSTableColumn?, row: Int) -> AnyObject? {
    return flattenedXcodeProject[row]
  }

  func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
    let data = flattenedXcodeProject[row]
    if let xcodeproj = data as? CPXcodeProject {
      return tableView.makeViewWithIdentifier("xcodeproject_metadata", owner: xcodeproj)

    } else if let target = data as? CPXcodeTarget {
      return tableView.makeViewWithIdentifier("target_metadata", owner: target)

    } else if let pod = data as? CPPod {
      return tableView.makeViewWithIdentifier("pod_metadata", owner: pod)

    } else if let _ = data as? NSString {
      return tableView.makeViewWithIdentifier("spacer", owner: nil)
    }

    print("Should not have data unaccounted for in the flattened xcode project");
    return nil
  }

  func tableView(tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
    let data = flattenedXcodeProject[row]
    if let _ = data as? CPXcodeProject {
      return 120

    } else if let _ = data as? CPXcodeTarget {
      return 150

    } else if let _ = data as? CPPod {
      return 30

    // Spacer
    } else if let _ = data as? NSString {
      return 30
    }

    return 0
  }
}
