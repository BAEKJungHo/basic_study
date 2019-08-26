# properties의 값을 자바 속성에 바인딩하는 방법

> Author. BAEKJH

## 서론

프로그램을 구현하다가 A테이블과 B테이블이 있을 경우 B테이블에 있는 `CATEGORY_SEQ(1:한식, 2:일식, 3:중식 4:양식)`의 값을 A테이블에서 외래키로 가져서 해당 값을 JSP에서 select option으로 출력하거나, 혹은 다른 용도로 사용하는 경우에(`즉, 카테고리화 할 수 있는 값들을 사용하는 경우`) 아래의 개념을 적용하면 `하드코딩을 없앨 수 있습니다.`

### EXAMPLE 

테이블 FOOD는 FOOD_SEQ(기본키), FOODTYPE_SEQ(외래키), FOOD_NAME(음식이름)을 컬럼으로 가지고 있고, FOODTYPE 테이블은 FOODTYPE_SEQ(기본키), FOOD_SHOP(음식점)을 컬럼으로 가지고 있습니다. 

FOODTYPE_SEQ는 CHAR(1)로서 `1:한식, 2:일식, 3:중식 4:양식`의 값을 고정적으로 가지고 있습니다.

컨트롤러는 아래와 같습니다.

```java
@Controller
@RequiredArgsConstructor 
@RequestMapping("/food")
public class FoodController {

    private final FoodService foodService;
    private final FoodTypeService foodTypeService;

    // 하드코딩 
    private final int FOODTYPE = "53";

    /**
    * List 페이지로 이동
    * @param foodVo
    * @param model
    */
    @GetMapping 
    public String list(@ModelAttribute("foodVo") FoodVo foodVo, Model model) {
        // 생략
        List<Food> foodList = foodService.findFoods();
        List<FoodType> foodTypeList = foodTypeService.findFoodTypes(FOODTYPE);
        model.addAttribute("foodTypeList", foodTypeList);
        model.addAttribute("foodList", foodList);
        return "food.core";
    }

}
```

위 처럼 `FOODTYPE` 상수에 53이 하드코딩으로 박혀있는 코드를 아래의 개념을 이용해서 좀 더 깔끔하고 효율적으로 바꿀 수 있습니다. 아래의 경우는 application.properties 또는 application.yml 설정파일을 이용하는 것입니다.

- application.properties, application.yml 

```yml
# 카테고리 일련번호
category:
    schedule:
        seq: 9
    pdfviewer:
        seq: 12
    food:
        foodType: 53
```

## @Value

첫 번째는 @Value 어노테이션을 이용하는 것입니다.(롬복X, 스프링 O) 

@Value 어노테이션을 사용하면 properties 파일에 있는 값을 가져와서, 속성에 주입할 수 있습니다. 컨트롤러에서 아래 코드를 추가해서 사용하면 됩니다.

```java 
@Value("${category.food.foodType}")
private Integer foodType; // foodType은 자바의 VO클래스에 있는 속성명과 같아야 합니다.
```

## @ConfigurationProperties

클래스 위에 @ConfigurationProperties를 사용하면 properties 파일에 있는 값을 바인딩 할 수 있습니다.

```java
@Component
@ConfigurationProperties("category.foodType")
@Getter
@Setter
public class FoodTypeCategories {
    private String foodType;
}
```

위 처럼 클래스를 새로 하나 생성해주면, 컨트롤러에서 아래처럼 사용할 수 있습니다.

```java 
// private final int FOODTYPE = "53"; 제거
private final FoodTypeCategories foodTypeCategories;
// 생략
List<FoodType> foodTypeList = foodTypeService.findFoodTypes(foodTypeCategories.getFoodType());
```