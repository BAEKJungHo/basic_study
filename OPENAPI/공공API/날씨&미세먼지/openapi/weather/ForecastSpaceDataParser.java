package net.mayeye.site.openapi.weather;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import net.mayeye.site.property.WeatherCategories;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.stereotype.Component;

import java.io.*;
import java.net.MalformedURLException;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.Calendar;

/**
 * ForecastTownParser.java
 * 동네예보정보조회서비스 공공기관 API
 * ==============================================
 *
 * @author BJH
 * @history 작성일            작성자     변경내용
 * @history 2019-09-02         BJH      최초작성
 * ==============================================
 */
@Component
@RequiredArgsConstructor
public class ForecastSpaceDataParser {

    /**
     * 요청 메세지 명세
     * (필수) ServiceKey 서비스인증
     * (필수) base_data 발표일자
     * (필수) base_time 발표시각
     * (필수) nx 예보지점 X 좌표
     * (필수) ny 예보지점 Y 좌표
     * numOfRows 한 페이지 결과 수
     * pageNo 페이지 번호
     * _type 타입(xml(기본값), json) : 반환데이터형식
     */

    /**
     * Request Message Specific Example
     * X좌표 : private static final String nx = "67";
     * Y좌표 : private static final String ny = "100";
     * 조회하고 싶은 날짜 : private static final String baseDate = "20190902";
     * 조회하고 싶은 시간 : private static final String baseTime = "0500";
     */

    /**
     * 코드값에 따른 범주(category)
     * 코드(SKY) : 맑음(1), 구름많음(3), 흐림(4)
     * -- 구름조금(2) 2019.06.04 삭제됨
     * 코드(PTY, 강수형태) : 없음(0), 비(1), 비/눈=진눈깨비(2), 눈(3), 소나기(4)
     */

    private final WeatherCategories weatherCategories;
    private final ObjectMapper objectMapper;
    private final ResourceLoader resouceLoader;
    private final String filePath ="\\weather\\weather.json";
    private final int BUFFERED_BYTE_SIZE = 1024;

    /**
     * 날씨 구하는 메서드
     * @return
     */
    public WeatherDto getWeatherDto() {
        /* WeatherDto : JSON으로 받아온 데이터를 저장 */
        WeatherDto weatherDto = new WeatherDto();

        /* WeatherDto에 baseDate, baseTime 저장 */
        weatherDto.setBaseDate(getCurrentDate());
        weatherDto.setBaseTime(getCurrentTimeForGetWeather());

        /* 날씨 정보 받아오기 */
        try {
            /* reqUrl을 이용하여 URL 객체 생성 */
            URL url = new URL(generateForecastAPI());
            BufferedReader bf = new BufferedReader(new InputStreamReader(url.openStream()));
            String line = "";
            String result = "";

            /* 버퍼에 있는 정보를 하나의 문자열로 변환 */
            while ((line = bf.readLine()) != null) {
                result = result.concat(line);
            }
            /* JSONParser로 만들어진 문자열 데이터를 객체화 하기 */
            JSONParser jsonParser = new JSONParser();
            JSONObject jsonObj = (JSONObject) jsonParser.parse(result);

            /* TOP 레벨 단계인 response 키를 가지고 데이터를 파싱 */
            JSONObject parseResponse = (JSONObject) jsonObj.get("response");

            /* response로 부터 body를 찾아오기 */
            JSONObject parseBody = (JSONObject) parseResponse.get("body");

            /* body로 부터 items를 받아오기 */
            JSONObject parseItems = (JSONObject) parseBody.get("items");

            /* items로 부터 itemList를 받아오기 */
            JSONArray parseItemList = (JSONArray) parseItems.get("item");

            /* 자료구분 코드 */
            String category;

            /* parseItemList는 배열형태이기 때문에 하나씩 데이터를 가져올때 사용 */
            JSONObject weather;

            /* 필요한 데이터만 가져오기 */
            for (int i = 0; i < parseItemList.size(); i++) {
                weather = (JSONObject) parseItemList.get(i);
                category = (String) weather.get("category");

                /* 데이터 형태를 문자열로 통일 */
                switch (category) {
                    case "POP":
                        weatherDto.pop = (weather.get("fcstValue").toString());
                        break;
                    case "PTY":
                        weatherDto.pty = (weather.get("fcstValue").toString());
                        break;
                    case "R06":
                        weatherDto.r06 = (weather.get("fcstValue").toString());
                        break;
                    case "REH":
                        weatherDto.reh = (weather.get("fcstValue").toString());
                        break;
                    case "S06":
                        weatherDto.s06 = (weather.get("fcstValue").toString());
                        break;
                    case "SKY":
                        weatherDto.sky = (weather.get("fcstValue").toString());
                        break;
                    case "T3H":
                        weatherDto.t3h = (weather.get("fcstValue").toString());
                        break;
                    case "TMN":
                        weatherDto.tmn = (weather.get("fcstValue").toString());
                        break;
                    case "TMX":
                        weatherDto.tmx = (weather.get("fcstValue").toString());
                        break;
                    case "UUU":
                        weatherDto.uuu = (weather.get("fcstValue").toString());
                        break;
                    case "VEC":
                        weatherDto.vec = (weather.get("fcstValue").toString());
                        break;
                    case "VVV":
                        weatherDto.vvv = (weather.get("fcstValue").toString());
                        break;
                    case "WAV":
                        weatherDto.wav = (weather.get("fcstValue").toString());
                        break;
                    case "WSD":
                        weatherDto.wsd = (weather.get("fcstValue").toString());
                        break;
                }
            }
            bf.close();
        } catch (MalformedURLException e) {
            throw new RuntimeException("URL 객체 생성에 실패했습니다.");
        } catch (IOException e) {
            throw new RuntimeException("API를 가져오는데 실패했습니다.");
        } catch (ParseException e) {
            throw new RuntimeException("JSON을 파싱하는 과정에서 실패했습니다.");
        }
        return weatherDto;
    }

    /**
     * RequestUrl 생성
     * @return
     */
    private String generateForecastAPI() {
        String serviceKey = weatherCategories.getServiceKey();
        String nx = weatherCategories.getNx();
        String ny = weatherCategories.getNy();
        String baseDate = getCurrentDate();
        String baseTime = getCurrentTimeForGetWeather();

        /** reqUrl : EndPoint/ForecastSpaceData?URI
         *  URI 부분에는 요청메세지명세에 대한 Key와 Value가 들어간다.
         */
        String forecastAPI = "http://newsky2.kma.go.kr/service/SecndSrtpdFrcstInfoService2/ForecastSpaceData?"
                + "ServiceKey=" + serviceKey + "&base_date=" + baseDate + "&base_time=" + baseTime + "&nx=" + nx + "&ny=" + ny + "&_type=json";

        return forecastAPI;
    }

    /**
     * 현재 날짜 구하기 : baseDate
     * @return
     */
    private String getCurrentDate() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        Calendar cal = Calendar.getInstance();
        return sdf.format(cal.getTime());
    }

    /**
     * 날씨를 얻기 위한 현재 시간 구하기 : baseTime
     * @return
     */
    private String getCurrentTimeForGetWeather() {
        SimpleDateFormat sdf = new SimpleDateFormat("HHmm");
        Calendar currentDate = Calendar.getInstance();
        int tmpTime = Integer.parseInt(sdf.format(currentDate.getTime()));
        if (tmpTime < 210) {
            return null;
        }
        if (tmpTime < 510) {
            return "0200";
        }
        if (tmpTime < 810) {
            return "0500";
        }
        if (tmpTime < 1110) {
            return "0800";
        }
        if (tmpTime < 1410) {
            return "1100";
        }
        if (tmpTime < 1710) {
            return "1400";
        }
        if (tmpTime < 2010) {
            return "1700";
        }
        if (tmpTime < 2310) {
            return "2000";
        }
        return "2300";
    }

    /**
     * WeatherDto를 JSON 형식으로 마샬링
     * @param dto
     */
    public String weatherDtoToJson(Object dto){
        try {
            return  objectMapper.writeValueAsString(dto);
        } catch (JsonProcessingException e) {
            throw new RuntimeException("JSON 변환에 실패하였습니다.");
        }
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
