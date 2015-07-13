## PROBLEM

Test project to show variable cell height in UITableView. But there is a weird behavior with the table view cells. If you run this project, you'll see that the first row is not properly arranged, i.e., the description label is stretched vertically. But if you scroll the table view and make that first row out of view, then scroll back up, that first cell is laid out properly.

![](https://raw.githubusercontent.com/nicnocquee/VariableHeightTableViewCell/master/weird-tableview-resize.png)

## HOW TO FIX

So after googling around and with the help of Reveal app, I found the source of the problem is `UILabel`'s `preferredMaxLayoutWidth`. It appears that `preferredMaxLayoutWidth` needs to be set immediately. So I added the following code at the bottom of `setupSubviews` function in `MyCell` class.

```swift
self.layoutIfNeeded()
myTitleLabel.preferredMaxLayoutWidth = myTitleLabel.frame.size.width
myDescriptionLabel.preferredMaxLayoutWidth = myDescriptionLabel.frame.size.width
```

However it still doesn't work because the cell's frame's width is not correctly set until it's displayed on the screen, i.e., `MyCell` is always initiated with 320 points frame's width. This causes problem when the app is run in iPhone 6 or 6 plus where the width is not 320 points. So I added the following code at the beginning of `setupSubviews` function.

```swift
self.frame.size.width = UIScreen.mainScreen().applicationFrame.size.width
```

And now the cells are displayed shown in correct heights as soon as the table view is displayed.
