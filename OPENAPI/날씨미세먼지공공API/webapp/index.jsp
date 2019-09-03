<%--
/**
 * index.jsp
 * 
 * ==============================================
 * @author BJH
 * @history     작성일            작성자     변경내용
 * @history     2019-09-02         BJH      최초작성
 * ==============================================
 */
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="util" uri="http://mec.mayeye.net/util" %>
    <!-- Content :S -->
    <div id="content" class="slide_cont">
        <div class="weather">
            <div class="img_area">
                <img id="weather-image" src="" alt=""/>
                    <!-- 날씨에 따른 이미지 -->
            </div>
            <div class="text_area">
                <p id="weather-date">
                    <!-- 날씨 -->
                </p>
                <p id="fine-dust">
                    <!-- 미세먼지 -->
                    <span id="dust"> </span>
                    <span class="font_blue" id="pm10Value"> </span>
                    <span class="blue_box" id="status"> </span>
                </p>
            </div>
        </div>
        <div id="slide_pointer">
            <a href="#link" class="sec01"><span>동구</span></a>
            <a href="#link" class="sec02"><span>소식</span></a>
            <a href="#link" class="sec03"><span>민원</span></a>
            <a href="#link" class="sec04"><span>관광</span></a>
        </div>
        <a href="#" class="prev_btn">이전 콘텐츠 보기</a>
        <a href="#" class="next_btn">다음 콘텐츠 보기</a>
        <div id="slide_visual">
            <div class="one"> <!--sec1 S-->
                <h4 class="section_title">신바람 동구</h4>
                <div class="visual_slide js_slide type_03">
                    <div class="control">
                        <span class="count">1<span>/4</span></span>
                        <a href="#" class="btn_left"><span>이전</span></a>
                        <a href="#" class="btn_play"><span>재생</span></a>
                        <a href="#" class="btn_stop"><span>정지</span></a>
                        <a href="#" class="btn_right"><span>다음</span></a>
                    </div>
                    <div class="move">
                        <ul>
                            <li class="lazy" data-src="/images/site/kor/main/vi01_01.jpg"><p><span>식장산에서 본 동구전경</span></p></li>
                            <li class="lazy" data-src="/images/site/kor/main/vi01_02.jpg"><p><span>대청호반</span></p></li>
                            <li class="lazy" data-src="/images/site/kor/main/vi01_03.jpg"><p><span>대동하늘공원</span></p></li>
                            <li class="lazy" data-src="/images/site/kor/main/vi01_04.jpg"><p><span>우암사적공원</span></p></li>
                        </ul>
                    </div>
                </div>
                <div class="sec01_cont">
                    <div class="layout">
                        <div class="elem donggu_prod">
                            <a href="#link" class="donggu_prod_btn">동구의 <span>자랑거리</span><em class="hidden">열기</em></a>
                            <div class="donggu_prod_cont">
                                <strong>동구의 자랑<em>!</em></strong>
                                <p>표창, 수상실적을 <em>확인하실 수 있습니다.</em></p>
                                <a href="#link">바로가기</a>
                            </div>
                        </div>
                        <div class="elem pop_zone">
                            <div class="js_slide type_02">
                                <h4 class="hidden">팝업존</h4>
                                <div class="control">
                                    <span class="count">1<span>/2</span></span>
                                    <a href="#link" class="btn_left"><span>이전</span></a>
                                    <a href="#link" class="btn_play"><span>재생</span></a>
                                    <a href="#link" class="btn_stop"><span>정지</span></a>
                                    <a href="#link" class="btn_right"><span>다음</span></a>
                                    <a href="#link" class="btn_plus"><span>더보기</span></a>
                                </div>
                                <div class="move">
                                    <ul>
                                        <li><a href="#link"><span><img src="/images/site/kor/main/v1_img1.jpg" alt="" /></span></a></li>
                                        <li><a href="#link"><span><img src="/images/site/kor/main/v1_img1.jpg" alt="" /></span></a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>

                        <div class="elem donggu_list">
                            <ul>
                                <li><a href="#link">평생학습과</a></li>
                                <li><a href="#link">동구보건소</a></li>
                                <li><a href="#link">대청호생태관</a></li>
                            </ul>
                        </div>
                        <div class="elem person_area">
                            <p class="ment">열린구청장실 <em>동구청장 <span class="person">황인호</span><span>입니다.</span></em></p>
                            <a href="#link" class="round_link">구청장에게 바란다</a>
                            <a href="#link" class="round_link">구민과의 약속 공약사업</a>
                            <div class="donggu_guide">
                                <ul>
                                    <li><a href="#link">청사안내</a></li>
                                    <li><a href="#link">부서안내</a></li>
                                    <li><a href="#link">조직전화번호</a></li>
                                    <li><a href="#link">찾아오시는길</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div> <!--sec1 E-->
            <div class="two"> <!--sec2 S-->
                <h4 class="section_title">새로운 소식</h4>
                <div class="sec02_cont">
                    <div class="layout">
                        <div class="elem news_tab">
                            <div class="tab_btn">
                                <ul>
                                    <li><a href="#tab01" class="on">공지사항</a>
                                    <li><a href="#tab02">채용공고</a></li>
                                    <li><a href="#tab03">고시공고</a></li>
                                    <li><a href="#tab04">입법예고</a></li>
                                    <li><a href="#tab05">입찰공고</a></li>
                                </ul>
                            </div>
                            <div class="tab_cont on" id="tab01">
                                <h4 class="hidden">공지사항</h4>
                                <ul>
                                    <li class="noti">
											<span class="subject">
												<a href="#link">도시관리계획(도시계획시설:학교) 결정(변경)(안) 열람</a>
											</span>
                                        <span class="date">2019-06-18</span>
                                    </li>
                                    <li class="noti">
											<span class="subject">
												<a href="#link">2019년 대전미래여성아카데미 운영</a>
											</span>
                                        <span class="date">2019-06-18</span>
                                    </li>
                                    <li>
											<span class="subject">
												<a href="#link">학교 밖 청소년 건강검진 안내</a>
											</span>
                                        <span class="date">2019-06-18</span>
                                    </li>
                                    <li>
											<span class="subject">
												<a href="#link">법인지방소득세 확정신고 및 제출서류 안내</a>
											</span>
                                        <span class="date">2019-06-18</span>
                                    </li>
                                    <li>
											<span class="subject">
												<a href="#link">동구 지역주택조합 조합원 가입에 따른 유의사항 안내</a>
											</span>
                                        <span class="date">2019-06-18</span>
                                    </li>
                                </ul>
                                <a href="#link" class="more_btn">공지사항 더보기</a>
                            </div>
                            <div class="tab_cont" id="tab02">
                                <h4 class="hidden">채용공고</h4>
                                <ul>
                                    <li class="noti">
											<span class="subject">
												<a href="#link">2019년 대전미래여성아카데미 운영</a>
											</span>
                                        <span class="date">2019-06-18</span>
                                    </li>
                                    <li class="noti">
											<span class="subject">
												<a href="#link">도시관리계획(도시계획시설:학교) 결정(변경)(안) 열람</a>
											</span>
                                        <span class="date">2019-06-18</span>
                                    </li>
                                    <li>
											<span class="subject">
												<a href="#link">학교 밖 청소년 건강검진 안내</a>
											</span>
                                        <span class="date">2019-06-18</span>
                                    </li>
                                    <li>
											<span class="subject">
												<a href="#link">법인지방소득세 확정신고 및 제출서류 안내</a>
											</span>
                                        <span class="date">2019-06-18</span>
                                    </li>
                                    <li>
											<span class="subject">
												<a href="#link">동구 지역주택조합 조합원 가입에 따른 유의사항 안내</a>
											</span>
                                        <span class="date">2019-06-18</span>
                                    </li>
                                </ul>
                                <a href="#link" class="more_btn">채용공고 더보기</a>
                            </div>
                            <div class="tab_cont" id="tab03">
                                <h4 class="hidden">고시공고</h4>
                                <ul>
                                    <li class="noti">
											<span class="subject">
												<a href="#link">2019년 대전미래여성아카데미 운영</a>
											</span>
                                        <span class="date">2019-06-18</span>
                                    </li>
                                    <li class="noti">
											<span class="subject">
												<a href="#link">도시관리계획(도시계획시설:학교) 결정(변경)(안) 열람</a>
											</span>
                                        <span class="date">2019-06-18</span>
                                    </li>
                                    <li>
											<span class="subject">
												<a href="#link">법인지방소득세 확정신고 및 제출서류 안내</a>
											</span>
                                        <span class="date">2019-06-18</span>
                                    </li>
                                    <li>
											<span class="subject">
												<a href="#link">학교 밖 청소년 건강검진 안내</a>
											</span>
                                        <span class="date">2019-06-18</span>
                                    </li>
                                    <li>
											<span class="subject">
												<a href="#link">동구 지역주택조합 조합원 가입에 따른 유의사항 안내</a>
											</span>
                                        <span class="date">2019-06-18</span>
                                    </li>
                                </ul>
                                <a href="#link" class="more_btn">고시공고 더보기</a>
                            </div>
                            <div class="tab_cont" id="tab04">
                                <h4 class="hidden">입법예고</h4>
                                <ul>
                                    <li class="noti">
											<span class="subject">
												<a href="#link">2019년 대전미래여성아카데미 운영</a>
											</span>
                                        <span class="date">2019-06-18</span>
                                    </li>
                                    <li class="noti">
											<span class="subject">
												<a href="#link">도시관리계획(도시계획시설:학교) 결정(변경)(안) 열람</a>
											</span>
                                        <span class="date">2019-06-18</span>
                                    </li>
                                    <li>
											<span class="subject">
												<a href="#link">법인지방소득세 확정신고 및 제출서류 안내</a>
											</span>
                                        <span class="date">2019-06-18</span>
                                    </li>
                                    <li>
											<span class="subject">
												<a href="#link">학교 밖 청소년 건강검진 안내</a>
											</span>
                                        <span class="date">2019-06-18</span>
                                    </li>
                                    <li>
											<span class="subject">
												<a href="#link">동구 지역주택조합 조합원 가입에 따른 유의사항 안내</a>
											</span>
                                        <span class="date">2019-06-18</span>
                                    </li>
                                </ul>
                                <a href="#link" class="more_btn">입법예고 더보기</a>
                            </div>
                            <div class="tab_cont" id="tab05">
                                <h4 class="hidden">입찰공고</h4>
                                <ul>
                                    <li class="noti">
											<span class="subject">
												<a href="#link">2019년 대전미래여성아카데미 운영</a>
											</span>
                                        <span class="date">2019-06-18</span>
                                    </li>
                                    <li class="noti">
											<span class="subject">
												<a href="#link">도시관리계획(도시계획시설:학교) 결정(변경)(안) 열람</a>
											</span>
                                        <span class="date">2019-06-18</span>
                                    </li>
                                    <li>
											<span class="subject">
												<a href="#link">법인지방소득세 확정신고 및 제출서류 안내</a>
											</span>
                                        <span class="date">2019-06-18</span>
                                    </li>
                                    <li>
											<span class="subject">
												<a href="#link">학교 밖 청소년 건강검진 안내</a>
											</span>
                                        <span class="date">2019-06-18</span>
                                    </li>
                                    <li>
											<span class="subject">
												<a href="#link">동구 지역주택조합 조합원 가입에 따른 유의사항 안내</a>
											</span>
                                        <span class="date">2019-06-18</span>
                                    </li>
                                </ul>
                                <a href="#link" class="more_btn">입찰공고 더보기</a>
                            </div>
                        </div>
                        <div class="elem alert_pop">
                            <div class="js_slide type_02">
                                <h4 class="hidden">팝업존</h4>
                                <div class="control">
                                    <span class="tit">알림창</span>
                                    <a href="#link" class="btn_left"><span>이전</span></a>
                                    <a href="#link" class="btn_play"><span>재생</span></a>
                                    <a href="#link" class="btn_stop"><span>정지</span></a>
                                    <a href="#link" class="btn_right"><span>다음</span></a>
                                    <a href="#link" class="btn_plus"><span>더보기</span></a>
                                </div>
                                <div class="move">
                                    <ul>
                                        <li><a href="#link"><span><img src="/images/site/kor/main/v2_jpg01.jpg" alt="" /></span></a></li>
                                        <li><a href="#link"><span><img src="/images/site/kor/main/v2_jpg01.jpg" alt="" /></span></a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="elem sns_area">
                            <ul>
                                <li><a href="#link"><span>Facebook</span></a></li>
                                <li><a href="#link"><span>Twitter</span></a></li>
                                <li><a href="#link"><span>Blog</span></a></li>
                            </ul>
                        </div>
                        <div class="elem news_area">
                            <h4 class="news_title">동구청 뉴스</h4>
                            <div class="news_list">
                                <ul>
                                    <li>
                                        <a href="#link">
                                            <div class="img_area">
                                                <span class="card ty1">보도자료</span>
                                                <span class="imgs">
														<img src="/images/site/kor/main/v2_jpg02.jpg" alt="" />
													</span>
                                            </div>
                                            <strong class="subject">전국 일자리 대상</strong>
                                            <span class="date">2019-04-12</span>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="#link">
                                            <div class="img_area">
                                                <span class="card ty2">포토뉴스</span>
                                                <span class="imgs">
														<img src="/images/site/kor/main/v2_jpg03.jpg" alt="" />
													</span>
                                            </div>
                                            <strong class="subject">전국 일자리 대상 우수상 수상</strong>
                                            <span class="date">2019-04-12</span>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="#link">
                                            <div class="img_area yung">
                                                <span class="card ty3">영상뉴스</span>
                                                <span class="imgs">
														<img src="/images/site/kor/main/v2_jpg04.jpg" alt="" />
													</span>
                                            </div>
                                            <strong class="subject">제1회 대청호 벚꽃축제</strong>
                                            <span class="date">2019-04-12</span>
                                        </a>
                                    </li>
                                </ul>
                                <div class="swiper-scrollbar"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div> <!--sec2 E-->
            <div class="three"> <!--sec3-->
                <h4 class="section_title">편리한 민원</h4>
                <div class="sec03_cont">
                    <div class="layout">
                        <div class="elem map_area">
                            <h4>우리동네 <span>행정복지센터</span></h4>
                            <p class="guide">이미지 클릭시 해당 복지센터 이동</p>
                            <ul class="map_group">
                                <li>
                                    <a href="#link" class="map_btn on">가양1동</a>
                                    <div class="map_cont">
                                        <a href="#link" class="map_img" title="클릭 시 가양1동 복지센터로 이동합니다.">가양1동 복지센터</a>
                                    </div>
                                </li>
                                <li>
                                    <a href="#link" class="map_btn">가양2동</a>
                                    <div class="map_cont">
                                        <a href="#link" class="map_img" title="클릭 시 가양2동 복지센터로 이동합니다.">가양2동 복지센터</a>
                                    </div>
                                </li>
                                <li>
                                    <a href="#link" class="map_btn">대동</a>
                                    <div class="map_cont">
                                        <a href="#link" class="map_img" title="클릭 시 대동 복지센터로 이동합니다.">대동 복지센터</a>
                                    </div>
                                </li>
                                <li>
                                    <a href="#link" class="map_btn">대청동</a>
                                    <div class="map_cont">
                                        <a href="#link" class="map_img" title="클릭 시 대청동 복지센터로 이동합니다.">대청동 복지센터</a>
                                    </div>
                                </li>
                                <li>
                                    <a href="#link" class="map_btn">산내동</a>
                                    <div class="map_cont">
                                        <a href="#link" class="map_img" title="클릭 시 산내동 복지센터로 이동합니다.">산내동 복지센터</a>
                                    </div>
                                </li>
                                <li>
                                    <a href="#link" class="map_btn">삼성동</a>
                                    <div class="map_cont">
                                        <a href="#link" class="map_img" title="클릭 시 삼성동 복지센터로 이동합니다.">삼성동 복지센터</a>
                                    </div>
                                </li>
                                <li>
                                    <a href="#link" class="map_btn">성남동</a>
                                    <div class="map_cont">
                                        <a href="#link" class="map_img" title="클릭 시 성남동 복지센터로 이동합니다.">성남동 복지센터</a>
                                    </div>
                                </li>
                                <li>
                                    <a href="#link" class="map_btn">신인동</a>
                                    <div class="map_cont">
                                        <a href="#link" class="map_img" title="클릭 시 신인동 복지센터로 이동합니다.">신인동 복지센터</a>
                                    </div>
                                </li>
                                <li>
                                    <a href="#link" class="map_btn">용운동</a>
                                    <div class="map_cont">
                                        <a href="#link" class="map_img" title="클릭 시 용운동 복지센터로 이동합니다.">용운동 복지센터</a>
                                    </div>
                                </li>
                                <li>
                                    <a href="#link" class="map_btn">용전동</a>
                                    <div class="map_cont">
                                        <a href="#link" class="map_img" title="클릭 시 용전동 복지센터로 이동합니다.">용전동 복지센터</a>
                                    </div>
                                </li>
                                <li>
                                    <a href="#link" class="map_btn">자양동</a>
                                    <div class="map_cont">
                                        <a href="#link" class="map_img" title="클릭 시 자양동 복지센터로 이동합니다.">자양동 복지센터</a>
                                    </div>
                                </li>
                                <li>
                                    <a href="#link" class="map_btn">중앙동</a>
                                    <div class="map_cont">
                                        <a href="#link" class="map_img" title="클릭 시 중앙동 복지센터로 이동합니다.">중앙동 복지센터</a>
                                    </div>
                                </li>
                                <li>
                                    <a href="#link" class="map_btn">판암1동</a>
                                    <div class="map_cont">
                                        <a href="#link" class="map_img" title="클릭 시 판암1동 복지센터로 이동합니다.">판암1동 복지센터</a>
                                    </div>
                                </li>
                                <li>
                                    <a href="#link" class="map_btn">판암2동</a>
                                    <div class="map_cont">
                                        <a href="#link" class="map_img" title="클릭 시 판암2동 복지센터로 이동합니다.">판암2동 복지센터</a>
                                    </div>
                                </li>
                                <li>
                                    <a href="#link" class="map_btn">홍도동</a>
                                    <div class="map_cont">
                                        <a href="#link" class="map_img" title="클릭 시 홍도동 복지센터로 이동합니다.">홍도동 복지센터</a>
                                    </div>
                                </li>
                                <li>
                                    <a href="#link" class="map_btn">효동</a>
                                    <div class="map_cont">
                                        <a href="#link" class="map_img" title="클릭 시 효동 복지센터로 이동합니다.">효동 복지센터</a>
                                    </div>
                                </li>
                            </ul>
                        </div>
                        <div class="elem service_area">
                            <ul class="service_list">
                                <li>
                                    <a href="#link">무인민원발급기</a>
                                </li>
                                <li>
                                    <a href="#link">지방세안내</a>
                                </li>
                                <li>
                                    <a href="#link">여권발급</a>
                                </li>
                                <li>
                                    <a href="#link">민원실안내</a>
                                </li>
                                <li>
                                    <a href="#link">정부24</a>
                                </li>
                                <li>
                                    <a href="#link">민원서식(편람)</a>
                                </li>
                            </ul>
                            <div class="phone_area">
                                <p>민원이용안내 <a href="tel:042-251-4311">042-251-4311</a></p>
                            </div>
                        </div>
                        <div class="elem banner_area">
                            <h4>주요컨텐츠 바로가기</h4>
                            <p>찾으시는 컨텐츠를 클릭해 주세요.</p>
                            <div class="js_slide slide_banner">
                                <div class="control">
                                    <span class="count"><span>1</span>/1</span>
                                    <a href="#link" class="btn_left"><span>이전</span></a>
                                    <a href="#link" class="btn_play"><span>재생</span></a>
                                    <a href="#link" class="btn_stop"><span>정지</span></a>
                                    <a href="#link" class="btn_right"><span>다음</span></a>
                                </div>
                                <div class="move">
                                    <ul>
                                        <li class="ba1"><a href="#link">대형폐기물</a></li>
                                        <li class="ba2"><a href="#link">민원신청</a></li>
                                        <li class="ba3"><a href="#link">일자리 지원센터</a></li>
                                        <li class="ba4"><a href="#link">의료기관 안내</a></li>
                                        <li class="ba5"><a href="#link">복지광장</a></li>
                                        <li class="ba6"><a href="#link">칭찬합시다</a></li>
                                        <li class="ba7"><a href="#link">제도개선제안</a></li>
                                        <li class="ba8"><a href="#link">설문투표</a></li>
                                        <li class="ba9"><a href="#link">복지광장</a></li>
                                        <li class="ba10"><a href="#link">칭찬합시다</a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div> <!--sec3 E-->
            <div class="four"> <!--sec4-->
                <h4 class="section_title">즐거운 관광</h4>
                <div class="sec04_cont">
                    <div class="layout">
                        <div class="elem eight_slide">
                            <div class="js_slide type_03">
                                <div class="control">
                                    <a href="#" class="btn_left"><span>이전</span></a>
                                    <span class="count">1<span>/8</span></span>
                                    <a href="#" class="btn_right"><span>다음</span></a>
                                    <a href="#" class="btn_play"><span>재생</span></a>
                                    <a href="#" class="btn_stop"><span>정지</span></a>
                                </div>
                                <div class="move">
                                    <ul>
                                        <li>
                                            <a href="#link">
													<span class="txts">
														<span>동구 8경</span>
														<img src="/images/site/kor/main/v4_ti1.png" alt="1경" />
														<p>식장산</p>
													</span>
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#link">
													<span class="txts">
														<span>동구 8경</span>
														<img src="/images/site/kor/main/v4_ti2.png" alt="2경" />
														<p>대청호반</p>
													</span>
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#link">
													<span class="txts">
														<span>동구 8경</span>
														<img src="/images/site/kor/main/v4_ti3.png" alt="3경" />
														<p>만인산 자연휴양림</p>
													</span>
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#link">
													<span class="txts">
														<span>동구 8경</span>
														<img src="/images/site/kor/main/v4_ti4.png" alt="4경" />
														<p>상소동 산림욕장</p>
													</span>
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#link">
													<span class="txts">
														<span>동구 8경</span>
														<img src="/images/site/kor/main/v4_ti5.png" alt="5경" />
														<p>대동하늘공원</p>
													</span>
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#link">
													<span class="txts">
														<span>동구 8경</span>
														<img src="/images/site/kor/main/v4_ti6.png" alt="6경" />
														<p>우암사적공원</p>
													</span>
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#link">
													<span class="txts">
														<span>동구 8경</span>
														<img src="/images/site/kor/main/v4_ti7.png" alt="7경" />
														<p>중앙시장</p>
													</span>
                                            </a>
                                        </li>
                                        <li>
                                            <a href="#link">
													<span class="txts">
														<span>동구 8경</span>
														<img src="/images/site/kor/main/v4_ti8.png" alt="8경" />
														<p>대전역</p>
													</span>
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="elem cyber_tour">
                            <h4>사이버투어 VR</h4>
                            <a href="#link">
                                <p>동구의 주요 명소를<em>VR투어로 만나보는 시간!</em></p>
                            </a>
                        </div>
                        <div class="elem contents_list">
                            <div class="list_group">
                                <ul class="sub_group">
                                    <li>
                                        <h4>동구민</h4>
                                        <ul>
                                            <li>
                                                <a href="#link">어디서나민원</a>
                                            </li>
                                            <li>
                                                <a href="#link">무인민원발급기</a>
                                            </li>
                                            <li>
                                                <a href="#link">민원신고센터</a>
                                            </li>
                                            <li>
                                                <a href="#link">일자리(취업/채용)</a>
                                            </li>
                                            <li>
                                                <a href="#link">평생학습과</a>
                                            </li>
                                            <li>
                                                <a href="#link">정보화교육</a>
                                            </li>
                                            <li>
                                                <a href="#link">칭찬합시다</a>
                                            </li>
                                            <li>
                                                <a href="#link">쓰레기배출안내</a>
                                            </li>
                                        </ul>
                                    </li>
                                    <li>
                                        <h4>관광객</h4>
                                        <ul>
                                            <li>
                                                <a href="#link">동구8경</a>
                                            </li>
                                            <li>
                                                <a href="#link">지역행사참여</a>
                                            </li>
                                            <li>
                                                <a href="#link">동구축제</a>
                                            </li>
                                            <li>
                                                <a href="#link">맛집정보</a>
                                            </li>
                                            <li>
                                                <a href="#link">사이버투어 VR</a>
                                            </li>
                                            <li>
                                                <a href="#link">관광안내 책자신청</a>
                                            </li>
                                            <li>
                                                <a href="#link">전통시장주차안내</a>
                                            </li>
                                            <li>
                                                <a href="#link">숙박정보</a>
                                            </li>
                                        </ul>
                                    </li>
                                    <li>
                                        <h4>사업자</h4>
                                        <ul>
                                            <li>
                                                <a href="#link">계약정보공개</a>
                                            </li>
                                            <li>
                                                <a href="#link">관내주요기관</a>
                                            </li>
                                            <li>
                                                <a href="#link">온라인현수막신청</a>
                                            </li>
                                            <li>
                                                <a href="#link">중소기업정보</a>
                                            </li>
                                            <li>
                                                <a href="#link">부동산종합정보</a>
                                            </li>
                                            <li>
                                                <a href="#link">지방세 납부/환급</a>
                                            </li>
                                            <li>
                                                <a href="#link">일자리지원센터</a>
                                            </li>
                                            <li>
                                                <a href="#link">개별공시지가</a>
                                            </li>
                                        </ul>
                                    </li>
                                </ul>
                                <div class="swiper-scrollbar"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div> <!--sec4 E-->
        </div>
    </div>
    <!-- Content :E -->
    <!--베너모음 S-->
    <div class="main_banner">
        <div class="layout">
            <div class="moumbox">
                <div class="moum">
                    <strong>배너모음</strong>
                    <div class="btns">
                        <ul>
                            <li><a href="#" class="btn_left">left</a></li>
                            <li><a href="#" class="btn_stop">stop</a></li>
                            <li><a href="#" class="btn_play">play</a></li>
                            <li><a href="#" class="btn_right">right</a></li>
                            <li><a href="#" class="btn_plus">plus</a></li>
                        </ul>
                    </div>
                </div>
                <div class="menu">
                    <ul>
                        <li><a href="#">대전지방기상청</a></li>
                        <li><a href="#">학교폭력예방누리집</a></li>
                        <li><a href="#">녹색건축포털 그린투게더</a></li>
                        <li><a href="#">온라인 행정심판</a></li>
                        <li><a href="#">마을세무사</a></li>
                        <li><a href="#">안내 여성폭력 사이버상담</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <!--베너모음 E-->
<script src="<c:url value="/js/site/kor/kor.js"/>" type="text/babel" data-presets="es2015,stage-2" charset="UTF-8"></script>
<script type="text/babel" data-presets="es2015,stage-2" charset="UTF-8">
    main.init();
</script>