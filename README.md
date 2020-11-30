# StyleCode Project

<img src="https://i.ibb.co/h2xWRXL/2020-11-16-6-27-04.png" height="100"/>

## 개요

#### 목적 : [스타일쉐어](https://www.styleshare.kr/) 를 클론하면서 리액트와 장고의 기본기를 향상한다

#### 일정 : 2020년 11월 16일 (월) ~ 11월 27일 (금), 12일간 진행

#### 참여자 :

- Frontend : 장호철(PM), 엄문주, 박현재
- Backend : 백승찬, 정현석, 김민구

> 스타일쉐어 페이지의 다양한 기능을 구현한다.

## 핵심 기능 Key Feature

### Store ( + 기능 )
- 메인화면 
- 회원가입 페이지 / 로그인 ( 회원가입 데이터 넣기, 로그인 기능 구현 - 쿠키발급)
- (1차 / 2차) 카테고리 페이지 (Get Data , Sorting기능, pagination기능) 
- 상품 상세 페이지 (옵션 선택 기능, 장바구니에 data 추가)
- 장바구니 페이지 (수량조절기능 / 가격 계산 / Post Data)
- 검색 결과 페이지 (ex.브랜드 검색시 결과 페이지)

### OOTD
- 메인페이지 (무한스크롤링, 핀터레스트 레이아웃, 좋아요, 댓글 추가기능)
- 모달창 (좋아요, 댓글, 팔로우)

## 사용 How To Use

- 회원가입, 로그인을 한 후 상품 리스트에서 마음에 드는 상품을 장바구니에 담는다.
- 인스타그램과 유사한 sns기능인 ootd를 구경하면서 좋아요, 팔로우 그리고 댓글까지 남긴다.
- 장바구니에 담아놨던 상품을 주문한다.

## 백엔드 멤버의 기능 구현

- 전체
    - modeling

- 김민구
    - product.ProductDetailView : 특정 상품의 상세 정보를 조회
    - search.Search : 특정 단어를 포함하는 상품, 브랜드, ootd, 사용자를 조회
    - cart.CartView : 장바구니를 보여주거나 상품을 추가하는 기능
    - cart.CartDetailView : 장바구니에 담긴 상품의 수량을 변경하거나 삭제하는 기능
    - order.OrderView : 주문 페이지를 작성할 때 필요한 정보를 조회, 주문 기능
    
- 정현석
    - user.SignUpView : 회원 가입 기능
    - user.LogInView : 로그인 기능
    - user.ProfileView : 사용자의 프로필을 조회, 수정하는 기능
    - product.CategoryView : 3단계에 걸친 카테고리 전체를 조회
    - product.ProductView : 상품 전체 리스트를 조회
    - product.MdChoiceView : 인기 상품을 조회
    
- 백승찬
    - ootd.OotdDetailView : 특정 게시물의 상세 정보를 조회
    - ootd.OotdView : 전체 게시물을 조회, 게시물 생성
    - ootd.OotdCommentView : 게시물의 댓글 생성
    - ootd.ReCommentView : 댓글 수정, 삭제
    - ootd.CommentView : 대댓글 생성, 수정, 삭제
    - ootd.LikeView : 게시물 좋아요 기능
    - ootd.FollowView : 유저 팔로우 기능

## Contributing

- Thanks to [Wecode](https://wecode.co.kr/)

## Reference

- [스타일쉐어](https://www.styleshare.kr/)
- [unsplash.com](https://unsplash.com/)
- [React slick](https://react-slick.neostack.com/)
- [Masonry Layout](https://masonry.desandro.com/layout.html)
- [Icon Finder](https://www.iconfinder.com/)


## Links

- 멤버 후기
  - [정현석](https://velog.io/@cs982607/1%EC%B0%A8-%ED%94%84%EB%A1%9C%EC%A0%9D%ED%8A%B8-%ED%9B%84%EA%B8%B0)

- Repository
  - [프론트엔드](https://github.com/wecode-bootcamp-korea/14-1st-StyleCode-frontend/)
  - [백엔드](https://github.com/wecode-bootcamp-korea/14-1st-StyleCode-backend)

## License

**모든 사진은 저작권이 없는 사진을 사용했습니다.**
