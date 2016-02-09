import Cocoa

typealias Entry = (name: String, date: NSDate?)

class ViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {
  
  var data = [Entry]()
  
  override func viewDidLoad() {
    super.viewDidLoad()

    let calendar = NSCalendar.currentCalendar()
    let components = NSDateComponents()
    components.day = 28
    components.month = 1
    components.year = 1970
    data.append(("First long line of text that should wrap or be otherwise limited", calendar.dateFromComponents(components)))
    data.append(("Another line with too much text, but slightly shorter", calendar.dateFromComponents(components)))
    
    let nib = NSNib(nibNamed: "CustomCellView", bundle: NSBundle.mainBundle())
    tableView.registerNib(nib!, forIdentifier: "CustomCellView")
    tableView.tableColumns.first?.width = tableView.bounds.width + 1
  }
  
  override var representedObject: AnyObject? {
    didSet {
    }
  }
  
  @IBOutlet weak var tableView: NSTableView!
  
  func numberOfRowsInTableView(tableView: NSTableView) -> Int {
    return data.count
  }
  
  func tableView(tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
    return 50
  }
  
  func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
    let cell = tableView.makeViewWithIdentifier("CustomCellView", owner: self) as! CustomCellView
    
    cell.label.stringValue = data[row].name

    let dateFormatter = NSDateFormatter()
    dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
    cell.date.stringValue = dateFormatter.stringFromDate(data[row].date!)
    return cell
  }
  
  
  
}

