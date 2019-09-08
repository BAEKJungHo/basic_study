# 쿼리스트링와 PathVariable

> Author. BAEKJH

## 쿼리스트링와 PathVariable의 차이점

- `QueryString`
    - URL : https://localhost:8080/xxx?mno=10
    - URL이 위 처럼 되어있을 경우 `?mno=10`이 부분을 쿼리스트링이라고한다.
    - 쿼리스트링을 사용하는경우 JSP에서는 `${param.mno}` 이런방식으로 사용할 수 있다.
    - `<input type="hidden" name="mno" id="mno" value="<c:out value="${param.mno"} />" >`
    - 즉, 메뉴 ov를 유지시키기 위해서 mno 키워드를 사용하는데, 보통 인터셉터로 처리한다

- `PathVariable`
    - URL : https://localhost:8080/xxx/mno/10
    - 위 URL을 입력하여 list 화면이 나오는경우 무조건 list 출력을 위한 컨트롤러를탄다.
    - 컨트롤러에서 HandlerMethod위에 `@ModelAttribute` 어노테이션을 적용시켜 list HandlerMethod를 타기전에 미리 mno를 model에 담기도록한다.
    - 따라서. `${mno}` 처럼 사용할 수 있다.
    - `<input type="hidden" name="mno" id="mno" value="<c:out value="${mno"} />" >`