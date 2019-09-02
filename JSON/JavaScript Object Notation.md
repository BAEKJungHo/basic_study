# JavaScript Object Notation

> Author. BAEKJH

## JSON 이란?

> JSON(JavaScript Object Notation)은 데이터 교환과 저장을 쉽게 하기 위하여 만들어진 텍스트 기반의 데이터 교환 표준이다. 

Javascript에서 XML을 쓰기 어렵기 때문에 웹 개발 환경에서 보완한 형식이다. 단, 주석을 지원하지 않아 Configuration 파일로는 부적절 하다. 최근에는 스프링부트와 스프링에서 XML의 장점과 JSON의 장점을 가지고 환경파일에서 XML의 대체자로 떠오르는 YAML(야믈)을 지원하고 있다.

## XML과 JSON의 차이점 

1. JSON은 종료 태그를 사용하지 않는다.

2. JSON의 구문이 XML의 구문보다 더 짧다.

3. JSON 데이터가 XML 데이터보다 더 빨리 읽고 쓸 수 있다. (문자열을 전송받은 후에 해당 문자열을 바로 파싱하므로)

4. XML은 배열을 사용할 수 없지만, JSON은 배열을 사용할 수 있다.

5. XML은 XML 파서로 파싱되며, JSON은 자바스크립트 표준 함수인 eval() 함수로 파싱된다.

## JSON의 형식

JSON의 형식은 Object와 Array 2가지가 있다.

### Object

- key와 value 형태의 비순서화된 SET 구조이며 key는 String 타입으로 작성한다.
- value 값으로는 string, number, boolean, null을 사용할 수 있다.
- object는 중괄호로 표시

```
{
  key:value,
  key:value
}
```

### Array

- 배열, value 값들의 순서화된 COLLECTION 구조다.
- value 값으로는 string, number, boolean, null을 사용할 수 있다.
- array는 대괄호로 표시

```
[
  value, value, value
]
```

### 생성 방법

JSONObject와 JSONArray를 사용하기 위해서는 `json simple` 의존성을 추가해야 한다.

```xml
<!-- https://mvnrepository.com/artifact/com.googlecode.json-simple/json-simple -->
<dependency>
    <groupId>com.googlecode.json-simple</groupId>
    <artifactId>json-simple</artifactId>
    <version>1.1.1</version>
</dependency>
```

```java
JSONObject jsonObject = new JSONObject();
JSONArray jsonArray = new JSONArray();
```

## JSON을 Level로 구분

![j1](/images/201909/j1.jpg)

위 Level(단계)에서 우리가 실질적으로 필요하고 사용하는 부분은 `Level 3` 단계이다. 하지만, 이것을 바로 사용할 수 는 없고, Level3 에 접근하기 위해서는 상위 Level부터 파싱을 해야만 한다. 

> 즉 Top레벨부터 `response > body > items > itemlist` 순으로 파싱을 해야지만 우리가 필요한 데이터에 접근하여 사용이 가능해진다.

```json
{"response":{"header":{"code":"11","error":"faile"},"body":{"items":{"itemlist":[{"name":"Kim","age":"10"},{"name":"Jung","age":"20"},{"name":"Park","age":"30"}]}}}} 
```

위 json 형식을, 정렬한 모습이 그림의 모습이다.

## Request Body로 보내지는 JSON의 행방 불명

> 참고 : [Request Body로 보내지는 JSON의 행방 불명](https://github.com/HomoEfficio/dev-tips/blob/master/Request%20Body%EB%A1%9C%20%EB%B3%B4%EB%82%B4%EC%A7%80%EB%8A%94%20JSON%EC%9D%98%20%ED%96%89%EB%B0%A9%20%EB%B6%88%EB%AA%85.md)

## JACKSON ObjectMapper 라이브러리

스프링은 JSON Format을 사용하기 위해서는 JACKSON 라이브러리를 사용하는데, 사용하기 위해서는 스프링에서는 수동으로 등록해야 하며 스프링 부트는 기본으로 포함 되어 있습니다.

> 참고 : [https://www.baeldung.com/jackson-object-mapper-tutorial]

### Dependency

```xml
<dependency>
  <groupId>org.codehaus.jackson</groupId>
  <artifactId>jackson-mapper-asl</artifactId>
  <version>1.9.13</version>
</dependency>
<dependency>
  <groupId>com.fasterxml.jackson.core</groupId>
  <artifactId>jackson-databind</artifactId>
  <version>2.9.8</version>
</dependency>
```

### readValue()

ObjectMapper의 간단한 readValue API는 좋은 진입 점이다. JSON 컨텐츠를 Java 오브젝트로 구문 분석하거나 역 직렬화하는 데 사용할 수 있다.

```java
// arg : 변환할 대상
// type : arg를 어떤 타입으로 변환할 것인지 클래스를 명시
// type에는 Class 객체, TypeReference 객체가 올 수 있다.
readValue(arg, type)
```
```
mapper.readValue(arg, ArrayList.class);
mapper.readValue(arg, new ArrayList<HashMap<String, String>>().getClass());
mapper.readValue(arg, new TypeReference<ArrayList<HashMap<String, String>>>(){});
```

우리가 비동기로 JSON 으로 변환한 객체를 넘길때 `DTO` 형식으로 넘긴다. 따라서 `JSON TO STRING`을 하기 위해서는 JSON에 있는 KEY 값들이 DTO의 속성으로 있어야 한다.

### writeValueAsString()

```java
// value : String 타입으로 변환할 대상
writeValueAsString(value)
```

## EXAMPLE

### Object Convert To JSON 

- POJO 

```java
import java.util.List;

@Getter @Setter
public class UserDto {
    private String name;
    private int age;
    private List<String> messages;
}
```

```java
public class JacksonExample {
  public static void main(String[] args) {
      ObjectMapper objMapper = new ObjectMapper();

      // For testing
      User user = createDummyUser();

      try {
          // Convert object to JSON string and save into file directly
          objMapper.writeValue(new File("D:\\user.json"), user);

          // Convert ojbect ot JSON string
          String jsonString = objMapper.writeValueAsString(user);

          // Convert object to JSON string and pretty print
          jsonString = objMapper.writerWithDefaultPrettyPrinter().writeValueAsString(user);
      } catch (JsonGenerationException e) {
          throw new RuntimeException();
      } catch (JsonMappingException e) {
          throw new RumtimeException();
      } catch (IOException e) {
          throw new RuntimeException();
      }
  }
}
```

### JSON To Object

```java
public class JacksonExample {
    public static void main(String[] args) {
        ObjectMapper objMapper = new ObjectMapper();

        try {
            // Convert JSON string from file to Object
            User user = objMapper.readValue(new File)

            // Convert JSON string to Object
            String jsonString = "{\"age\":26,\"messages\":[\"msg 1\",\"msg 2\"],\"name\":\"BAERKJH\"}";
            User userr = objMapper.readValue(jsonInStrting, User.class);
        }
        } catch (JsonGenerationException e) {
            throw new RuntimeException();
        } catch (JsonMappingException e) {
            throw new RumtimeException();
        } catch (IOException e) {
            throw new RuntimeException();
        }
    }
}
```

### JSON String Convert To List

JSON 형식의 문자열을 List로 변환

```java
public List<XXXDto> jsonToListXXXDto(String json) {
	try {
		return  objectMapper.readValue(json, new TypeReference<List<XXXDto>>(){});
	}catch (IOException e) {
		throw new RuntimeException("Fail Convert... JSON CONVERT TO JAVA OBJECT");
	}
}
```

### Map Convert to JSON 

```java
public class MapConvertToJsonString {
  public static void main(String[] args) throws Exception {

      ObjectMapper mapper = new ObjectMapper();

      HashMap<String, String> map = new HashMap<String, String>();
      map.put("name", "steave");
      map.put("age", "32");
      map.put("job", "baker");

      System.out.println(map);
      System.out.println(mapper.writeValueAsString(map));
  }
}
```

### JSON Convert to Map

```java
public class JsonStringConvertToMap {
  public static void main(String[] args) throws Exception {

      ObjectMapper mapper = new ObjectMapper();
      HashMap<String, String> map = new HashMap<String, String>();

      String jsn = "{\"age\":\"32\",\"name\":\"steave\",\"job\":\"baker\"}";

      map = mapper.readValue(jsn,
              new TypeReference<HashMap<String, String>>() {});        

      System.out.println(map);
  }
}
```

### List<Map> Convert to JSON

```java
public class ListMapConvertToJsonString {
  public static void main(String[] args) throws Exception {

      ObjectMapper mapper = new ObjectMapper();

      // map -> json
      ArrayList<HashMap<String, String>> list
              = new ArrayList<HashMap<String,String>>();

      HashMap<String, String> map = new HashMap<String, String>();
      map.put("name", "steave");
      map.put("age", "32");
      map.put("job", "baker");
      list.add(map);

      map = new HashMap<String, String>();
      map.put("name", "matt");
      map.put("age", "25");
      map.put("job", "soldier");
      list.add(map);

      System.out.println(mapper.writeValueAsString(list));

      // json -> map
      String jsn = "[{\"age\":\"32\",\"name\":\"steave\",\"job\":\"baker\"},"
              + "{\"age\":\"25\",\"name\":\"matt\",\"job\":\"soldier\"}]";
      list = mapper.readValue(jsn,
              new TypeReference<ArrayList<HashMap<String, String>>>() {});        

      System.out.println(list);
  }
}
```