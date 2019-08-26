# Entity, VO, DTO 클래스로 구분지어 설계하는 방법

> Author. BAEKJH

## 주의 !!

Entity, VO, DTO의 클래스 사용법은 사람마다 사용법이 조금씩 다릅니다. 아래에 설명하는 방식은 `정석`에 가까운 방식이지만 대부분의 개발자들과 회사들은 Entity와 VO를 합쳐서 사용합니다. 또한 구글링을 해봐도 VO와 DTO가 같다고 봐도 무방하다는 글을 많이 볼 수 있습니다. 그 이유는 각각의 클래스가 엄청난 차이는 없으며, 대부분의 사람들이 VO와 DTO를 같다고 생각하며, 그렇게 코딩하기 때문입니다.

## Entity Class 

`엔티티 클래스(Entity Class)`는 DB의 테이블내에 존재하는 컬럼만을 속성(필드)으로 가지는 클래스를 말합니다. 엔티티 클래스는 `entity package`를 만들어 해당 패키지 내에서 엔티티 클래스를 관리합니다.

엔티티 클래스는 상속을 받아서는 안되며, 테이블내에 존재하지 않는 컬럼을 가져서도 안됩니다. 예를들어 ARTICLE이란 이름의 테이블 내에 제목(TITLE), 내용(CONTENTS), 작성자(WRITER) 컬럼이 있을 경우 엔티티 클래스는 아래와 같습니다.

```java 
class Article {
    private String title;
    private String contents;
    private String writer;
}
```

## VO(Value Object)

VO는 `Value Object`의 약자로서 값 객체를 의미합니다. Vo 클래스의 핵심 역할은 `equals 메서드와 hashCode 메서드`를 오버라이딩하여 구현하는 것입니다. 즉, Vo 내부에 선언된 속성(필드)의 모든 값들이 Vo 객체마다 값이 같아야, 똑같은 객체라고 판별합니다. 

```java 
class ArticleVO {
    private Long id;
    private String title;
    private String contents;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Article article = (Article) o;
        return Objects.equals(id, article.id);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }
}
```

예를들어 `List<ArticleVO> articleList = new ArrayList<>();` articleList에 저장된 ArticleVO는 `id, title, contents`의 모든 값들이 서로 같아야 동일한 객체로 판단합니다.

> VO 클래스는 BaseVO와 같은 searchKeyword, searchCondition 등 공통 속성을 가지는 클래스를 상속받아서 사용할 수 있다.

## DTO(Data Transfer Object)

DTO는 Data Transfer Object의 약자로서 데이터 전달 객체라는 의미를 지니고 있습니다.

DTO는 DB 테이블의 컬럼외의 `추가적인 컬럼`이 필요하거나 `데이터 가공`이 필요한 경우 사용하는 클래스 입니다. DTO는 Entity 클래스를 상속받아서 추가적인 속성을 정의할 수 있으며, 혹은 `Inner Class`를 사용하여 구현할 수 도 있습니다.

```java 
class ArticleDTO {
    static class Create {
        private String title;
        private String contents;
        private String a;
    }

    static class Update {
        private Long id;
        private String title;
        private String contents;
    }

    static class Response {
        private Long id;
        private String title;
        private String contents;
        private Date createAt;
    }
}
```

