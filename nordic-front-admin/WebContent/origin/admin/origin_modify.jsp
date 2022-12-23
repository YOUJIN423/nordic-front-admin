<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script defer src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script defer src="../../js/main/origin_modify.js"></script>
  <link rel="stylesheet" href="../../css/header.css">
  <link rel="stylesheet" href="../../css/footer.css">

  <style>
    .input_button{
      padding: 6px 25px;
      background-color:#FF6600;
      border-radius: 4px;
      color: white;
      cursor: pointer;
      text-decoration: none;
    }

    .selProductFile{
      width: 150px;
      height: 150px;
    }

    #input_imgs{
      display: none;
    }

  </style>

  <title>노르딕워킹</title>
</head>
<body>

<header>
  <h1>NORDIC WALKING</h1>
</header>

<div class="container-fluid mt-3">
<div class="container-fluid">
<div class="row">

    <jsp:include page="../../sidebar.jsp"/>

<div id="main-content" class="col-sm-9" style="margin-left: 100px;">
  <div id="modify-content" style="width: 900px; min-height: 1200px; display: flex;">

    <form id="files" enctype="multipart/form-data">
      <label class="form-label">제목</label>
      <input id="board_object" class="form-control" name="board_object" type="text" style="width: 600px">
      <br><br>
      <label class="form-label">내용</label>
      <textarea id="content" rows="25" cols="70" class="form-control" name="board_desc"></textarea>
      <br><br>
      <strong>댓글허용</strong><br>
      <input type="radio" id="reply_yn" name="reply_yn" value="Y"> 허용
      <input type="radio" id="reply_yn" name="reply_yn" value="N" checked="checked"> 불가
      <br><br>

      <div id="input_wrap">
        <strong><label class="form-label">이미지</label></strong><br>
        <a href="javascript:" class="input_button" onclick="fileUploadAction()">파일 업로드</a>
        <input type="file" id="input_imgs" multiple/>
      </div>
      <br>
      <div class="img-wrap">
        <img id="img"/>
      </div>
      <br><br>

      <strong>업로드된 목록</strong>
      <div id="imgList">
      </div>
      <br><br>

      <button type="button" onclick="submitAction()" class="btn btn-dark btn-sm">수정하기</button>
    </form>

  </div>

</div>
</div>
</div>
</div>

<footer align="center">
  서비스 이용약관 | 개인정보 보호정책 | 청소년 보호정책<br>
  Copyright <strong>©노르딕워킹</strong> All rights reserved.
</footer>
</body>
</html>
