package net.mayeye.site.openapi.scheduler;

import lombok.RequiredArgsConstructor;
import net.mayeye.site.openapi.finedust.FineDustDataParser;
import net.mayeye.site.openapi.weather.ForecastSpaceDataParser;
import net.mayeye.site.openapi.weather.WeatherDto;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

/**
 * SchedulerController.java
 * 동네예보정보조회서비스와 미세먼지 API 스케줄러
 * ==============================================
 *
 * @author BJH
 * @history 작성일            작성자     변경내용
 * @history 2019-09-03         BJH      최초작성
 * ==============================================
 */

@Component
@RequiredArgsConstructor
public class Scheduler {

    private final ForecastSpaceDataParser forecastSpaceDataParser;
    private final FineDustDataParser fineDustDataParser;

    /**
     * 날씨정보 API를 핸들러 메서드에 스케줄러 등록
     */
    @Scheduled(cron="0 30 2,5,8,11,14,17,20,23 * * ?")
    public void doScheduleWeatherAPI() {
        WeatherDto weatherDto = forecastSpaceDataParser.getWeatherDto();
        weatherDto.updateDate();
        String json = forecastSpaceDataParser.weatherDtoToJson(weatherDto);
        forecastSpaceDataParser.writeJsonFile(json);

    }

    /**
     * 미세먼지정보 API를 핸들러 메서드에 스케줄러 등록
     */
    @Scheduled(cron="0 30 5,11,17,23 * * ?")
    public void doScheduleFineDustAPI() {
        fineDustDataParser.writeJsonFile(fineDustDataParser.getFineDustDto());
    }

}
