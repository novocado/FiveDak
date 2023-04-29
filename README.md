# FiveDak

/=semiproject.dak.common.controller.IndexController
/index.dak=semiproject.dak.common.controller.IndexController


#product.controller
/product/searchProd.dak=semiproject.dak.product.controller.SearchProdAction
/product/rankingList.dak=semiproject.dak.product.controller.RankingListAction
/product/productDetail.dak=semiproject.dak.product.controller.ProductDetailAction




#implement register
/register.dak=semiproject.dak.member.controller.MemberRegisterAction
/register/checkDuplicateEmail.dak=semiproject.dak.member.controller.CheckDuplicateEmailAction
/register/checkDuplicateId.dak=semiproject.dak.member.controller.CheckDuplicateIdAction



# member find id and passwd
/memberIdFind.dak=semiproject.dak.member.controller.MemberIdFindAction
/memberPwdFind.dak=semiproject.dak.member.controller.MemberPwdFindAction



#login and logout
/logout.dak=semiproject.dak.member.controller.MemberLogoutAction
/login.dak=semiproject.dak.member.controller.MemberLoginAction


#mypage 
/mypage/main.dak=semiproject.dak.member.controller.MyPageAction
/mypage/infoedit.dak=semiproject.dak.member.controller.PasswdCheckAction
/mypage/memberEditInfoEnd.dak=semiproject.dak.member.controller.MemberEditInfoEndAction
/mypage/point.dak=semiproject.dak.member.controller.MyPagePointAction


# admin 
/admin/adminHome.dak=semiproject.dak.admin.controller.AdminHomeAction
/admin/adminShowOrder.dak=semiproject.dak.admin.controller.AdminShowOrderAction
/admin/adminProfit.dak=semiproject.dak.admin.controller.AdminProfitAction
/admin/adminProductSearch.dak=semiproject.dak.member.controller.AdminProductSearch
