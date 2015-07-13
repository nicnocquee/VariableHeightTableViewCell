## PROBLEM

Test project to show variable cell height in UITableView. But there is a weird behavior with the table view cells. If you run this project, you'll see that the first row is not properly arranged, i.e., the description label is stretched vertically. But if you scroll the table view and make that first row out of view, then scroll back up, that first cell is laid out properly.

![](https://raw.githubusercontent.com/nicnocquee/VariableHeightTableViewCell/master/weird-tableview-resize.png)

## HOW TO FIX

Apparently the real source of the problem is cell's frame's width is not correctly set until it's displayed on the screen, i.e., `MyCell` is always initiated with 320 points frame's width. Since the table view calculate the height of the rows before the cells are displayed, this causes problem when the app is run in iPhone 6 or 6 plus where the width is not 320 points. So I added the following code at the beginning of `setupSubviews` function in `MyCell` class.

```swift
self.frame.size.width = UIScreen.mainScreen().applicationFrame.size.width
```

And now the cells are displayed shown in correct heights as soon as the table view is displayed.

And in order to solve this problem when using XIB, I override the `awakeFromNib`

```swift
override func awakeFromNib() {
    super.awakeFromNib()
    // we need to set the cell's width so that content view's width will be set correctly
    self.frame.size.width = UIScreen.mainScreen().applicationFrame.size.width
}
```
