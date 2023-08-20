### TableViewController and Controller Binding:
* to use a controller for a TableViewController on the storyboard, the controller class have to extend the "UITableViewController" class.
* to bind, change/add TableViewController's class property (inside identity inspector) on storyboard with the custom controller class name. (Then the xcode assistant should work as is)
* and the cell inside TableView needs an Identifier (Reuse Identifier)