<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset='utf-8'>
    <title>(관리자) 굿즈 생성</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <script src="http://code.jquery.com/jquery-latest.js"></script>
    <script>

    $(document).ready(function () {
        $("#goodsInsert").click(function () {
        	let token = localStorage.getItem('wtw-token') || '';
            //FormData 새로운 객체 생성 
            var formData = new FormData();
            // 넘길 데이터를 담아준다. 
            var data = {   
            "goods_name"    : $("#goods_name").val(),
            "point"     : Number($("#point").val()),
            "goods_desc"  :  $("#goods_desc").val(),
            "remark"  :  $("#remark").val(),
            }
            console.log(data);
            console.log("타입 "+ typeof($("#point").val()))

            // input class 값 
            var fileInput = $('.files');
            var fileOrderList = new Array();
// fileInput 개수를 구한다.
for (var i = 0; i < fileInput.length; i++) {

			console.log(" fileInput[i].files[j] :::"+ fileInput[i].files[0]);
			//if(fileInput[i].files[0] == undefined){
  
      //} else{
			// formData에 'file'이라는 키값으로 fileInput 값을 append 시킨다.  
			formData.append('file', $('.files')[i].files[0]);
      //fileOrderList.push(i);
      //}

}
//console.log(fileOrderList);
//console.log(JSON.stringify(fileOrderList));
//formData.append('fileOrder', new Blob([JSON.stringify(fileOrderList)], {type: "application/json"}));
            //var fileInput = $("#file1")[0].files[0];
            //formData.append("file1",fileInput);
            formData.append('key', new Blob([JSON.stringify(data)] , {type: "application/json"}));


          $.ajax({
            url: "http://localhost/api/goods",
            method: "post",
            processData: false,
            contentType:false,
            enctype : 'multipart/form-data',
            headers: {
		        'Authorization': `Bearer \${token}`,
		  	},
            data: formData,
            success: function (success) {
              console.log(success);
              alert(success.message);
              location.href="goods_all.jsp";
            },
            error: function (error) {
              console.log(error.responseJSON.message);

              if(error.responseJSON.message.substring(0,4) == '0006'){
                alert("사진 파일만 입력 가능합니다");
              } else if(error.responseJSON.message.substring(0,4) == '0007'){
                alert("1MB 이하의 사진만 입력 가능합니다")
              } else
              alert(error.responseJSON.message);
            },
          });
        });
      });

      function readURL(input, i) {
  if (input.files && input.files[0]) {
    var reader = new FileReader();
    reader.onload = function(e) {
      document.getElementById('preview' + i).src = e.target.result;
    };
    reader.readAsDataURL(input.files[0]);
  } else {
    document.getElementById('preview' + i).src = "";
  }
}
      </script>
</head>
<body>
  <table border="1" width="1000" height="500">
    <caption>굿즈 등록</caption>
    <tbody>
      <tr>
        <th>굿즈명</th>
        <td colspan="2"><input type="text" name="goods_name" id="goods_name" placeholder="굿즈명"></td>
      </tr>
      <tr>
        <th>포인트</th>
        <td colspan="2"><input type="text" name="point" id="point" placeholder="포인트"></td>
      </tr>
      <tr>
        <th>상세설명</th>
        <td colspan="2"><input type="text" name="goods_desc" id="goods_desc" placeholder="상세설명"></td>
      </tr>
      <tr>
        <th>리마크</th>
        <td colspan="2"><input type="text" name="remark" id="remark" placeholder="리마크"></td>
      </tr> 
      <tr>
        <th>파일1</th>
        <td><input type="file" name="file1" class="files" id="file1" onchange="readURL(this,1);"></td>
        <td><img id="preview1" width="50" height="50"></td>
      </tr>
      <tr>
        <th>파일2</th>
        <td><input type="file" name="file2" class="files" id="file2" onchange="readURL(this,2);"></td>
        <td><img id="preview2" width="50" height="50"></td>
      </tr>
      <tr>
        <th>파일3</th>
        <td><input type="file" name="file3" class="files" id="file3" onchange="readURL(this,3);"></td>
        <td><img id="preview3" width="50" height="50"></td>
      </tr>
      <tr>
        <th>파일4</th>
        <td><input type="file" name="file4" class="files" id="file4" onchange="readURL(this,4);"></td>
        <td><img id="preview4" width="50" height="50"></td>
      </tr>
      <tr>
        <th>파일5</th>
        <td><input type="file" name="file5" class="files" id="file5" onchange="readURL(this,5);"></td>
        <td><img id="preview5" width="50" height="50"></td>
      </tr>

        <input type="button" value="확인" id="goodsInsert">
    </tbody>
</table>

</body>
</html>