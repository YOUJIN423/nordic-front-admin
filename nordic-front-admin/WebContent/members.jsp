<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset='utf-8'>
    <meta http-equiv='X-UA-Compatible' content='IE=edge'>
    <title>전체 회원 정보</title>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <link rel='stylesheet' type='text/css' media='screen' href='main.css'>
</head>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script>

    function doModify(member_code){
        if(confirm(member_code+" 수정 폼으로 이동합니다")) {
            // location.href="http://localhost:80/api/member/modifyForm/"+member_code;
            location.href="http://localhost:80/api/member/modifyForm/"+member_code;
        }
    }  

    function doDelete(member_code) {
        if(confirm(member_code+" 강제탈퇴 폼으로 이동합니다")) {
            location.href="http://172.30.1.68:5500/member/modifyForm/"+member_code;
        }
    }


    /********************* 모든회원정보 불러오기 *********************/
    /********************* 문서 로드 되자마자 실행 *********************/
    function findAll(pageNum) {

    if ($("#aC").is(":checked")) {  // 관리자 체크박스가 checked 상태일 때

        alert("관리자 회원의 정보를 불러옵니다.");
        var url = "http://localhost:80/api/member/admins/"+pageNum;

    } else {

        if 
            (true) {
            // (confirm("모든 회원의 정보를 불러오시겠습니까?")) {
            // alert("모든 회원의 정보를 불러옵니다.");
            var url = "http://localhost:80/api/member/members/"+pageNum;
        } else {
            $("#members").empty();
            $("#pageArea").empty();
            return false;
        }

    }   // if end

        fetch(url, {
            method: "GET",
            mode: 'cors',
            headers: {
            'Content-Type' : 'application/json',
            }
        })
        
        .then(response => response.json())
        .then(response => {

            $("#members").empty();
            $("#pageArea").empty();

            var tableColumnL = (response.data.list.length); // 행 길이
            
            for (var j=0; j<tableColumnL; j++){

                var memValues = Object.values(response.data.list[j]);
                    
                $("#members").append(`<tr>`);
                $("#members").append(`<td>${j+1}</td>`);

                var i=0;
                while (i < memValues.length) {

                    var data = `
                    <td>${memValues[i]}</td>
                    `
                    i++
                    $("#members").append(data);
                }   // while end (td 추가 끝)
                    
                var member_code = memValues[0];
                var data = `<td><button onClick="doModify(${member_code})">수정${j+1}</button></td>
                <td><button onClick="doDelete(${member_code})">삭제${j+1}</button></td></tr>`
                $("#members").append(data);
            }   //for end

            console.log(response.data); // 정보 보기

            var pageNum = response.data.pageNum     // 1, 현재 페이지
            var pageCount = response.data.pages     // 144, 가장 마지막 페이지
            var memberCount = response.data.total;  // 전체 회원 수

            var prePage = (Math.floor((pageNum - 1)/10)*10+1) ;       // 시작 페이지
            var nextPage = prePage + 10 - 1;       // 끝 페이지
            
            
            // 블록 변수
            var pageSize = response.data.pageSize; // 10, 1블록당 페이지 수
            var startRow = response.data.startRow;  // 1, 11, 21, 31, 41 ...
            var endRow = response.data.endRow;  // 10, 20, 30, 40, 50 ...
            if (nextPage > pageCount) nextPage = pageCount;
            
            // 가장 처음 페이지
            var paging1 = 
            `<a onClick="javascript:findAll(1)">[처음]   </a>`;
            $("#pageArea").append(paging1);

            // 이전 블록 이동
            if ( prePage > 10) {
                var paging2 =
                // `<a href="javascript:findAll(${prePage-10})"> << </a>`;
                `<a onClick="javascript:findAll(${prePage-10})"> <<  </a>`;
                $("#pageArea").append(paging2);
            } 

            // 페이지 이동 (숫자)
            for (i=prePage; i<=nextPage; i++) { 
                var paging3 = 
                // `<a href="javascript:findAll(${i})">${i}  </a>`
                `<a onClick="javascript:findAll(${i})">${i}  </a>`;
                $("#pageArea").append(paging3);
            }

            // 다음 블록 이동
            if ( nextPage < pageCount) {
                var paging4 =
                // `<a href="javascript:findAll(${prePage+10})"> >> </a>`;
                `<a onClick="javascript:findAll(${prePage+10})"> >> </a>`;
                $("#pageArea").append(paging4);
            }

            // 가장 마지막 페이지
            var paging5 = 
            // `<a href="javascript:findAll(${pageCount})">[끝]</a>`;
            `<a onClick="javascript:findAll(${pageCount})">   [끝]</a>`;
            $("#pageArea").append(paging5);
            
        })

        .catch(error => {
            console.log(error);
            alert(error);
        });
    } // findAll end

</script>
<style>
    #pageArea{
        text-align: center;
    }
</style>
<body>
<script>
    findAll(1);
</script>
<span id="adminCheck">
    <input type="checkbox" id="aC" onClick="findAll(1)"> 
    <label for="aC"> 관리자 여부 </label>
</span>
<br><br><br>
<div id="allMemList">
    <table border="1">
        <thead>
            <tr>
                <th></th>
                <th>회원코드</th>
                <th>이름</th>
                <th>핸드폰</th>
                <th>주소</th>
                <th>나이</th>
                <th>성별</th>
                <th>동의여부</th>
                <th>비밀번호</th>
                <th>가입승인여부</th>
                <th>가입승인일시</th>
                <th>활동중지여부</th>
                <th>활동중지일시</th>
                <th>관리자여부</th>
                <th>관리자등록일</th>
                <th>누적포인트</th>
                <th>가용포인트</th>
                <th>사용포인트</th>
                <th>비고</th>
                <th>등록자</th>
                <th>등록일시</th>
                <th>변경자</th>
                <th>변경일시</th>
                <th></th><th></th>
            </tr>
        </thead>
        <tbody id="members" name="members"></tbody>
    </table>
    <br><br>
    <div id="pageArea"></div>
    <br><br><br>
</div>
</body>
</html>