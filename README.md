# RW_DropdownMenu

### Import
导入头文件DropdownMenu.h

### How To Use
实现初始化
- (id)initDropdownWithButtonTitles:(NSArray*)titles andLeftListArray:(NSArray*)leftArray andRightListArray:(NSArray *)rightArray;
- 例如：
- DropdownMenu *dropdown = [[DropdownMenu alloc] initDropdownWithButtonTitles:_titleArray andLeftListArray:_leftArray andRightListArray:_rightArray];
<br/>  dropdown.delegate = self;   //此句的代理方法可返回选中下标值
<br/>  [self.view addSubview:dropdown.view];

### Delegate
//实现代理，返回选中的下标，若左边没有列表，则返回0。ButtonIndex为打开的第几个按钮或列表下标，left为左边选中下标，right为右边选中下标
- (void)dropdownSelectedButtonIndex:(NSString *)index LeftIndex:(NSString *)left RightIndex:(NSString *)right {
    NSLog(@"%s : You choice button %@, left %@ and right %@", __FUNCTION__, index, left, right);
}

### Thanks
感谢大家对我的支持，最近做了一些小更新；
<br/ >2016-04-21 -- 增加返回选的第几个button(或者选中的是第几个列表)；选中后button显示选中值

### Demo
![image](https://github.com/Ryan-Wong-iOS/RW_DropdownMenu/blob/master/RW_DropdownMenu/demo.gif)
