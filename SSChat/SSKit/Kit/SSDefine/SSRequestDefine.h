//
//  SSRequestDefine.h
//  htcm
//
//  Created by soldoros on 2018/7/2.
//  Copyright © 2018年 soldoros. All rights reserved.
//

#ifndef SSRequestDefine_h
#define SSRequestDefine_h


//app跳转配置
#define webLink     @"petun.com"
#define bundleID    @"com.petun1.storeDev"
#define teamID      @"petun.com"


//网络请求加密参数
#define URL_Key      @"mYSyUR9DzHg5DiAj"
#define URL_Iv       @"6RZPsf2XENKpR5TY"

//网络请求头
#define URLHeaderUrl           [[NSUserDefaults standardUserDefaults] valueForKey:USER_HeaderUrl]


//测试服和正式服 192.168.103.6
#define URLTestStr             @"https://cdycdy.sccxbe.com/api/"
#define URLFormalStr           @"https://cdycdy.sccxbe.com/api/"
#define URLContentString       URLTestStr


//客服电话
#define  KefuDianhua           @"028-8080-0013"

//注册发送短信验证码
#define URLSMSRegist                @"/sms/regist"
//注册
#define URLUserRegister             @"user/register"

//修改密码
#define URLUserWrite_password       @"user/write_password"


//登录发送短信验证码
#define URLSMSLogin                 @"api/send_phone_code"
//手机号+验证码登录
#define URLUserLand                 @"user/Land"

//验证验证码
#define URLApiTest_phone_code       @"api/test_phone_code"

//修改手机号
#define URLUserWrite_Phone          @"user/write_Phone"


//密码登录
#define URLUserLogin                @"/user/login"

//微信code获取用户信息
#define URLUserWrite_info           @"user/write_info"

//账号解绑微信qq
#define URLOauthUntied              @"/oauth/untied"

//微信绑定手机号
#define URLOauthBindWx              @"user/write_info_phone"

//qq绑定手机号
#define URLOauthBindQq              @"/oauth/bindQq"

//账号绑定微信发送短信
#define URLSmsWxUnionid             @"/sms/wxUnionid"
//账号绑定qq发送短信
#define URLSmsQQOpenid              @"/sms/qqOpenid"


//账号绑定之微信绑定已有账号
#define URLOauthBindWxUser          @"/oauth/bindWxUser"
//账号绑定之QQ绑定已有账号
#define URLOauthBindQqUser          @"/oauth/bindQqUser"


//忘记密码发送短信验证码
#define URLSMSForget                @"/sms/forget"
//找回密码
#define URLUserForget               @"/user/forget"


//获取用户信息
#define URLApiGetInsider_info       @"api/getInsider_info"



//提现
#define URLPutforwardWithdrawal     @"Putforward/withdrawal"

//积分规则
#define URLInsiderSign_data         @"insider/sign_data"


//签到
#define URLInsiderSign_imme         @"insider/sign_imme"


//全局信息
#define URLApiWebCity               @"api/webCity"


//银行卡列表
#define URLPutforwardGetBack        @"Putforward/bank_card"


//我的团队
#define URLInsiderMy_team           @"insider/my_team"



//添加银行卡
#define URLPutforwardBank           @"Putforward/bank"


//获取消息列表
#define URLInsiderMessages          @"insider/messages"

//获取历史鉴定列表
#define URLAppraisalLists           @"Appraisal/lists"

//鉴定结果
#define URLAppraisalRemarks         @"Appraisal/remarks"


//获取个人认证的资料
#define URLInsiderAuthen_info       @"insider/authen_info"

//获取商品认证资料
#define URLInsiderShop_info         @"insider/shop_info"



//重置个人认证资料
#define URLInsiderResub_authen      @"insider/resub_authen"

//重置商铺认证的资料
#define URLInsiderResub_shop        @"insider/resub_shop"


//实名认证
#define URLInsiderAuthen            @"insider/authen"

//商铺认证
#define URLInsiderShop              @"insider/shop"

//猜你喜欢
#define URLInsiderGuess             @"insider/guess"


//修改用户信息
#define URLinsiderModifying         @"insider/modifying"

//修改店铺信息
#define URLStoreUpdate_info         @"Store/update_info"


//获取用户发票管理列表
#define URLInsiderFeedback          @"insider/feedback"

//粉丝列表
#define URLInsiderMy_fans           @"insider/my_fans"


//我的拍卖列表
#define URLUserFavoriteList         @"Auction/my_Auction"

//删除收藏商品
#define URLUserFavoriteDelete       @"/user/favoriteDelete"
//添加收藏商品
#define URLUserFavoriteStore        @"/user/favoriteStore"


//收藏列表
#define URLInsiderCollection        @"insider/collection"

//藏品收藏/取消
#define URLCollectionEnshrine       @"Collection/enshrine"

//藏品收藏/取消
#define URLArticleCollection        @"Article/collection"

//评论点赞 取消点赞
#define URLArticleViews             @"Article/views"


//我收藏的资讯、圈子
#define URLArticleCenter_like       @"Article/Center_like"


//我的关注列表
#define URLInsiderMy_concern        @"insider/my_concern"

//获取省市区
#define URLApiGetCity               @"api/getCity"
//获取地址列表
#define URLAddressList              @"ads/index"
//添加地址
#define URLAddressStore             @"ads/addAds"
//修改地址
#define URLAddressUpdate            @"/address/update"
//删除地址
#define URLAddressDelete            @"ads/deleteAds"
//设置默认地址地址
#define URLAdsDefalutAds            @"ads/defalutAds"

//资讯详情
#define URLNewsShow                 @"News/show"


//获取订单列表
#define URLOrderList                @"Collection/orderLists"
//获取订单详情
#define URLOrderInfo                @"Collection/order_shows"
//取消订单
#define URLOrderCancel              @"/order/cancel"
//删除订单
#define URLOrderDelete              @"/order/delete"
//提醒发货
#define URLOrderRemindGoods         @"Collection/remind"
//竞拍提醒发货
#define URLAuctionOrder_remind      @"Auction/order_remind"
//确认收货
#define URLOrderReceiv              @"Collection/orderReceipt"


//拍卖订单详情
#define URLAuctionOrder_shows       @"Auction/order_shows"


//店铺中心的订单列表
#define URLStoreOrderInfo           @"Store/orderInfo"


//我的拼团列表
#define URLOrderAfterSaleList       @"Assemble/my_order"
//我的拼团详情
#define URLOrderAfterSaleInfo       @"/order/afterSaleInfo"

//取消拼团订单
#define URLAssembleCancel_order     @"Assemble/cancel_order"


//商品管理列表
#define URLStoreMy_product          @"Store/my_product"


//产品下架
#define URLStoreStatus              @"Store/status"


//产品删除
#define URLStoreProduct_delte       @"Store/product_delte"

//泉友会圈子列表
#define URLArticleLists             @"Article/lists"


//订单商品的贫家
#define URLOrderCommentStore         @"Collection/evaluate"



//上传图片
#define URLUploadField              @"api/upload"

//刷新token
#define URLUserRefreshToken         @"/user/refreshToken"



//申请售后 退款、退货
#define URLOrderAfterSaleStore      @"/order/afterSaleStore"


//支付订单
#define URLPayPetunPay              @"/pay/petunPay"


//支付测试
#define URLPayYi_pay                @"pay/yi_pay"

//真实支付
#define URLpayPayment               @"pay/payment"


//banner
#define URLBrandLists               @"Brand/lists"


//设置拍卖提醒
#define URLAuctionRemind            @"Auction/remind"


//首页资讯
#define URLNewsTop                  @"News/top"
//首页快讯
#define URLNewsPopular              @"News/Popular"
//首页数据1
#define URLIndexHome                @"/index/home"
//首页列表数据1
#define URLIndexStoreRecommend      @"/index/storeRecommend"
//首页配置信息
#define URLCommonIndex              @"/common/config"


//资讯分类
#define URLNewsCate                 @"News/cate"
//资讯列表
#define URLNewsLists                @"News/lists"

//删除收藏
#define URLinsiderDelte_collection               @"insider/delte_collection"



//圈子详情
#define URLArticleDetails           @"Article/details"
//圈子详情评价、回复
#define URLArticleComment           @"Article/comment"
//圈子详情关注、取消关注
#define URLArticleFollow            @"Article/follow"

//吧主标识
#define URLArticleCenter            @"Article/Center"



//评论 回复
#define URLArticleReply             @"Article/reply"



//拍卖分类
#define URLAuctionTages             @"Auction/tages"
//人气拍卖
#define URLAuctionLists             @"Auction/lists"

//拍卖支付定金
#define URLAuctionBond              @"Auction/Bond"

//拍卖捡漏
#define URLAuctionCollection        @"Auction/collection"

//拍卖出价
#define URLAuctionMarkup            @"Auction/Markup"


//拼团开团
#define URLAssemblePlace            @"Assemble/Place"

//藏品分类
#define URLShoppingCate             @"Shopping/cate"



//发布藏品 拍品
#define URLStoreAddproduct          @"Store/addproduct"


//为你推荐的藏品 热销的藏品
#define URLCollectionLists          @"Collection/lists"


//我的足迹 藏品
#define URLCollectionBrowse         @"Collection/Browse"



//普通商品详情 Collection/shows
#define URLGoodsGetGoodsInfo        @"Collection/shows"

//藏品购买记录
#define URLCollectionProduct_buy    @"Collection/product_buy"

//拍卖出价列表
#define URLAuctionOffer             @"Auction/offer"



//商品管理编辑的商品详细信息 藏品+拍卖
#define URLStoreProduct_info        @"Store/product_info"



//砍价商品详情
#define URLShoppingBargain_show     @"Shopping/bargain_show"

//我的砍价详情
#define URLShoppingMy_bargain_show  @"Shopping/my_bargain_show"

//砍价记录
#define URLShoppingBargain_PartBargain  @"Shopping/bargain_PartBargain"

//帮忙砍价
#define URLShoppingBargain_Help     @"Shopping/bargain_Help"



//拼团商品详情
#define URLActivityGroupInfo        @"Assemble/show"

//拍卖商品详情
#define URLAuctionShows             @"Auction/shows"

//获取拍卖商品出价记录
#define URLAuctionOffer             @"Auction/offer"


//倒计时商品详情
#define URLGoodsActivityInfo        @"/goods/activityInfo"


//倒计时商品列表 生活有只猫 狗
#define URLGoodsActivityList        @"/goods/activityList"

#define URLGoodsActivity            @"/goods/activity"
    


//确认订单界面
#define URLOrderPayDisplay          @"Collection/plance"


//创建订单
#define URLOrderStore               @"Collection/increase"

//砍价商品创建订单
#define URLShoppingBargain_order            @"Shopping/bargain_order"


//抽奖商品领取
#define URLApiOrderstore            @"/api/order/store"

//抽奖商品确认订单界面
#define URLApiOrderPayDisplay       @"/api/order/payDisplay"

//创建开团订单
#define URLActivityGroupPayOrder           @"/activity/groupPayOrder"


//分类列表
#define URLGoodsCateList            @"/goods/cateList"
//分类品牌
#define URLGoodsCateBrandList       @"/goods/cateBrandList"



//商品列表
#define URLGoodsGetGoodsList        @"/goods/getGoodsList"
//商品筛选
#define URLGoodsCateSpecList        @"/goods/cateSpecList"



//购物车列表
#define URLCartList                 @"cart/listsCart"
//修改购物车数量
#define URLCartUpdate               @"cart/setNumber"
//修改购物车选中状态
#define URLCartSelectUpdate         @"/cart/selectUpdate"
//删除选中的商品
#define URLCartDelete               @"cart/deleteCart"
//添加购物车
#define URLCartStore                @"cart/addCart"
//获取购物车数量
#define URLcartCart_number          @"cart/cart_number"


//鉴定
#define URLAppraisalRaise           @"Appraisal/raise"




//修改购物车属性
#define URLCartUpdateSpec           @"/cart/updateSpec"

//拼团商品列表  参团的列表
#define URLAssembleIndex            @"Assemble/index"
#define URLActivityGroupUserList    @"/activity/groupUserList"

//参团详情
#define URLActivityGroupUserInfo    @"Assemble/my_order_show"


//开团
#define URLActivityGroupPayDisplay  @"/activity/groupPayDisplay"


//积分商品列表
#define URLGoodsScoreExchange       @"/goods/scoreExchange"

//获取积分商品详情
#define URLGoodsScoreExchangeInfo   @"/goods/scoreExchangeInfo"

//积分商品兑换
#define URLGoodsScorePayOrder       @"/goods/scorePayOrder"



//砍价商品列表
#define URLActivityBargainList      @"Shopping/bargain"

//寻宝启示列表
#define URLTreasureLists            @"Treasure/lists"

//帖子详情
#define URLTreasureShow             @"Treasure/show"

//帖子回复列表
#define URLTreasureReply            @"Treasure/reply"



//发布文章
#define URLTreasurePuslic_post      @"Treasure/puslic_post"

//发布泉友会
#define URLArticleRelease           @"Article/release"


//新增回复
#define URLTreasureAdd_reply        @"Treasure/add_reply"


//删除帖子
#define URLTreasureDelte_treasure   @"Treasure/delte_treasure"


//删除回复
#define URLTreasureDelte_reply      @"Treasure/delte_reply"


//我的回复
#define URLTreasureMy_reply         @"Treasure/my_reply"

//我的帖子
#define URLArticleLists             @"Article/lists"


//圈子竞猜
#define URLGuessingLists            @"guessing/lists"

//竞猜详情
#define URLGuessingShow             @"guessing/show"

//竞猜评论
#define URLGuessingAdd_comment      @"guessing/add_comment"


//竞猜评论列表
#define URLGuessingComment          @"guessing/comment"


//砍价商品详情
#define URLActivityBargainInfo      @"/activity/bargainInfo"



//会员中心充值列表
#define URLUserVipList              @"/user/vipList"
//购买VIP充值商品
#define URLUserVipStore             @"/user/vipStore"

//vip新人特享优惠券领取
#define URLVipRewardStore           @"/vip/rewardStore"

//积分明细
#define URLUserScoreRecord          @"insider/integ_show"

//积分商品确认订单
#define URLGoodsScorePayDisplay     @"/goods/scorePayDisplay"


//发起砍价
#define URLActivityBargainStore     @"Shopping/bargain_participate"

//帮TA砍价
#define URLActivityBargainHelp      @"/activity/bargainHelp"
//我也要砍价
#define URLActivityBargainDisplay   @"/activity/bargainDisplay"


//获取用户的拼团
#define URLActivityGroupMyInfo      @"/activity/groupMyInfo"

//我的砍价列表
#define URLActivityBargainMyInfo    @"Shopping/my_bargain"

//商品评价列表
#define URLGoodsCommentList         @"Collection/comments"


//商品砍价列表
#define URLShoppingBargain_lists    @"Shopping/bargain_lists"

//消息分类列表
#define URLUserNoticeTypeList       @"/user/noticeTypeList"


//店铺中心
#define URLStoreInfo                @"Store/info"


//消息列表
#define URLUserNoticeList           @"/user/noticeList"


//消息中心全部已读
#define URLUserNoticeUpdate         @"/user/noticeUpdate"


//套餐列表
#define URLPackageGoodsList         @"/package/goodsList"

//套餐详情
#define URLPackageGoodsInfo         @"/package/goodsInfo"

//套餐下单界面
#define URLpackagePayDisplay        @"/package/payDisplay"

//创建套餐订单
#define URLPackageStoreOrder        @"/package/storeOrder"


//我的藏品足迹
#define URLCollectionBrowse         @"Collection/Browse"

//我的资讯足迹
#define URLNewsBrowse               @"news/Browse"


//清空足迹
#define URLNewsDelte_browse         @"news/delte_browse"

//领券中心
#define URLActivityCouponList       @"/activity/couponList"


//一键领取组合优惠券
#define URLCouponReceive            @"Coupon/Receive"

//领取组合优惠券
#define URLActivityCouponStore      @"/activity/couponStore"

//我的优惠券
#define URLUserCouponList           @"Coupon/my_lists"

//优惠券列表
#define URLCouponLists              @"Coupon/lists"


//兑换优惠券
#define URLUserCouponStore          @"/user/couponStore"

//会员中心新人特享 免费领取
#define URLVipRewardList            @"/vip/rewardList"

//会员中心新人特享 领奖记录
#define URLVipRewardRecord          @"/vip/rewardRecord"


//用户协议
#define URLCommonDeal               @"/common/deal"



//医院列表
#define URLHospitalLists            @"Hospital/lists"

//科室列表
#define URLHospitalDepartment       @"Hospital/department"

//医生列表
#define URLHospitalDoctor           @"Hospital/Doctor"


//挂号页面信息
#define URLHospitalRegister_info    @"Hospital/Register_info"

//挂号
#define URLHospitalRegister         @"Hospital/Register"

//挂号记录
#define URLHospitalRecord           @"Hospital/record"



#endif

