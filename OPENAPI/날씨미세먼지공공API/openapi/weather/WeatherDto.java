package net.mayeye.site.openapi.weather;

import lombok.Getter;
import lombok.Setter;
import net.mayeye.site.util.DateParserUtils;

/**
 * WeatherDto.java
 * 동네예보조회서비스 JSON 데이터 가공 클래스
 * ==============================================
 *
 * @author BJH
 * @history 작성일            작성자     변경내용
 * @history 2019-09-02         BJH      최초작성
 * ==============================================
 */

@Getter @Setter
public class WeatherDto {

    /* 발표일자 */
    String baseDate;

    /* 발표시각 */
    String baseTime;

    /* 강수확률 */
    String pop;

    /* 강수형태 */
    String pty;

    /* 6시간 강수량 */
    String r06;

    /* 습도 */
    String reh;

    /* 6시간 신적설 */
    String s06;

    /* 하늘상태 */
    String sky;

    /* 3시간 기온 */
    String t3h;

    /* 아침 최저기온 */
    String tmn;

    /* 낮 최고기온 */
    String tmx;

    /* 풍속(동서성분) */
    String uuu;

    /* 풍속(남북성분) */
    String vvv;

    /* 파고 */
    String wav;

    /* 풍향 */
    String vec;

    /* 풍속 */
    String wsd;

    /**
     * JSON 객체에 추가되는 Key 값
     */
    String updatedAt;
    String year;
    String month;
    String date;
    String day;

    /**
     * JSON 파일에 년, 월, 일, 요일, 수정일 추가
     */
    public void updateDate() {
        DateParserUtils dateParser = new DateParserUtils();
        try {
            this.day = dateParser.getDateDay(this.baseDate, "yyyyMMdd");
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        this.updatedAt = this.baseDate + this.baseTime;
        this.year = this.baseDate.substring(0, 4);

        if(Integer.parseInt(this.baseDate.substring(4, 6)) > 9) {
            this.month = this.baseDate.substring(4, 6);
        } else {
            this.month = this.baseDate.substring(5, 6);
        }
        this.date = this.baseDate.substring(6);
    }

}
