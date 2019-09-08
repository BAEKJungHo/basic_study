# 세션(Session)

> Author. BAEKJH

## Connectionless Protocol

세션과 쿠키는 `Connectionless Protocol(비연결지향 프로토콜)` 이다.

> Connectionless Protocol
>
> 웹 서비스는 HTTP 프로토콜을 기반으로 하는데, HTTP 프로토콜은 클라이언트와 서버의 관계를 유지하지 않는다. 클라이언트가 서버쪽에 하나의 REQUEST를 보내면 서버는 그에 대한 RESPONSE를 하고 서버 연결을 해제한다. 비연결지향인 이유는 클라이언트가 여러개 이므로 연결이 지속된다면, 서버에 과부하가 일어나기 때문에, 서버의 효율성을 위해 비연결지향 프로토콜이다.

Connectionless Protocol의 장점은 서버의 부하를 줄일 수는 있으나, 클라이언트의 요청 시마다 서버와 매번 새로운 연결이 생성되기 때문에 일반적인 로그인 상태유지, 장바구니 등의 기능을 구현하기 어렵다. 이러한 단점을 보완하기 위해서 세션과 쿠키를 사용하는 것이다.

세션과 쿠키는 클라이언트와 서버의 연결 상태를 유지해주는 방법으로, 세션은 서버에서 연결 정보를 관리하는 반면 쿠키는 클라이언트에서 연결 정보를 관리하는데 차이가 있다.

## 세션이란?

- 서버가 해당 서버(웹)로 접근(request)한 클라이언트(사용자)를 식별하는 방법
- 서버(웹)는 접근한 클라이언트(사용자)에게 response-header field인 `set-cookie` 값으로 클라이언트 식별자인 `session-id`(임의의 긴 문자열)를 발행(응답)한다.
- 서버로부터 발행(응답)된 session-id는 해당 서버(웹)와 클라이언트(브라우저) 메모리에 저장된다. 이때 클라이언트 메모리에 사용되는 cookie 타입은 세션 종료 시 같이 소멸되는 `"Memory cookie"`가 사용된다.
- 서버로부터 발행된 session(데이터)을 통해 개인화(사용자)를 위한 데이터(userInfo 등..)로 활용할 수 있다.
- 클라이언트 접속 종료(브라우저 닫기 등)를 하게 되면 서버에 저장된 `session-id`는 소멸된다.

## 브라우저별 Session LifeCycle

### IE(8 기준)

- 클라이언트가 첫 번째 요청을 시도한다.
    - `새로운 탭을 활성화` 시킨 후 재 요청을 시도한다.(첫 번째 요청 session-id 값과 동일)
- `새로운 창을 활성화` 시킨 후 재 요청을 시도한다.
    - IE(8 기준) 브라우저의 경우 신규 창 활성화 후 재 요청 시 session-id가 변경된 것을 볼 수 있다.(즉, 신규 탭과 달리 신규 창의 경우 서버로 부터 새로운 session(id)을 발급받게 되는 것이다.)

### Chrome(버전 23.0.1271.97 m)

- 클라이언트가 첫 번째 요청을 시도한다.
    - Chrome 브라우저와 같은 경우 첫 번째 요청 시 다른 브라우저들의 결과와 달리 response-header의 set-cookie값이 아닌 두 번째 요청의 결과와 같은 `request-header`의 cookie 값으로 session-id가 포함되어있다.
    - `새로운 탭을 활성화` 시킨 후 재 요청을 시도한다.(첫 번째 요청 session-id 값과 동일)
- `새로운 창을 활성화` 시킨 후 재 요청을 시도한다.
    - IE(8 기준) 브라우저와 달리 신규 창 활성화 후 재요청 시에도 기존 session-id는 변하지 않는다.

### Firefox(버전 17.0.1)

- 클라이언트가 첫 번째 요청을 시도한다.
    - `새로운 탭을 활성화` 시킨 후 재 요청을 시도한다.(첫 번째 요청 session-id 값과 동일)
- `새로운 창을 활성화` 시킨 후 재 요청을 시도한다.
    - 신규 창 활성화 후 재요청 시에도 기존 session-id는 변하지 않는다.

### Safari(버전 5.01)

- 클라이언트가 첫 번째 요청을 시도한다.
    - `새로운 탭을 활성화` 시킨 후 재 요청을 시도한다.(첫 번째 요청 session-id 값과 동일)
    - Safari 브라우저의 경우 이전 브라우저들의 결과와 달리 request-header cookie값으로 session-id가 포함 되지 않는다.
- `새로운 창을 활성화` 시킨 후 재 요청을 시도한다.
    - 신규 창 활성화 후 재요청 시에도 기존 session-id는 변하지 않는다.

## 스프링에서 HttpSession으로 중복참여방지하기

HttpSession을 이용하면 로그인 정보 유지, 이벤트 중복 참여 방지등을 할 수 있습니다. 하지만 브라우저를 닫거나 클라이언트를 종료하고나서 다시 새창으로 접속하는경우 참여할 수 있습니다.(이런 부분은 본인인증 등을 통해서 막아야함.)

```java
@PostMapping("/write")
public ResponseEntity create(@Valid SatisfactionCreateDto satisfactionCreateDto,
                                BindingResult result, HttpSession session) {
    if (result.hasErrors()) { // 발리데이션에 실패 했을경우
        ErrorResponse errorResponse = new ErrorResponse(ErrorCode.BAD_REQUEST, result.getFieldErrors());
        return ResponseEntity.badRequest().body(errorResponse);
    }

    // 세션 ID 값이 menuSeq와 같은 경우
    // 이미 한번 참여했다는 의미이므로 에러코드반환
    if((Integer)session.getAttribute("SATISFACTION_ID") == satisfactionCreateDto.getUserMenuSeq()) {
        return ResponseEntity.badRequest().body(ErrorCode.BAD_REQUEST);
    } else {
        // 세션 ID 값이 menuSeq와 다른 경우 
        // 참여 이력이 없으므로 세션 ID와 값을 생성
        session.setAttribute("SATISFACTION_ID", satisfactionCreateDto.getUserMenuSeq());
        MecSatisfactionVo satisfactionVo = satisfactionCreateDto.toEntity();
        satisfactionService.createSatisfaction(satisfactionVo);
        return ResponseEntity.ok().body("true");
    }
}
```

세션은 키값은 고유해야하지만, Value값은 중복될 수 있습니다. 각각 다른 사람들이 해당 메뉴로 접속해서 `만족도조사`를 실시하게 되는 경우 session-id(임의의 문자열)이 각각의 사람들에게 발급되므로 구분이 가능하게 됩니다.

> 참고 
>
> 브라우저마다 세션 값이 겹치지 않는 이유는 브라우저 별로 별도의 쿠키를 관리하며, 쿠키를 별도로 관리하기 때문에 서버 입장에서는 같은 사용자로 인식할 수 없습니다. 로그인 기능을 만들더라도 다른 브라우저에서 같은 아이디로 접속하게 되더라도 JSESSIONID는 전혀 달라지게 됩니다. 클라이언트에서는 브라우저가 서버의 자원을 요청 시 항상 쿠키를 헤더에 함께 포함시키기 때문에 별도의 작업은 필요 없습니다. 단 브라우저에서 "Cookie 사용안함" 시 세션이 유지되지 않습니다.