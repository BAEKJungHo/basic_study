# Asynchronous JavaScript and XML

> Author. BAEKJH

## AJAX 란?

AJAX(Asynchronous JavaScript and XML)란 서버와 통신하기 위해 `XMLHttpRequest` 객체를 사용하는 것을 의미한다. JSON, XML, HTML 그리고 일반 텍스트 형식 등을 포함한 다양한 포맷을 주고 받을 수 있다. AJAX의 강력한 특징은 페이지 전체를 리프레쉬 하지 않고서도 수행 되는 `"비동기성"`이다. 이러한 비동기성을 통해 사용자의 Event가 있으면 전체 페이지가 아닌 일부분만을 업데이트 할 수 있게 해준다.

> 참고 : [Mozilla AJAX](https://developer.mozilla.org/ko/docs/Web/Guide/AJAX/Getting_Started)

## 특징

- `Ajax 특징`
    - Web에서 화면을 갱신하지 않고 `Server(Java)`로부터 Data를 가져오는 방법
        - 즉, 페이지 새로고침 없이 서버에 요청
        - `XMLHttpRequest(XHR)`을 이용해서 서버에서 자료를 조회하고, 가져와서 작업을 수행

    - 동기방식과 비동기 방식이 있는데 둘 다 페이지의 전환이 없다.

    - 백그라운드 영역에서 서버와 데이터를 교환하여 웹 페이지에 표시해 준다.

    - Ajax를 이용하여 개발을 손쉽게 할 수 있도록 미리 여러 가지 기능을 포함해 놓은 개발 환경을 `Ajax 프레임워크`라고 한다.
        - `제이쿼리(jQuery)` : 현재 가장 널리 사용되고 있는 Ajax 프레임워크
        -  `$.ajax() 메서드`는 모든 제이쿼리 Ajax 메서드의 핵심이 되는 메서드

## 동기 vs 비동기

- `동기(Synchronous)`
    - 상대방의 신호에 의해서 다음 동작이 이루어지는 방식
    - 먼저 실행된 루틴을 완전히 끝내고 제어를 반납하는 방식
    - 한 요청이 완전히 끝날 때 까지, 다른 함수를 호출 할 수 없다.

- `비동기(Asynchronous)`
    - 함수 호출을 하고, 바로 다음 것을 수행하다가 처리완료 이벤트가 오면 다시 처리를 하는 방식
    - 요청한 동작이 완료되지 않아도 일단 제어권을 반납한 후, 자기할 일을 계속 하는 방식
    - 비동기 메서드는 메서드만 호출할 뿐, 결과를 기다리지 않는다.

## AJAX STURCTURE EXAMPLE

```javascript
$.ajax({
    type : 'GET' // HTTP 요청 방식
    ,async : false // async의 default 값은 true(비동기 방식), false(동기 방식)
    ,url : `${SURVEY_BASE_URL}/privacy?surSeq=${sur_seq}` // 해당 URI의 컨트롤러로 이동
    // error : AJAX 통신에 실패했을때 XMLHttpRequest 객체로 에러가 담긴다
    ,error  : function(xhr) { 
        alert("error");
    // success : 컨트롤러의 HandlerMethod에서 ResponseEntity로 ok() 응답이 떨어 질때 동작, 응답정보를 result가 가지고있다.
    },success : function(result){ 
        $("#surveyPrivacy").html(result); // Controller에서 View를 가져와서 랜더링
        CKEDITOR.replace('privacyVo.privacyContent', {
            height: 150,
            width: 1400,
            padding : 10,
        });
    }
})
```

## 동기방식으로 화면 Refresh없이 다른 페이지로 이동하기

AJAX를 이용하여 화면 Refresh없이 다른 페이지로 이동하기 위해서는 위 `AJAX STURCTURE EXAMPLE`의 코드에 나와 있는 것처럼 사용하면 된다.

```javascript
success : function(result){ 
    // Controller에서 View를 가져와서 랜더링
        $("#surveyPrivacy").html(result); 
```

위 코드로 인해서 화면의 전환없이 다른 페이지(View)로 이동할 수 있는 것이다. 컨트롤러의 HandlerMethod에서는 처리결과를 `$.ajax()`의 success로 반환시킨다.

```java 
@GetMappng("/privacy")
public String privacy(@ModelAttribute("surveyVo") SurveyPrivacyVo surveyVo, Model model) {
    SurveyPrivacyVo resultVo = privacyService.findSurveyPrivacy(surveyVo);
    model.addAttribute("resultVo", resultVo);
    // return 문에서 Tiles FrameWork를 거치지 않음
    return "core/survey/privacy"; 
}
```

컨트롤러에서는 return문으로 다른 페이지로 이동할 경로가 담겨있다. return 문을 통해 View를 가져와서 $.ajax()의 success 메서드의 result로 보내서 랜더링이 되는 것이다.

## 비동기 방식으로 현재 페이지에서 Refresh 없이, Event 처리하기

예를들어 `등록` 페이지에서 `삭제`버튼 클릭 시, 해당 정보가 삭제되면서 다른 페이지로 이동하지 않고 등록 페이지에 있도록 유지시키기 위해서는 AJAX를 사용해야 한다.

> AJAX

```javascript
const attachAddr = {
    ajaxDeleteEmpty(obj, seq, addrSn){
        $.ajax({
            type : 'POST' // 삭제는 PostMapping 방식
            ,async : true // 비동기 방식
            ,url : `${MINWON_ADDR_BASE_URL}/delete?minwonSeq=${seq}&addrSn=${addrSn}` // 삭제 버튼 클릭 시 이동할 컨트롤러 URI
            ,error : function(xhr) { // AJAX 통신에 실패했을 때 동작
                alert("error"); // error 팝업창을 띄운다
            }
            ,success : function(result) { // ok() 응답이 떨어져야 동작
                if(result == 'true'){ // result에 담긴 값이 true일 경우
                    alert('삭제 되었습니다.');
                    $(obj).parent().remove(); // 태그 요소 삭제
                }else { // result에 담긴 값이 false 일 경우
                    alert('삭제에 실패했습니다.');
                }
            }
        })
    },
};
```

> JSP

```html
<a href=# class="button" onclick="attachAddr.ajaxDeleteEmpty(this, <c:out value="${xxx.Seq}" />, <c:out value="${xxx.addrSn}" />); return false;">삭제</a>
```

삭제 버튼 클릭시 ajaxDeleteEmpty() 함수 안에 파라미터를 전달하면서 작동한다. ajaxDeleteEmpty()에서 url를 통해 컨트롤러로 이동한다.

> Controller

```java
@RestController
@RequiredArgsConstructor
@RequestMapping("/xxx")
public class XXXRestController {

    private final XXXService xxxService;

    /**
    * 삭제 버튼 클릭 시 동작하는 HandlerMethod
    * @param minwonAddrVo
    */
    @PostMapping("/delete")
    public ResponseEntity delete(MecMinwonAddrVo minwonAddrVo) {
        xxxService.deleteMinwonAddr(minwonAddrVo);
        return ResponseEntity.ok().body("true");
    }

    /** 
    * AJAX 통신에 실패하면 이 HandlerMethod를 실행한다
    */
    @ExceptionHandler(NotFoundContentsException.class)
    public ResponseEntity notFoundMinwonAddr () {
        return ResponseEntity.status(HttpStatus.NOT_FOUND).body("false");
    }

}
```

컨틀롤러를 자세히 보면 `@RestController` 어노테이션이 보인다. 해당 어노테이션이 있는 컨트롤러는 `비동기` 방식을 처리하는 컨트롤러로 인식한다. 따라서 각 HandlerMethod에 `@ResponseBody` 어노테이션을 붙이지 않아도 된다. 그렇기 때문에 컨트롤러의 이름을 정할때 일반적으로는 다음과 같은 방식으로 한다.

> 일반적인 컨틀롤러 : XXXController
>
> 비동기만을 담당하는 컨트롤러 : XXXRestController

___
`ResponseEntity`는 비동기 방식을 처리할 때 사용된다. Client 의 플랫폼에 구애받지 않는 독립적인 RestFul API를 개발하기 위해, `상태코드, HttpHeader, 응답메시지, 반환 데이터`를 모두 지정해서 반환해주기 위해 사용하는 것이다. 

Client 측에서 Ajax를 통해(웹의 경우) API 서버에 데이터를 요청하고 데이터 뿐만 아니라 서버에서 지정한 `상태코드, HttpHeader, 응답 메시지`를 전달받음으로써 서버와 클라이언트 사이의 의존도를 낮출 수 있다.

즉, 서버에서는 Client에서 데이터를 어떻게 출력하는 방식에 대해 관심을 갖지 않고 오직 리소스를 전달해주는 것에만 관심이 있다. 

위 코드의 `ResponseEntity.status(HttpStatus.NOT_FOUND).body("false");` 이 부분에서 ok().body() 에 들어가 있는 `false`는 ResponseBody를 나타낸다. `HttpStatus.NOT_FOUND`는 상태 코드를 나타낸다. 응답헤더도 아래처럼 추가해줄 수 있다.

```java
ResponseEntity(T body, MultiValueMap<java.lang.String,java.lang.String> headers, HttpStatus status)
Create a new HttpEntity with the given body, headers, and status code.
```

ResponseEntity말고 `Response`를 사용할 수 도 있다. 성능이 그다지 좋지 않으니 ResponseEntity를 쓰는게 낫다.

```java
@PostMapping("/delete")
@ResponseStatus(HttpStatus.NOT_FOUND)
public Response delete(MinwonAddrVo minwonAddrVo) {
    minwonAddrService.deleteMinwonAddr(minwonAddrVo);
    return new Response();
}
```

Response는 위와 같이 사용하며, 상태값 제어는 불가능하지만 헤더값은 제어가 가능하다. Reponse를 사용하면 `@ResponseStatus` 어노테이션을 사용해서 상태 코드를 지정해야 하는데, 그러면 상태코드를 하나 밖에 사용하지 못한다는 단점이 있다.

> 참고 : [HTTP Header](https://baekjungho.github.io/network-httpeheader/)
___


위에서 `@ExceptionHandler`어노테이션이 보이는데 해당 어노테이션은 주로 비동기 방식을 사용할 때, 에러페이지가 아닌 `Rest`방식이나 커스텀 뷰 방식으로 표현하기 위해 사용된다. 아래 ServiceImpl을 보자

> Service

```java
@Override
public void updateMinwonDelStsAddr(MinwonAddrVo minwonAddrVo) {
    // 생략
    if (minwonAddrs == null) {
        throw new NotFoundContentsException("해당하는 민원주소가 없습니다.");
    }
    minwonAddrRepository.updateMinwonDelStsAddr(minwonAddrVo);
}
```

minwonAddrs라는 객체가 null값일 경우 `NotFoundContentsException` 에러를 발생 시킨다. 컨트롤러의 HandlerMethod에서 `@ExceptionHandler` 어노테이션을 통해서 다룰 수 있다.

## 비동기 방식으로 파일 업로드하기 

파일업로드 Ajax 방식의 핵심은 `FormData` 라는 브라우저에서 지원하는 클래스이다. 

> FormData : FormData 는 `<form>` 과 같은 효과를 가져다주는 `key/value` 가 저장되는 객체이다. `<form>` 태그처럼 데이터를 처리할 수 있게 해준다. 이를 XHR(XMLHttpRequest) 에 실어서 서버에 보내면 마치 `<form>` 이 전송된 것과 같은 효과를 가져다 준다.
>
> 참고 : IE 에서는 10 부터 지원한다.

```javascript
$('drag-target-selector').on('drop', function(event) {
 
    //stop the browser from opening the file
    event.preventDefault();
    
    //Now we need to get the files that were dropped
    //The normal method would be to use event.dataTransfer.files
    //but as jquery creates its own event object you ave to access 
    //the browser even through originalEvent.  which looks like this
    var files = event.originalEvent.dataTransfer.files;
    
    //Use FormData to send the files
    var formData = new FormData();
    
    //append the files to the formData object
    //if you are using multiple attribute you would loop through 
    //but for this example i will skip that
    formData.append('files', files[0]);
 
 }
```

사용자가 파일을 Drag & Drop 했을 때의 처리에 대한 내용이다. 

브라우저에 어떤 파일을 drop 하면 브라우저 기본 동작이 실행된다. 이미지를 drop 하면 바로 표시되고 pdf 파일의 경우도 각 브라우저의 pdf viewer 로 브라우저 내에서 문서를 열어 보여준다. 이를 방지하기 위해 preventDefault() 를 호출한다. 

그 다음 이벤트에서 file 정보를 받아온다. drag & drop 동작에서 파일 정보는 DataTransfer 라는 객체를 통해 얻어올 수 있다. [스펙은 여기](https://developer.mozilla.org/en-US/docs/Web/API/DataTransfer)에 있는데, 여러가지 기능을 제공하고 있다. [files 라는 프로퍼티](https://developer.mozilla.org/en-US/docs/Web/API/DataTransfer/files)를 참고하자. 이것도 IE 는 10 이상에서 지원된다고 한다.

```javascript
$.ajax({
    url: '/uploadAjax',
    data: formData, // data에 formData를 작성해야 비동기 방식으로 파일 업로드가 가능
    dataType: 'text',
    processData: false, // 서버에 전달되는 데이터는 query string 형태로 전달된다. 파일 전송의 경우 이를 하지 않아야한다.
    contentType: false,
    type: 'POST',
    success: function(data) {
    }
);
```

파라미터 중 `dataType, processData, contentType` 을 보자. `dataType` 은 내가 보내는 데이터의 타입이 아니고 `서버가 응답(response)`할 때 보내줄 데이터의 타입이다. 이는 success function 에 전달될 argument 의 형태를 지정하는데 사용된다고 한다.

즉, 위에서 본 예제들 처럼 컨트롤러의 HandlerMethod에서 처리된 응답이 `$.ajax()` success의 result argument에 보내지는 데이터 타입을 의미한다. 만약에 `dataType`이 `json`일 경우 컨트롤러에서 return 해주는 형태는 객체이다. 자세한건 아래 예제를 통해서 확인하자.

> [참고] http://stackoverflow.com/questions/18701282/what-is-content-type-and-datatype-in-an-ajax-request

`processData` 관련하여, 일반적으로 서버에 전달되는 데이터는 `query string` 이라는 형태로 전달된다. data 파라미터로 전달된 데이터를 jQuery 내부적으로 query string 으로 만드는데, 파일 전송의 경우 이를 하지 않아야 하고 이를 설정하는 것이 `processData: false` 이다.

`contentType` 은 default 값이 `"application/x-www-form-urlencoded; charset=UTF-8"` 인데, `"multipart/form-data"` 로 전송이 되게 false 로 넣어준다. false 로 넣어주는 것이 언뜻 이해가 안되서 false 말고 "multipart/form-data" 를 넣어봤는데 `boundary string` 이 안들어가게 되어 제대로 동작하지 않았다.

파일을 전송해보면 content-type header 가 아래와 같이 설정된다.

> Content-Type:multipart/form-data; boundary=----WebKitFormBoundarybuOGBs9coioS5Kb9

boundary string 은 전송되는 데이터의 영역을 구분해주는 구분자로 브라우저에서 넣어주는 건데, conteytType을 명시적으로 설정할 경우 boundary string 을 overwrite 하게 되는게 아닌가 한다.

## 비동기 방식으로 이미지 업로드

이미지 업로드도 파일이므로 위와 비슷한 방식이다.

> JSP

JSP에서 파일과, 이미지에 따라 버튼을 다르게 보여주기 위해서, FileTypes ENUM 상수로 비교, c:choose 사용

```html
<div class="controls">
    <s:eval expression="T(XXX/fileManageHistory.FileTypes).IMAGE == type" var="isImage"/>
    <c:choose>
        <c:when test="${isImage}">
            <a href="#update" class="btn ty_1" onclick="fileManage.imageUpdate();">이미지 수정</a>
            <input type="file" id="files" />
        </c:when>
        <c:otherwise>
            <a href="#update" class="btn ty_1" onclick="fileManage.update();">파일 수정</a>
        </c:otherwise>
    </c:choose>
</div>
```

> AJAX

  ```javascript
const requestImageUpdate = (filePath, type) => {
    return new Promise((resolve, reject) => {
      const formData = new FormData();
      formData.append('filePath', filePath);
      formData.append("file", document.querySelector('#files').files[0]);
      console.dir(document.querySelector('#files').files[0]);
      $.ajax({
         url: `${CONTEXT_PATH}/fileManage/${type}/api`, // 컨트롤러 타는 url
         processData: false,
         contentType: false,
         enctype: 'multipart/form-data', // 파일 업로드를 위해 enctype 지정
         method: METHOD.POST,
         data: formData, // const formData 상수명
      }).done(res => resolve(res))
        .fail(err => reject(err));
    });
};
  ```

> Controller

```java
@PostMapping
  public ResponseEntity modImg(@PathVariable FileTypes type, MultipartFile file, String filePath) throws Exception {
      if (type != FileTypes.IMAGE && file.getSize() <= 0) {
          return ResponseEntity.badRequest().body(Message.BAD_REQUEST.getMsg());
      }
      String realPath = type.getPath() + filePath.replaceFirst(filePath.split("/")[0], "");

      fileManageService.overWriteImage(realPath, file);
      return ResponseEntity.ok().body(Message.UPDATED.getMsg());
  }
```

> Service

서비스 overWriteImage MultipartFile의 getBytes()메서드 이용, Apache Commons IO의 FileCopyUtils.copy() 이용
original객체에 MultipartFile로 가져온 파일의 내용을 바이트로 쓴다. 이미 존재하는 경우 덮어쓴다.

```java
@Override
  public void overWriteImage(String realPath, MultipartFile file) {
      File original = getFileByPathToFile(realPath);
      try {
          FileCopyUtils.copy(file.getBytes(), original);
      } catch (IOException e) {
          throw new RuntimeException("이미지 수정중 오류 발생");
      }
  }
```

## 비동기 방식으로 JSON 데이터 처리

> AJAX

```javascript
$.ajax({
url: "/examples/media/request_ajax.php", // 클라이언트가 요청을 보낼 서버의 URL 주소
data: { name: "홍길동" },                // HTTP 요청과 함께 서버로 보낼 데이터
type: "GET",                             // HTTP 요청 방식(GET, POST)
dataType: "json"                         // 서버에서 보내줄 데이터의 타입
})

// HTTP 요청이 성공하면 요청한 데이터가 done() 메소드로 전달됨.
.done(function(json) {
$("<h1>").text(json.title).appendTo("body");
$("<div class=\"content\">").html(json.html).appendTo("body");
})

// HTTP 요청이 실패하면 오류와 상태에 관한 정보가 fail() 메소드로 전달됨.
.fail(function(xhr, status, errorThrown) {
$("#text").html("오류가 발생했습니다.<br>")
    .append("오류명: " + errorThrown + "<br>")
    .append("상태: " + status);
})

// HTTP 요청이 성공하거나 실패하는 것에 상관없이 언제나 always() 메소드가 실행됨.
.always(function(xhr, status) {
$("#text").html("요청이 완료되었습니다!");
});
```

JSON으로 처리하는 방식을 이해하기 위해서는 스프링의 일반적인 동작 방식이랑 JSON을 처리하기 위한 비동기 방식을 이해해야한다.

### 일반적인 스프링 동작 방식

  - DispatcherServlet -> 요청 분석
  - HandlerMapping이 적합한 컨트롤러를 찾음
  - HandlerAdapter가 적함한 메서드를 찾음
  - Adapter로 HandlerMethod를 실행해서 요청을 처리
  - returnType을 가지고 ViewResolver가 prefix와 return suffix를 조합해서 View를 보내준다.

### 비동기 방식

비동기처리를 하기 위해서는 `@ResponseBody` 어노테이션을 사용하며(@RestController 어노테이션 사용시 생략 가능), @ResponseBody 어노테이션이 View를 리턴하는게 아니라 `응답 본문`으로 리턴을한다.

```
  ContentsNegotiationViewResolver -> accept-header 어떤 응답을 원하는지 분석

    - text/html
      - InternalResourceViewResolver, Tiles...

    - application/json, xml 등
      - ViewResolver가 없으므로 알맞은 `MessageConverter`를 사용
      - Jackson, JAXb2 ..
      - MessageConverter로 응답 변환해서 응답 본문으로 쏴준다.
```

`ContentsNegotiationViewResolver`가 text/html 혹은 application/json 등 InternalResourceViewResolver, TilesViewResolver 등을 탈지 MessageConverter를 사용할지 정한다.

> ContentsNegotiationViewResolver는 스프링에서는 따로 web.xml에 설정을 해야하는데, 스프링 부트에서는 자동으로 설정을 해줍니다.

JSON 형식을 사용하기 위해서는 라이브러리를 사용해야하는데 GSON, JACKSON 등이 있다.

스프링은 JSON Format을 사용하기 위해서는 `JACKSON 라이브러리`를 사용하는데, 사용하기 위해서는 스프링에서는 수동으로 등록해야 하며, 스프링 부트는 기본으로 포함 되어있다.

> [참고] [스프링부트 Application과 AppRunner](https://github.com/BAEKJungHo/DOCUMENTS/blob/master/%EC%8A%A4%ED%94%84%EB%A7%81%EB%B6%80%ED%8A%B8/2.%20Application%EA%B3%BC%20AppRunner.md)

`import com.fasterxml.jackson.databind.ObjectMapper;` JACKSON 라이브러리에서 `ObjectMapper`를 제공한다.

```java
  @Autowired
    private ObjectMapper objectMapper;
```

__JACKSON라이브러리에서 제공하는 ObjectMapper는 객체를 JSON 문자열로 변환 시키기 위해서 사용한다.__

스프링 부트에서 컨트롤러에서는 ObjectMapper를 사용하지 않아도 되는데, 그 이유는 ContentsNegotiationViewResolver가 application/json, xml등의 요청이 오면 MessageConverter를 사용하여 json일 경우 JACKSON등의 라이브러리를 사용해서 ObjectMapper를 사용하여 자동으로 JSON으로 변환해줍니다. 따라서, 스프링 부트의 컨트롤러에서는 JSON으로 Parsing 하기위한 코드를 작성하지 않아도 된다.

### String to JSON 

문자열을 JSON으로 바꾸려면 객체에 담아서 바꿔야 한다. JSON은 `key, value`로 되어있기 때문에, key, value로 되어있는 객체의 타입만 변환이 가능하다. 따라서 문자열을 DTO에 String 속성을 만들어 담아서 XXXDTO 객체를 사용하여 json으로 변환해야한다.

> [참고] [EntityVoDTO](https://github.com/BAEKJungHo/DOCUMENTS/blob/master/%EC%84%A4%EA%B3%84%EC%99%80%20%EB%AA%A8%EB%8D%B8/%ED%81%B4%EB%9E%98%EC%8A%A4%EC%84%A4%EA%B3%84/EntityVoDTO.md)

  ```java
  @Getter
  @Setter
  public class XXXDTO {
    private String parseJson;
  }
  ```

### 응답본문으로 JSON 형식으로 리턴하는 HandlerMethod

  ```java
  @Controller
  @RequestMapping("/xxx/fileManage/{type}/api")
  @RequiredArgsConstructor
  public class FileManageRestController {

    private final FileManage fileManage;

    @GetMapping
    public FileManage ajaxMethod(.....) {
        .....
        return XXXDTO; // JSON 형식으로 응답본문으로 리턴, $.ajax()의 success argument으로 전달된다.
    }

  }
  ```
