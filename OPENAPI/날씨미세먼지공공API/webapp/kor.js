const skyWeathers = [
    {
        key: 1,
        src: "/images/site/kor/main/weather_ico1.png",
        alt: "맑음"
    },
    {
        key: 3,
        src: "/images/site/kor/main/weather_ico4.png",
        alt: "구름많음"
    },
    {
        key: 4,
        src: "/images/site/kor/main/weather_ico5.png",
        alt: "흐림"
    }
];

const ptyWeathers = [
    {
        key: 1,
        src: "/images/site/kor/main/weather_ico6.png",
        alt: "비"
    },
    {
        key: 2,
        src: "/images/site/kor/main/weather_ico2.png",
        alt: "비눈"
    },
    {
        key: 3,
        src: "/images/site/kor/main/weather_ico7.png",
        alt: "눈"
    },
    {
        key: 4,
        src: "/images/site/kor/main/weather_ico3.png",
        alt: "소나기"
    }
];

const main = {
    async init () {
        try {
            // 미세먼지 기준 : items[2] : 문창동
            // 기준점 바꿀 경우 서버 재기동 필요 없이 배열 index 만 바꾸면됨
            const fineDustResult = await requestFineDust();
            renderFineDust(fineDustResult);

            const weatherResult = await requestWeather();
            renderWeather(weatherResult);
        } catch (e) {
            console.error(e);
        }
    }
};

// Start Weather
const requestWeather = () => {
    return new Promise((resolve, reject) => {
            // $.getJSON(url, callback)
            // 첫 번째 매개변수로 JSON 파일로드
            // 두 번째 매개변수로 JSON 파일을 이용하여 로드된 데이터 처리, 인자로 데이터를 받는다.
            // 즉, JSON 데이터를 참조하기 위해서 data 변수를 사용
        $.getJSON("/weather/weather.json")
            .done(res => resolve(res))
            .fail(err => reject(err));
    });
};

const renderWeather = (data) => {
    // ES6 문법
    // data.month와 같다. : 객체 방식으로 빼오기 {}
    // $.each()는 [1, 2, 3]과 같은 배열 방식
    const { month, date, day, t3h, sky, pty } = data;
    $('#weather-date').text(month + '월 ' + date + '일 ' + day + ' ' + t3h +'℃');
    if(month === null) {
        throw new Error('날씨 에러');
    }

    console.dir(data);
    const $img = $('#weather-image');
    if (parseInt(sky) > 0) {
        const index = skyWeathers.findIndex(skyWeather => skyWeather.key === parseInt(sky));
        const result = skyWeathers[index];
        console.dir(result);
        $img.attr('src', result.src);
        $img.attr('alt', result.alt);
    } else {
        const index = ptyWeathers.findIndex(ptyWeather => ptyWeather.key === parseInt(pty));
        const result = ptyWeathers[index];
        console.dir(result);
        $img.attr('src', result.src);
        $img.attr('alt', result.alt);
    }
};
// End  Weather

// 미세먼지
const requestFineDust = () => {
    return new Promise((resolve, reject) => {
        $.getJSON("/finedust/finedust.json")
            .done(res => resolve(res))
            .fail(err => reject(err));
    });
};

const renderFineDust = (data) => {
    const { items } = data;
    console.dir(items);
    const { pm10Value, pm10Grade } = items[2];
    console.dir(items[2]);
    $('#fine-dust').find('#dust').text("미세먼지");
    $('#fine-dust').find('#pm10Value').text(pm10Value + "㎍/㎥");
    if (parseInt(pm10Grade) === 1) {
        $('#fine-dust').find('#status').text("좋음");
    } else if (parseInt(pm10Grade === 2)) {
        $('#fine-dust').find('#status').text("보통");
    } else if (parseInt(pm10Grade) === 3) {
        $('#fine-dust').find('#status').text("나쁨");
    } else if (parseInt(pm10Grade) === 4) {
        $('#fine-dust').find('#status').text("매우나쁨");
    }
};
//

