package net.mayeye.core.model;

import java.io.Serializable;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;
import net.mayeye.core.util.MecPagingHelper;

/**
 * BaseVO.java
 * 공통 검색조건 , SEQ , Paging처리  BaseVO
 * ==============================================
 * @author 박준영
 * @history     작성일     작성자     변경내용
 * @history 2019.03.18    박준영      최초작성
 * ==============================================
 */
@Getter
@Setter
@Alias("base")
public class BaseVo implements Serializable {

    protected Integer seq;
    /** 검색조건 */
    protected String searchCondition = "";
    /** 검색Keyword */
    protected String searchKeyword = "";
    /** 검색사용여부 */
    protected String searchUseYn = "";
    /** 현재페이지 */
    protected int pageIndex = 1;
    /** 페이지갯수 */
    protected int pageUnit = 10;
    /** 페이지사이즈 */
    protected int pageSize = 5;
    /** firstIndex */
    protected int firstIndex = 1;
    /** lastIndex */
    protected int lastIndex = 1;
    /** recordCountPerPage */
    protected int recordCountPerPage = 10;
    /** 검색KeywordFrom */
    protected String searchKeywordFrom = "";
    /** 검색KeywordTo */
    protected String searchKeywordTo = "";
    /** 수정일 */
    protected String modDate = "";
    /** 수정자 */
    protected String modId = "";
    /** 등록일 */
    protected String regDate = "";
    /** 등록자 */
    protected String regId = "";
    /** 삭제여부 */
    protected String delSts = "";
    /** 조회수 */
    protected String hits = "0";
    /** 현재페이지2 */
    protected int pageIndex2 = 1;
    /** 검색조건2 */
    protected String searchCondition2 = "";
    /** 검색Keyword2 */
    protected String searchKeyword2 = "";
    /** 공공누리 코드 */
    protected String nuriCode ="1";
    
    public boolean isNew() {
        return this.seq == null;
    }

    public void initPaging(MecPagingHelper helper) {
        this.firstIndex = helper.getFirstRecordIndex();
        this.lastIndex = helper.getLastRecordIndex();
        this.recordCountPerPage = helper.getRecordCountPerPage();
    }
}
