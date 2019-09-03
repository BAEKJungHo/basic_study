package net.mayeye.site.openapi.finedust;

import lombok.Getter;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;

/**
 * FineDustWrapper.java
 * 미세먼지 XNL TO JSON
 * ==============================================
 *
 * @author BJH
 * @history 작성일            작성자     변경내용
 * @history 2019-09-03         BJH      최초작성
 * ==============================================
 */
@Getter @Setter
public class FineDustWrapper {

    /**
     * XML TO JSON 변환시 header와 body를 담기 위한 변수
     */
    private List header = new ArrayList();
    private FineDustBody body;
}
