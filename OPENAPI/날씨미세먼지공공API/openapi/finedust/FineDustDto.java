package net.mayeye.site.openapi.finedust;

import lombok.Getter;
import lombok.Setter;

/**
 * FineDustDto.java
 * 동네예보조회서비스 JSON 데이터 가공 클래스
 * ==============================================
 *
 * @author BJH
 * @history 작성일            작성자     변경내용
 * @history 2019-09-02         BJH      최초작성
 * ==============================================
 */

@Getter @Setter
public class FineDustDto {

    /* 측정소명 */
    private String stationName;

    /* 측정일시 */
    private String dataTime;

    /* 아황산가스농도 */
    private String so2Value;

    /* 일산화탄소농도 */
    private String coValue;

    /* 오존농도 */
    private String o3Value;

    /* 이산화질소농도 */
    private String no2Value;

    /* 미세먼지농도 */
    private String pm10Value;

    /* 통합대기환경수치 */
    private String khaiValue;

    /* 통합대기환경지수 */
    private String khaiGrade;

    /* 아황산가스지수 */
    private String so2Grade;

    /* 일산화탄소지수 */
    private String coGrade;

    /* 오존지수 */
    private String o3Grade;

    /* 이산화질소지수 */
    private String no2Grade;

    /* 미세먼지 24시간등급자료 */
    private String pm10Grade;

}
