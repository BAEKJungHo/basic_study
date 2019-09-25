package net.mayeye.core.util;

import java.io.IOException;
import java.text.MessageFormat;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

/**
 * MecPagingRenderer.java
 * Paging 처리를 위한 TagLib class
 * ==============================================
 * @author 박준영
 * @history     작성일     작성자     변경내용
 * @history 2019.03.18    박준영      최초작성
 * ==============================================
 */
public class MecPagingRenderer extends TagSupport {
    private static final long serialVersionUID = 1L;
    private MecPagingHelper pagingHelper;
    private String type;
    private String jsFunction;
    private String firstPageLabel;
    private String previousPageLabel;
    private String currentPageLabel;
    private String otherPageLabel;
    private String nextPageLabel;
    private String lastPageLabel;

    public MecPagingRenderer() {
    }

    private String renderPagination(){
        StringBuffer strBuff = new StringBuffer();
        int firstPageNo = pagingHelper.getFirstPageNo();
        int firstPageNoOnPageList = pagingHelper.getFirstPageNoOnPageList();
        int totalPageCount = pagingHelper.getTotalPageCount();
        int pageSize = pagingHelper.getPageSize();
        int lastPageNoOnPageList = pagingHelper.getLastPageNoOnPageList();
        int currentPageNo = pagingHelper.getCurrentPageNo();
        int lastPageNo = pagingHelper.getLastPageNo();
        if (totalPageCount > pageSize) {
            if (firstPageNoOnPageList > pageSize) {
                strBuff.append(MessageFormat.format(this.firstPageLabel, jsFunction, Integer.toString(firstPageNo)));
                strBuff.append(MessageFormat.format(this.previousPageLabel, jsFunction, Integer.toString(firstPageNoOnPageList - 1)));
            } else {
                strBuff.append(MessageFormat.format(this.firstPageLabel, jsFunction, Integer.toString(firstPageNo)));
                strBuff.append(MessageFormat.format(this.previousPageLabel, jsFunction, Integer.toString(firstPageNo)));
            }
        }

        for(int i = firstPageNoOnPageList; i <= lastPageNoOnPageList; ++i) {
            if (i == currentPageNo) {
                strBuff.append(MessageFormat.format(this.currentPageLabel, Integer.toString(i)));
            } else {
                strBuff.append(MessageFormat.format(this.otherPageLabel, jsFunction, Integer.toString(i), Integer.toString(i)));
            }
        }

        if (totalPageCount > pageSize) {
            if (lastPageNoOnPageList < totalPageCount) {
                strBuff.append(MessageFormat.format(this.nextPageLabel, jsFunction, Integer.toString(firstPageNoOnPageList + pageSize)));
                strBuff.append(MessageFormat.format(this.lastPageLabel, jsFunction, Integer.toString(lastPageNo)));
            } else {
                strBuff.append(MessageFormat.format(this.nextPageLabel, jsFunction, Integer.toString(lastPageNo)));
                strBuff.append(MessageFormat.format(this.lastPageLabel, jsFunction, Integer.toString(lastPageNo)));
            }
        }

        return strBuff.toString();
    }

    public void initVariables(){
        firstPageLabel    = "<a href=\"?pageIndex={1}\" onclick=\"{0}({1});return false;\" class=\"page_first\" ></a>";
        previousPageLabel = "<a href=\"?pageIndex={1}\" onclick=\"{0}({1});return false;\" class=\"page_left\" ></a>";
        currentPageLabel  = "<a href=\"#\"onclick=\"return false;\" class=\"on\">{0}</a>";
        otherPageLabel    = "<a href=\"?pageIndex={1}\" onclick=\"{0}({1});return false; \">{2}</a>";
        nextPageLabel     = "<a href=\"?pageIndex={1}\" onclick=\"{0}({1});return false;\" class=\"page_right\" ></a>";
        lastPageLabel     = "<a href=\"?pageIndex={1}\" onclick=\"{0}({1});return false;\" class=\"page_end\" ></a>";
    }

    public int doEndTag() throws JspException {
        try {
            JspWriter out = this.pageContext.getOut();
            initVariables();
            String contents = renderPagination();
            out.println(contents);
            return 6;
        } catch (IOException var6) {
            throw new JspException();
        }
    }

    public void setJsFunction(String jsFunction) {
        this.jsFunction = jsFunction;
    }

    public void setPagingHelper(MecPagingHelper pagingHelper) {
        this.pagingHelper = pagingHelper;
    }

    public void setType(String type) {
        this.type = type;
    }
}
