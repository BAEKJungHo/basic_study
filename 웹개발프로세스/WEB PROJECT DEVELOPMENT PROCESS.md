# WEB PROJECT DEVELOPMENT PROCESS

> Author. BAEKJH

> 웹 프로젝트 개발 프로세스 문서화 Ver 1.0

## Summary. Layout Working Process

> 메인과 서브레이아웃 작업 문서화에 대한 요약 

- 퍼블리셔분들이 `html, css, js, images, font`가 들어있는 프로젝트 폴더를 준다.
    - xShell을 통해서 web_html/X_project의 경로로 이동한다음 해당 프로젝트 폴더를 받아올 수 있다.
- 위 폴더를 사용자개발프로젝트(XXX_CORE_SITE)의 `WEB-INF` 안에 붙여넣는다.
    - 사용자개발프로젝트 = 자바에 있는 최상위 프로젝트명
- 공통 부분 jsp파일을 담기 위한 폴더 생성
    - SAMPLE) WEB-INF/jsp/site/template/{siteCodeName}/xxx.jsp
    - EX) WEB-INF/jsp/site/template/kor/xxx.jsp
- Tiles Framework 설정
    - Tiles Framework는 공통부분을 효과적으로 관리할 수 있게 제공해주는 프레임워크. 
    - 즉, include로 JSP에 포함시켜야 하는 공통부분을 관리
    - 참고 : [https://baekjungho.github.io/spring-tiles/](https://baekjungho.github.io/spring-tiles/)
    - Tiles Framework 설정을 위해 `WEB-INF/config/XXX_TilesTemplate_Config.xml` 생성
    - Tiles Framework에서 공통으로 관리할 `공통부분 jsp 파일`을 생성
        - 위에서 생성한 폴더 내에 저장
        - meta.jsp header.jsp left.jsp mainLayout.jsp subLayout.jsp, popLayout.jsp footer.jsp 메인 레이아웃과 서브레이아웃을 구분하기 위해서 layout.jsp파일을 main과 sub로 구분 지어야함
    - Tiles Framework에서는 와일드카드를 사용
- CMS 작업
    - CMS에서 사이트코드 등록(kor, tour 등)
    - `정보구조 Excel 파일`을 보면서 CMS-메뉴관리-사용자메뉴관리에서 메뉴 등록
- 실질적인 분리 작업
    - 퍼블리셔분들이 주신 `index.html(메인), sub.html(서브)` 소스를 보면서 meta, header, left, mainLayout, subLayout, footer.jsp에 각각 분리 
    - a태그에 .../.../.../xxx처럼 상대경로로 잡혀있는 것들은 ...을 없애서 절대경로로 변경.
    - link 태그나 스크립트를 불러오는 태그에서 상대경로 대신 `${CONTEXT_PATH}` 사용
    ```html
    <c:set var="CONTEXT_PATH" value="${pageContext.request.contextPath}" />
    ```
    - meta.jsp 작업시 주의사항은 babel을 불러와야함

    ```javascript
    <script src="<c:url value="/js/babel.min.js"/>"></script>
    <script src="<c:url value="/js/babel.polyfill.min.js"/>"></script>
    <script src="<c:url value="/js/bluebird.js"/>"></script>
    ```
    - 서브 레이아웃 작업 시 CMS에서 컨텐츠 등록하여서 URL에 다음과 같은 방식으로 접속하여 테스트
        - EX) http://localhost:8888/tour/contents/7
- 주의사항
    - 화면을 직접보면서(테스트하면서) 작업할 것 
    - 메인과 서브 layout.jsp작업 시 body태그의 id부분이 main, sub로 되어있는지 확인
	```html 
    <body id="main" class="user">, <body id="sub" class="user">
    ```
    - 기존에 다른사람이 작업한 결과물은 참고만 하는것이며, 퍼블리셔분들이 주신 html
	파일을 보면서 공통부분으로 떼어놓는 작업을 해야함
    - 즉, 메인, 서브 layout.jsp에서 `<tiles:insertAttribute name="left" />`를 붙여넣는 위치를 퍼블리셔분들이 주신
	html 파일을 보면서 정해야함 
        - html파일에는 퍼블리셔 분들이 친절하게 주석으로 헤더, 	푸터 등등 시작과 끝을 나타내는 주석을 처리하였음
        - EX) `<!-- Container: S -->` `<!--Container: E -->`