import Cocoa

protocol CPMetadataRepresentable: class {
  var viewIdentifier: String { get }
  var viewOwner: AnyObject? { get }
  var rowHeight: CGFloat { get }
}

extension CPXcodeProject: CPMetadataRepresentable {
  var viewIdentifier: String { return "xcodeproject_metadata" }
  var viewOwner: AnyObject? { return self }
  var rowHeight: CGFloat { return 120 }
}

extension CPXcodeTarget: CPMetadataRepresentable {
  var viewIdentifier: String { return "target_metadata" }
  var viewOwner: AnyObject? { return self }
  var rowHeight: CGFloat { return 150 }
}

extension CPPod: CPMetadataRepresentable {
  var viewIdentifier: String { return "pod_metadata" }
  var viewOwner: AnyObject? { return self }
  var rowHeight: CGFloat { return 30 }
}

class Spacer: NSObject, CPMetadataRepresentable {
  var viewIdentifier: String { return "spacer" }
  var viewOwner: AnyObject? { return nil }
  var rowHeight: CGFloat { return 30 }
}

protocol CPMetadataExtractable {
  func metadataForTargets(targets: [CPCocoaPodsTarget]) -> [CPMetadataRepresentable]
}

extension CPXcodeProject: CPMetadataExtractable {
  func metadataForTargets(targets: [CPCocoaPodsTarget]) -> [CPMetadataRepresentable] {
    return [self] + self.targets.flatMap { $0.metadataForTargets(targets) }
  }
}

extension CPXcodeTarget: CPMetadataExtractable {
  func metadataForTargets(targets: [CPCocoaPodsTarget]) -> [CPMetadataRepresentable] {
    let pods = cocoapodsTargets.flatMap { targetName -> [CPMetadataRepresentable] in
      targets.filter { $0.name == targetName }
        .flatMap { $0.pods }
        .map { $0 as CPMetadataRepresentable }
    }
    
    return [self as CPMetadataRepresentable] + pods + [Spacer() as CPMetadataRepresentable]
  }
}

extension Array where Element : CPMetadataExtractable {
  func metadataForTargets(targets: [CPCocoaPodsTarget]) -> [CPMetadataRepresentable] {
    return flatMap { element -> [CPMetadataRepresentable] in
      return (element as CPMetadataExtractable).metadataForTargets(targets)
    }
  }
}

class CPMetadataTableViewDataSource: NSObject, NSTableViewDataSource, NSTableViewDelegate {

  var projectMetadataEntries: [CPMetadataRepresentable] = [] {
    didSet {
      tableView.reloadData()
    }
  }
  
  var plugins = ["No plugins"]

  @IBOutlet weak var tableView: NSTableView!

  func setXcodeProjects(projects:[CPXcodeProject], targets:[CPCocoaPodsTarget]) {
    projectMetadataEntries = projects.metadataForTargets(targets)
  }

  // Nothing is selectable except the buttons
  func tableView(tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
    return false
  }

  func numberOfRowsInTableView(tableView: NSTableView) -> Int {
    return projectMetadataEntries.count
  }

  // Allows the UI to be set up via bindings
  func tableView(tableView: NSTableView, objectValueForTableColumn tableColumn: NSTableColumn?, row: Int) -> AnyObject? {
    return projectMetadataEntries[row]
  }

  func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
    let data = projectMetadataEntries[row]
    
    return tableView.makeViewWithIdentifier(data.viewIdentifier,
      owner: data.viewOwner)
  }

  func tableView(tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
    return projectMetadataEntries[row].rowHeight
  }
}
