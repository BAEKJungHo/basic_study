# SYSDATE() VS NOW()

> Author. BAEKJH

## SYSDATE()와 NOW()의 차이점

> 결론 : 실무에서 REG_DATE를 등록하기 위해서는 NOW()를 사용

MySQL 내부적으로 현재 날짜 및 시간 정보를 리턴해주는 `Built-in` 함수로 `SYSDATE()와 NOW()` 2개가 있는데, 내부적으로 SYSDATE()와 NOW()의 작동 방식은 쿼리의 실행 계획에 상당한 영향을 미칠 정도로 크다.

SYSDATE() 함수는 트랜잭션이나 쿼리 단위에 전혀 관계 없이, 그 함수가 실행되는 시점의 시각을 리턴해주지만, NOW()는 하나의 쿼리 단위로 동일한 값을 리턴하게 된다.

> sysdate() : 함수 호출 시간(값이 일정하지 않음)
>
> now() : 쿼리 수행 시간(동일한 값 리턴)

즉, 게시물 등록시 등록일을 넣기 위해서는, 쿼리가 수행되는 시간인 NOW()를 사용해야 맞다.

쿼리의 비교 값으로 사용된 NOW() 함수는 상수(Constant)이지만, SYSDATE() 함수는 상수가 아닌 것이다. SYSDATE()로 비교되는 컬럼에 인덱스가 준비되어 있든지 아니든지에 관계없이 `FULL-TABLE-SCAN` 을 사용할 수 밖에 없는 구조인 것이다.

이러한 예상하지 못한 문제를 해결하기 위해서, SYSDATE()의 사용 금지, 또는 `--sysdate-is-now` 옵션을 설정하여 MySQL Server 기동
`--sysdate-is-now` 옵션이 활성화되면, SYSDATE()는 NOW() 함수와 동일하게 작동하게 된다.


