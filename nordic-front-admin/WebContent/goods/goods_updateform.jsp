<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset='utf-8'>
    <title>(관리자) 굿즈 수정</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <script src="http://code.jquery.com/jquery-latest.js"></script>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://getbootstrap.com/docs/5.2/assets/css/docs.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="http://code.jquery.com/jquery-latest.js"></script>
    <script>

    $(document).ready(function () {
    	let token = localStorage.getItem('wtw-token') || '';
        const goodsNo = window.localStorage.getItem("goods_no");
        console.log(goodsNo);
        window.localStorage.removeItem("goods_no");
        $.ajax({
            url: "http://localhost/api/goods/" + goodsNo,
            method: "get",
            contentType : "application/json",
            headers: {
		        'Authorization': `Bearer \${token}`,
		  	},
            data: { },
            success: function (success) {
              console.log(success);
              console.log(success.data);
              var dt = success.data;

              $("#goods_name").attr("value",dt.goods_name);
              $("#point").attr("value",dt.point);
              $("#goods_desc").attr("value",dt.goods_desc);
              $("#remark").attr("value",dt.remark);
              
              getImages(dt);
            },
            error: function (error) {
              console.log(error);
            },
        
        });


        $("#goodsInsert").click(function () {
            //FormData 새로운 객체 생성 
            var formData = new FormData();
            // 넘길 데이터를 담아준다. 
            var data = {   
            "goods_name"    : $("#goods_name").val(),
            "point"     : $("#point").val(),
            "goods_desc"  :  $("#goods_desc").val(),
            "remark"  :  $("#remark").val(),
            }
            console.log(data);
            
            // input class 값 
            var fileInput = $('.files');
            var fileOrderList = new Array();
// fileInput 개수를 구한다.
for (var i = 0; i < fileInput.length; i++) {

			console.log(" fileInput[i].files[j] :::"+ fileInput[i].files[0]);
			if(fileInput[i].files[0] == undefined){
  
      } else{
			// formData에 'file'이라는 키값으로 fileInput 값을 append 시킨다.  
			formData.append('file', $('.files')[i].files[0]);
      fileOrderList.push(i);
      }

}
console.log(fileOrderList);
console.log(JSON.stringify(fileOrderList));
formData.append('fileOrder', new Blob([JSON.stringify(fileOrderList)], {type: "application/json"}));

            //var fileInput = $("#file1")[0].files[0];
            //formData.append("file1",fileInput);
            formData.append('key', new Blob([JSON.stringify(data)] , {type: "application/json"}));

          $.ajax({
            url: "http://localhost/api/goods/" + goodsNo,
            method: "put",
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
              location.href="goods_cont_admin.jsp?" + goodsNo;
            },
            error: function (error) {
              console.log(error);
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

      function getImages(dt){
              var img1 = document.getElementById("preview1");
              var img2 = document.getElementById("preview2");
              var img3 = document.getElementById("preview3");
              var img4 = document.getElementById("preview4");
              var img5 = document.getElementById("preview5");

              if(dt.image1 != null){
              img1.setAttribute("src","http://localhost/api/goods/image/" + dt.image1);
              img1.setAttribute("onError","this.src='noimage.png'");
              }
              else
              img1.setAttribute("SRC","noimage.png");
              if(dt.image2 != null){
              img2.setAttribute("src","http://localhost/api/goods/image/" + dt.image2);
              img2.setAttribute("onError","this.src='noimage.png'");
              }
              else
              img2.setAttribute("SRC","noimage.png");
              if(dt.image3 != null){
              img3.setAttribute("src","http://localhost/api/goods/image/" + dt.image3);
              img3.setAttribute("onError","this.src='noimage.png'");
              }
              else
              img3.setAttribute("SRC","noimage.png");
              if(dt.image4 != null){
              img4.setAttribute("src","http://localhost/api/goods/image/" + dt.image4);
              img4.setAttribute("onError","this.src='noimage.png'");
              }
              else
              img4.setAttribute("SRC","noimage.png");
              if(dt.image5 != null){
              img5.setAttribute("src","http://localhost/api/goods/image/" + dt.image5);
              img5.setAttribute("onError","this.src='noimage.png'");
              }
              else
              img5.setAttribute("SRC","noimage.png");
          }

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
  <body style="width:100%">
  <jsp:include page="../header.jsp"/>
  	<div class="container mt-5 mb-5">
		<div class="row">
			<jsp:include page="../sidebar.jsp"/>
			<div class="col-sm-10 ps-5">
				<h1>포인트 상품 수정</h1>	
				<br>
  <table style="text-align:center; width: 100%"
								class="mt-3 table table-hover">
    <tbody>
      <tr>
        <th>굿즈명</th>
        <td colspan="2"><input type="text" name="goods_name" id="goods_name" placeholder="포인트 상품명" style="width:100%"></td>
      </tr>
      <tr>
        <th>포인트</th>
        <td colspan="2"><input type="text" name="point" id="point" placeholder="포인트" style="width:100%"></td>
      </tr>
      <tr>
        <th>상세설명</th>
        <td colspan="2"><input type="text" name="goods_desc" id="goods_desc" placeholder="상세설명" style="width:100%"></td>
      </tr>
      <tr>
        <th>리마크</th>
        <td colspan="2"><input type="text" name="remark" id="remark" placeholder="기타" style="width:100%"></td>
      </tr> 
      <tr>
        <th>파일1</th>
        <td><input type="file" name="file1" class="files" id="file1" onchange="readURL(this,1);" style="width:100%"></td>
        <td><img id="preview1" width="100" height="100"></td>
      </tr>
      <tr>
        <th>파일2</th>
        <td><input type="file" name="file2" class="files" id="file2" onchange="readURL(this,2);" style="width:100%"></td>
        <td><img id="preview2" width="100" height="100"></td>
      </tr>
      <tr>
        <th>파일3</th>
        <td><input type="file" name="file3" class="files" id="file3" onchange="readURL(this,3);" style="width:100%"></td>
        <td><img id="preview3" width="100" height="100"></td>
      </tr>
      <tr>
        <th>파일4</th>
        <td><input type="file" name="file4" class="files" id="file4" onchange="readURL(this,4);" style="width:100%"></td>
        <td><img id="preview4" width="100" height="100"></td>
      </tr>
      <tr>
        <th>파일5</th>
        <td><input type="file" name="file5" class="files" id="file5" onchange="readURL(this,5);" style="width:100%"></td>
        <td><img id="preview5" width="100" height="100"></td>
      </tr>
      <button type="button" id="goodsInsert" class="btn btn-dark">확인</button>
    </tbody>
</table>
</div></div></div>
<jsp:include page="../footer.jsp"/>
</body>
</html>