<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <script src="http://code.jquery.com/jquery-latest.js"></script>

    <script>
        $(document).ready(function () {
            $("#submitBtn").click(function () {
                $.ajax({
                    url: "http://localhost/mission",
                    method: "post",
                    contentType: "application/json",
                    data: JSON.stringify({
                        mission_name: $("#mission_name").val(),
                        start_date: $("#start_date").val(),
                        end_date: $("#end_date").val(),
                        level_code: $("#level_code").val(),
                        point: $("#point").val(),
                        remark: $("#remark").val(),
                        zip_code : $("#zip_code").val(),
                        address1: $("#address1").val(),
                        address2: $("#address2").val(),
                        use_yn: "Y",
                        create_member: "changevalue",
                        update_member: "changevalue",
                    }),
                    success: function (success) {
                        $.ajax({
                            url: "http://localhost/image/test",
                            type: "POST",
                            data: new FormData($("#upload-file-form")[0]),
                            enctype: 'multipart/form-data',
                            processData: false,
                            contentType: false,
                            cache: false,
                            success: function () {
                           
                            },
                            error: function () {
                         
                            }
                        });

                    },
                    error: function (error) {
                        console.log(error);
                    },
                });

            });
        });
    </script>
    <title>Document</title>
</head>
<body>
    <table border="1">
        <tr>
            <th>mission_name</th>
            <td><input type="text" id="mission_name" name="mission_name"/></td>
        </tr>
        <tr>
            <th>시작일</th>
            <td><input type="date" name="start_date" id="start_date"></td>
        </tr>
        <tr>
            <th>종료일</th>
            <td><input type="date" name="end_date" id="end_date"></td>
        </tr>
        <tr>
            <th>level_code</th>
            <td>
                <select name="level_code" id="level_code">
                    <option value="">선택하세요</option>
                    <option value="상">상</option>
                    <option value="중">중</option>
                    <option value="하">하</option>
                </select>
            </td>
        </tr>
        <tr>
            <th>point</th>
            <td><input type="text" name="point" id="point"/></td>
        </tr>
        <tr>
        <tr>
            <th>우편번호</th>
            <td>
                <input type="text" size="5" maxlength="5" name="zip_code" id="zip_code"/>
                <!-- <input
                  type="button"
                  value="우편검색"
                  onclick="openDaumPostcode()"
                /> -->
            </td>
        </tr>
        <tr>
            <th>주소</th>
            <td><input type="text" size="50" name="address1" id="address1"/> <br><input type="text" size="50" name="address2" id="address2"/> </td>
        </tr>
        </tr>
        <tr>
            <th>사진</th>
            <td>
                <form id="upload-file-form" enctype="multipart/form-data"><input type="file" multiple="multiple" name="uploadfiles"
                                                                      id="uploadfiles"></form>
            </td>
        </tr>
        <tr>
            <th>설명</th>
            <td><textarea name="remark" id="remark" cols="30" rows="10"></textarea></td>
        </tr>
        <tr>
            <td colspan="2" align="center"><input type="button" id="submitBtn" value="전송"/></td>
        </tr>
        <!-- <script>
          var mapContainer = document.getElementById('map'), // 지도를 표시할 div
              mapOption = {
                  center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
                  level: 3 // 지도의 확대 레벨
              };

          // 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
          var map = new kakao.maps.Map(mapContainer, mapOption);
          </script> --></table>
</body>
</html>
