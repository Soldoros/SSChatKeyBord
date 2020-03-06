<div align=center> 
  <h1>SSChatKeyBord</h1> 
</div>
<br>

<span>SSChatKeyBord仿照微信聊天输入设计的简版输入框，用户可以高度自定义</span></br>


<span>邮箱：765970680@qq.com  <br>
      钉钉：13540033103 <br>
      简书：https://www.jianshu.com/p/fdda35fd2897 </span><br><br><br>


<div align=center> 
  <img src= "https://github.com/Soldoros/SSChatKeyBord/blob/master/datu/1.png" width="345"> 
  <img src= "https://github.com/Soldoros/SSChatKeyBord/blob/master/datu/2.png" width="345"> 
</div>
  
 </br></br></br>
  
  <div align=center> 
  <img src= "https://github.com/Soldoros/SSChatKeyBord/blob/master/datu/3.png" width="345"> 
  <img src= "https://github.com/Soldoros/SSChatKeyBord/blob/master/datu/4.png" width="345"> 
</div>


</br></br></br>

1.将 SSChatKeyBoard 文件夹拖入到工程

2.plist文件需要设置权限 访问相机 麦克风 相册

3.在需要用键盘的控制器引用头文件 #import "SSChatKeyBoardInputView.h" 并设置代理 SSChatKeyBoardInputViewDelegate

4.声明对象来

```Objective-C
//The input box at the bottom carries the expression view and the multifunctional view
@property(nonatomic,strong)SSChatKeyBoardInputView *mInputView;
```
5.初始化多媒体键盘

```Objective-C
_mInputView = [SSChatKeyBoardInputView new];
_mInputView.delegate = self;
[self.view addSubview:_mInputView]; 
```
6.聊天界面通常是一个表单UITableView，这个时候需要在表单点击回调和滚动视图的滚动回调里面对键盘弹出收起做一个简单处理。

```Objective-C
//Keyboard and list view homing
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_mInputView SetSSChatKeyBoardInputViewEndEditing];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [_mInputView SetSSChatKeyBoardInputViewEndEditing];
}

```
7.在键盘的回调方法中，改变输入框高度和键盘位置的方法回调中，需要处理当前表单的frame，具体frame调整需要针对界面的布局来定，这里只对UITableView和它的父视图做个简单调整。

```Objective-C
#pragma SSChatKeyBoardInputViewDelegateThe bottom input box proxy callback
//Click the button view frame to change the current list frame
-(void)SSChatKeyBoardInputViewHeight:(CGFloat)keyBoardHeight changeTime:(CGFloat)changeTime{
 
    CGFloat height = _backViewH - keyBoardHeight;
    [UIView animateWithDuration:changeTime animations:^{
        self.mBackView.frame = CGRectMake(0, SafeAreaTop_Height, SCREEN_Width, height);
        self.mTableView.frame = self.mBackView.bounds;
        NSIndexPath *indexPath = [NSIndexPath     indexPathForRow:self.datas.count-1 inSection:0];
        [self.mTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    } completion:^(BOOL finished) {
        
    }];
    
}

```
8.其它功能根据需求而定，文本消息在跟后台对接时只能使用字符串，布局是需要做图文混排处理，生成富文本。多功能视图简单处理了图片、视频和定位，大家可以自己拓展需要的功能，并在回调方法直接编写逻辑。

```Objective-C
//Send text messages
-(void)SSChatKeyBoardInputViewBtnClick:(NSString *)string;

//Send voice messages
- (void)SSChatKeyBoardInputViewBtnClick:(SSChatKeyBoardInputView *)view sendVoice:(NSData *)voice time:(NSInteger)second;

//Multi-function view button click callback
-(void)SSChatKeyBoardInputViewBtnClickFunction:(NSInteger)index;
```
<br><br><br>
 <div align=center> 
  <img src= "https://github.com/Soldoros/SSChatKeyBord/blob/master/datu/5.png" width="345"> 
  <img src= "https://github.com/Soldoros/SSChatKeyBord/blob/master/datu/6.png" width="345"> 
</div>
  
  <br><br>
  
  <div align=center> 
  <img src= "https://github.com/Soldoros/SSChatKeyBord/blob/master/datu/7.png" width="345"> 
  <img src= "https://github.com/Soldoros/SSChatKeyBord/blob/master/datu/8.png" width="345"> 
</div>
<br><br>




