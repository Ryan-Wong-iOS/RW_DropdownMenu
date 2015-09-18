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
//实现代理，返回选中的下标，若左边没有列表，则返回0。left为左边选中下标，right为右边选中下标
- (void)dropdownSelectedLeftIndex:(NSString *)left RightIndex:(NSString *)right; {
    NSLog(@"%s : You choice %@ and %@", __FUNCTION__, left, right);
}




<p>
![image](https://github.com/Ryan-Wong-iOS/RW_DropdownMenu/blob/master/RW_DropdownMenu/demo.gif)
</p>
