# Bean Validation

> Author. BAEKJH

## Bean Validation 

Bean Validation은 JavaBean 유효성 검증을 위한 메타데이터 모델과 API에 대한 정의이며 여기서 언급하고 있는 JavaBean은 직렬화 가능하고 매개변수가 없는 생성자를 가지며, Getter 와 Setter Method를 사용하여 프로퍼티에 접근이 가능한 객체라한다.

> Bean Validation defines a metadata model and API for JavaBean validation — https://en.wikipedia.org/wiki/Bean_Validation JavaBeans are classes that encapsulate many objects into a single object (the bean). They are serializable, have a zero-argument constructor, and allow access to properties using getter and setter methods. The name “Bean” was given to encompass this standard, which aims to create reusable software components for Java. — https://en.wikipedia.org/wiki/JavaBeans

데이터 검증은 애플리케이션의 여러 계층(Presentation Layer, Business Layer, Data Access Layer)에 전반에 걸쳐 발생하는 흔한 작업이다. 종종 동일한 데이터 검증 로직이 각 계층에 구현되는데, 이는 오류를 일이 키기 쉽고, 시간을 낭비하는 일이 된다.

![x1](/images/201908/x1.jpg)

개발자는 이런 것을 피하기 위해 도메인 클래스들 사이에 퍼져있는 유효성 검증 로직(실제로 클래스 자신의 메타데이터)을 도메인 모델로 묶는다.

![x2](/images/201908/x2.jpg)

- 애플리케이션을 개발할 때 데이터를 각 계층으로 전달하게 된다. 이러한 데이터는 JavaBean의 형태를 띠게 된다.
- 데이터 유효성 검증을 위해 사용하게 되는 것이 데이터에 대한 데이터 즉 어떤 목적을 가지고 만들어진 데이터(Constructed data with a purpose) 바로 메타데이터이다.
- Java에서는 메타데이터를 표현할 수 있는 대표적인 방법이 어노테이션Annotation이다.
- 어노테이션(기본적으로는)을 이용하여 메타데이터를 정의하고 이를 통해 JavaBean의 유효성을 검증하는 것에 대한 명세가 Bean Validation이다.

> Bean Validation은 명세일 뿐 동작하는 코드가 아니다. 애플리케이션에 적용하기 위해서는 이를 구현한 코드가 필요하다. Bean Validation을 실제 동작하도록 구현Implementation한 것이 바로 `Hibernate Validator`이다.

## Hibernate-Validator

Hibernate-Validator는 자바에서 지원하는 `유효성 검증(Validation)기능` : JSR-303 자바 규약을 뜻한다. 이 것을 사용하기 위해서는 Maven에 Dependency를 추가해야 한다.

```xml
<!-- Spring 4.3.3 Release, JDK 1.8 기준 -->
<!-- Hibernate-Validator -->
<dependency>
<groupId>org.hibernate</groupId>
<artifactId>hibernate-validator</artifactId>
<version>4.3.1.Final</version>
</dependency>
```

Hibernate-Validator의 특징은 Null값 체크및 Validator에 있는 각종 어노테이션으로 지정한 형식에 따른 유효성 검증을 할 수 있다.Hibernate-Validator를 사용할 때에는 매개변수타입 앞에 `@Valid` 어노테이션을 붙여야한다.

### BindingResult와 같이 사용하기(어노테이션에 의한 검증)

Hibernate-Validator만 단독으로 사용하기에는 오류를 잡아주는 `try-catch` 역할을 하는 것이 필요하다.

Validation Check의 Error를 받도록 두는 것과, 폼 값을 커맨트객체에 보관하고 에러코드를 전달받는 역할을 한다. 또한 BindingResut를 사용하면 예를들어 숫자값이 들어와야 하는 곳에 문자열이 들어왔다던지 이런 잘못된 입력에 대한 에러 체크가 가능하다.

> BindingResult 의 경우 ModelAttribute 을 이용해 매개변수를 Bean 에 binding 할 때 발생한 오류 정보를 받기 위해 선언해야 하는 어노테이션입니다. RequestParam 도 그렇지만, 매개변수 binding 이 실패하면 400 오류가 발생합니다. 이게 500.1 같은 오류가 발생해야 맞을 것 같지만, Spring 입장에선 요청 자체가 잘못된 것이 뭔가 설계가 잘못 되어서 혹은 잘못된 경로를 호출해서 발생한 걸로 판단하기 때문에 400 으로 오류를 발생시키는 것입니다. Controller method 을 실행할 수 없는 것이니까요. 하지만, 프로그램도 잘못된 요청에 대한 처리를 해야할 수 있기 때문에 BindingResult 을 통해 값을 전달받아 이후 처리를 할 수 있도록, 즉 흐름을 진행할 수 있도록 설계된 것입니다.

- DTO에 어노테이션 적용

```java
public class BoardDTO {

    private int num; // 게시물 번호
    @Length(min=2, max=20, message="제목은 2자 이상, 20자 이하 입력하세요.")
    private String title; // 제목
    private int count; // 조회수
    private String name; // 작성자
    private String date; // 날짜
    @NotEmpty(message="내용을 입력하세요.")
    private String contents; // 내용
    private String id;

.....
}
```

> 위 처럼 위배된 Bean 유효성 검증 제약 조건에 대한 오류 메시지를 생성하는 것을 `메세지 보간법(Message Interpolation)`이라고 한다.

- Hibernate-Validator와 BindingResut를 같이 사용한 코드

```java
// 수정 검증 : BindingResut + Validator
@RequestMapping(value="/boardEdit/{num}", method=RequestMethod.POST)
public String boardEdit(@Valid BoardDTO boardDTO, BindingResult bindingResult) {
    if(bindingResult.hasErrors()) return "boardEdit";
    else {
        boardService.edit(boardDTO);
        return "redirect:/boardList";
    }
}
```

- Hibernate-Validator와 Errors를 같이 사용한 코드

```java
@RequestMapping(value = "/boardInsert.do", method = RequestMethod.POST)
public String boardInsert(@Valid BoardVO boardVO, Errors errors, Model model) throws Exception {
    if(errors.hasErrors()) {
        return "boardRegisterForm";
    }
    return "redirect:/boardRegisterForm.do";
}
```

> BindingResult를 사용할 때 자바 Hibernate-Validator에서 지원하는 어노테이션을 적용하는 방법 외에 `Validator 클래스`를 상속받아서 `검증 로직(Validation Logic)`을 구현하는 방법도 있습니다.

## 프로젝트에서 필수 값에 대한 정규식 검증 방법

프로젝트에서 필수 값을 검증할 때, `클라이언트(JS)와 서버(Java)`에서 같이 검증해야 합니다. 이상한 사용자가 URL로 타고 들어오면 클라이언트 검증만으로는 막을 수 없게 됩니다.

> 항상, 클라이언트와 서버 양쪽에 검증로직을 추가하는 습관을 들이는게 좋습니다.

### 1. 클라이언트(JS)에서 검증

  - JSP

```html
  <body>
    <form action="${pageContext.request.contextPath}/survey/usrins" id="surveyVo" name="surveyVo" method="post">
      <a href="#" onclick="survey(); return false;" class="btn ty_2">등록</a>

      <input type="text" name="email" id="email" maxlength="100" />
      <input type="text" name="phone" id="phone" maxlength="20" />
    </form>
  </body>
```

  이메일과 전화번호를 입력받고 등록 버튼을 누르면 `survey()`라는 자바스크립트 함수를 찾아갑니다.

  - Javascript

```javascript
  // 상수 선언
  const SURVEY_BASE_URL = `${CONTEXT_PATH}/survey`;

  function survey() {
    if ($("input[name='name']").val() == '') {
      alert('이름을 입력해주세요.');
      $("input[name='name']").focus();
      return false;
  }

  // 이메일 정규식
  var emailVal = $("#email").val();
  if (!verifyEmail(emailVal)) {
      alert('올바른 이메일 형식이 아닙니다.');
      $("#email").focus();
      return false;
  }

  // 핸드폰 정규식
  var phoneVal = $("#phone").val();
  if(!verifyPhone(phoneVal)) {
      alert('올바른 핸드폰 방식이 아닙니다.');
      $("#phone").focus();
      return false;
      }
  }

  // ${SURVEY_BASE_URL}/usrins : Controller의 ReqeustMapping
  $("#surveyVo").attr("action",`${SURVEY_BASE_URL}/usrins`);
  // POST 방식을 사용
  $("#surveyVo").method = METHOD.POST;
  // surveryVo라는 id값을 가진 Form을 제출
  $("#surveyVo").submit();
```

## 서버(Java)에서 Validator를 상속 받아서 검증

VO 클래스에서 @Length와 같은 어노테이션을 사용하여 검증할 수도 있으나, VO 클래스는 최대한 깔끔하게 하는 것이 좋습니다.

Validator를 구현한 클래스는 필수값에 대해서 정규식이나 패턴을 검증을 할 때 사용, 예를들어 등록페이지에서 등록 버튼 클릭 시 클라이언트를 통해 1차 검증을 마친 후, 컨트롤러의 @Postmapping이 적용된 `create HandlerMetod`를 타게 됩니다.

```java 
@Controller
@RequiredArgsConstructor
@ReqeustMapping("test/validation")
public class ValidationTestController {
    // 생략 

    @InitBinder("zzzVo")
    public void SurvecyMemberValidator (WebDataBinder webDataBinder) {
        webDataBinder.addValidators(new MinwonValidator());
    }

    @GetMapping
    public String list(@ModelAttribute("xxxVo") XXXVO xxxVo, Model model) {
        // 생략
        return "xxx.core";
    }

    @PostMapping
    public String create(@ModelAttribute("zzzVo") XXXVO xxxVo, Model model) {
        // 생략
        return "REDIRECT_URL";
    }
}
```

Validator 클래스를 사용할 때 주의점은 `@InitBinder`를 사용한다는 것입니다. @InitBinder를 사용하면 @ModelAttribute를 적용한 메서드보다 먼저 실행되며, `@Valid`와 `@ModelAttribute("키값")`이 파라미터에 적용된 메서드가 있으면, 그 메서드를 타고 키값에 담긴 객체를 받아와서 `@InitBinder`를 실행하게 됩니다. 만약 create HandlerMethod의 @ModelAttribute 키값을 list HandlerMethod의 @ModelAttribute 키값과 일치 시키면, 등록 폼이 제대로 나오지 않을 수 있습니다. 

> Validator 클래스를 사용할 때에는 검증로직클래스를 거쳐갈 HandlerMethod의 @ModelAttribute 키값을 다른 키값들과 겹치지 않게 설정해야 한다.

다음은 `Validator`를 상속받은 클래스를 보겠습니다.

```java 
public class MinwonValidator implements Validator {

    private final String PHONEANDTEL_REG_EX = "/^\\d{3}-\\d{3,4}-\\d{4}$/";
    private final String NUMBER_FORMAT = "/^[0-9]*$/";
    /**
     * 주어진 객체(clazz)에 대해 Validator가 지원 가능한가?
     * @param aClass
     * @return
     */
    @Override
    public boolean supports(Class<?> aClass) {
        // return 클래스명.class.isAssignableFrom(aClass);
        // 해당 클래스명이 Validation을 적용할 클래스 라는 것을 명시
        // 아래 코드 처럼 사용 안하고 return false 사용 시 에러발생
        // return false; --> ERROR 발생
        return MecMinwonVo.class.isAssignableFrom(aClass);
    }

    /**
     * 주어진 객체(target)에 대해서 유효성 체크를 수행하고,
     * 유효성 에러 발생시 주어진 Errors 객체에 관련 정보가 저장된다.
     * @param o
     * @param errors
     */
    @Override
    public void validate(Object o, Errors errors) {
        MecMinwonVo minwonVo = (MecMinwonVo) o;

        if((!Pattern.matches(PHONEANDTEL_REG_EX, minwonVo.toStringTel()))) {
            errors.rejectValue("tel1", "notValid", Message.DATA_ACCESS_ERROR.getMsg());
        }
         if((!Pattern.matches(NUMBER_FORMAT, String.valueOf(minwonVo.getShortPeriod())))) {
            errors.rejectValue("shortPeriod", "notValid", Message.DATA_ACCESS_ERROR.getMsg());
        }
    }
}
```

![a1](/images/201908/a1.jpg)

Validator 클래스를 통해서 검증 실패시 위 그림처럼 에러메세지가 나옵니다.

`errors.rejectValue`는 위 그림처럼 error페이지에 찍히는 에러 메세지이다. tel1은 키값, notValid는 에러유형 Message는 에러메세지를 나타낸다.
