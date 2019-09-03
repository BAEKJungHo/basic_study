package net.mayeye.site.openapi.finedust;

import lombok.Getter;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;

/**
 * FineDustBody.java
 * 미세먼지 JSON BODY 데이터
 * ==============================================
 *
 * @author BJH
 * @history 작성일            작성자     변경내용
 * @history 2019-09-03         BJH      최초작성
 * ==============================================
 */
@Getter @Setter
public class FineDustBody {

    private List<FineDustDto> items = new ArrayList<>();
    private String numOfRows;
    private String pageNo;
    private String totalCount;
    private String updatedAt;
    private String year;
    private String month;
    private String date;

    /**
     * JSON 파일에 년, 월, 일, 수정일 추가
     */
    public void updateDate() {
        List<FineDustDto> items = this.getItems();
        FineDustDto fineDustDto = items.get(0);
        String dataTime = fineDustDto.getDataTime();
        String[] splitedDateTime = dataTime.split(" ");
        String date = splitedDateTime[0];
        String[] splitedDate = date.split("-");
        String time = splitedDateTime[1];
        String formattedTime = time.replaceAll(":", "");

        this.year = splitedDate[0];
        this.month = splitedDate[1];
        this.date = splitedDate[2];
        updatedAt = this.year + this.month + this.date + formattedTime;
    }
}
