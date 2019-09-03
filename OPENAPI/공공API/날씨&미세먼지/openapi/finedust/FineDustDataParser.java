package net.mayeye.site.openapi.finedust;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.dataformat.xml.XmlMapper;
import lombok.RequiredArgsConstructor;
import net.mayeye.site.property.FineDustCategories;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.stereotype.Component;

import java.io.*;
import java.net.MalformedURLException;
import java.net.URL;

/**
 * FineDustDataParser.java
 * 미세먼지 공공기관 API
 * ==============================================
 *
 * @author BJH
 * @history 작성일            작성자     변경내용
 * @history 2019-09-02         BJH      최초작성
 * ==============================================
 */
@Component
@RequiredArgsConstructor
public class FineDustDataParser {

    /**
     * 요청 메세지 명세
     * (필수) ServiceKey 서비스인증
     * (필수) dataTerm 데이터기간
     * (필수) sidonName 시도명
     * numOfRows 한 페이지 결과 수
     * pageNo 페이지 번호
     * ver 오퍼레이션 버전
     */

    /**
     * 버전(Version)
     * - 버전을 포함하지 않고 호출할 경우 : PM2.5 데이터가 포함되지 않은 원래 오퍼레이션 결과 표출.
     * - 버전 1.0을 호출할 경우 : PM2.5 데이터가 포함된 결과 표출.
     * - 버전 1.1을 호출할 경우 : PM10, PM2.5 24시간 예측이동 평균데이터가 포함된 결과 표출.
     * - 버전 1.2을 호출할 경우 : 측정망 정보 데이터가 포함된 결과 표출.
     * - 버전 1.3을 호출할 경우 : PM10, PM2.5 1시간 등급 자료가 포함된 결과 표출
     */

    private final ObjectMapper objectMapper;
    private final FineDustCategories fineDustCategories;
    private final ResourceLoader resouceLoader;
    private final int BUFFERED_BYTE_SIZE = 1024;
    private final String filePath ="\\finedust\\finedust.json";

    public String getFineDustDto() {
        String fineDust = "";

        try {
            /* reqUrl을 이용하여 URL 객체 생성 */
            URL url = new URL(generateFinDustAPI());
            BufferedReader br = new BufferedReader(new InputStreamReader(url.openStream()));
            String line = "";
            String result = "";

            /* 버퍼에 있는 정보를 하나의 문자열로 변환 */
            while ((line = br.readLine()) != null) {
                result = result.concat(line);
            }

            //Reading the XML
            XmlMapper xmlMapper = new XmlMapper();
            FineDustWrapper fineDustWrapper = xmlMapper.readValue(result, FineDustWrapper.class);
            FineDustBody body = fineDustWrapper.getBody();
            body.updateDate();
            fineDust = objectMapper.writeValueAsString(body);
            br.close();
        } catch (MalformedURLException e) {
            throw new RuntimeException("URL 객체 생성에 실패했습니다.");
        } catch (IOException e) {
            throw new RuntimeException("API를 가져오는데 실패했습니다.");
        }
        return fineDust;
    }

    /**
     * 미세먼지 URI 생성
     * @return
     */
    private String generateFinDustAPI() {
        String sidoName = fineDustCategories.getSidoName();
        String serviceKey = fineDustCategories.getServiceKey();

        /** 임시로 필수값만 설정 */
        String fineDustAPI = "http://openapi.airkorea.or.kr/openapi/services/rest/ArpltnInforInqireSvc/getCtprvnRltmMesureDnsty?"
                + "sidoName=" + sidoName + "&ServiceKey=" + serviceKey;

        return  fineDustAPI;
    }

    /**
     * JSON 형식의 문자열을 JSON파일로 출력
     * @param data
     * @return
     */
    public boolean writeJsonFile(String data) {
        File jsonFile = null;
        BufferedOutputStream bos = null;
        Resource resource = resouceLoader.getResource(filePath);
        try {
            jsonFile = resource.getFile();

            FileOutputStream fos = new FileOutputStream(jsonFile);
            bos = new BufferedOutputStream(fos,BUFFERED_BYTE_SIZE);
            bos.write(data.getBytes());
        } catch (IOException e) {
            throw new RuntimeException("JSON 파일 출력 오류");
        }finally {
            try {
                bos.flush();
                bos.close();
            } catch (IOException e) {
                throw new RuntimeException("JSON 파일 출력 오류");
            }
        }
        return true;
    }

}
