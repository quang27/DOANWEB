<!-- #include file="connect.asp" -->
<%
    function Ceil(Number)
        Ceil = Int(Number)
        if Ceil<>Number Then
            Ceil = Ceil + 1
        end if
    end function
    function checkPage(cond, ret) 
        if cond=true then
            Response.write ret
        else
            Response.write ""
        end if
    end function
    page = Request.QueryString("page")
    limit = 4
    if (trim(page) = "") or (isnull(page)) then
        page = 1
    end if
    offset = (Clng(page) * Clng(limit)) - Clng(limit)
    strSQL = "SELECT COUNT(ma_sp) AS count FROM SANPHAM"
    connDB.Open()
    Set CountResult = connDB.execute(strSQL)

    totalRows = CLng(CountResult("count"))

    Set CountResult = Nothing
    pages = Ceil(totalRows/limit)
    Dim range
    If (pages<=5) Then
        range = pages
    Else
        range = 5
    End if
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.bunny.net/css?family=figtree:500,600&display=swap" rel="stylesheet" />
    <link rel="stylesheet" href="style/index.css">
  <title>Index</title>
  <style>
    .search-btn i{
      background:#00B894;
    }
  </style>
</head>
<body>
  <header >
  <nav class="navbar navbar-expand-lg bg-body-tertiary" style="background-color: #0082e6 !important;">
    <div class="container-fluid">
      <div class="collapse navbar-collapse" id="navbarText" style="padding-left: 30px;">
        <form class="search-box" action="" method="">
          <input type="text" name="keyword" value="" placeholder="Search by Name or Brand">
          <button class="search-btn" type="submit" name="button">
           <i class="fas fa-search"></i>
          </button>
        </form>
        <ul class="navbar-nav me-auto mb-2 mb-lg-0" style="position: fixed; right: 10px; z-index: 3;" >
          <li class="nav-item">
            <a class="nav-link" target="_self" href="#slider">Home</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" target="_self" href="#product">Product</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="shoppingcart.asp">My Cart</a>
          </li>
          <li style="padding-top: 7px;">
              <% If ((NOT isnull(Session("ten_kh"))) AND (TRIM(Session("ten_kh"))<>"")) Then
                  Session.Contents.Remove("ten_ql")%>
                  <span class="nav-link badge text-bg-success" style="font-size: 20px;">
                    Welcome <%=Session("ten_kh")%>!
                  </span>
                  <li><a href="logout.asp" class="nav-link"><style class="fa fa-sign-out"></style></a></li>
              <% ElseIf ((NOT isnull(Session("ten_ql"))) AND (TRIM(Session("ten_ql"))<>"")) Then
                  Session.Contents.Remove("ten_kh")%>
                  <span class="nav-link badge text-bg-success" style="font-size: 20px;">
                    Welcome <%=Session("ten_ql")%>!
                  </span>
                  <li><a href="logout.asp" class="nav-link"><style class="fa fa-sign-out"></style></a></li>
              <% Else %>
                <li><a href="login.asp" class="nav-link"><i class="fa-solid fa-user"></i></a></li>
              <% End if %> 
          </li>
        </ul>
      </div>
    </div>
  </nav>
  </header>
  <div class="container-main">
    <h1 class="title" id="slider">News</h1>

    <div class="slidermain" >
      <div class="img-slider">
        <div class="slide active">
          <img src="slidepic/watch1.jpg" alt="">
          <div class="info">
            <h2>Rolex</h2>
            <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
          </div>
        </div>
        <div class="slide">
          <img src="slidepic/watch2.jpg" alt="">
          <div class="info">
            <h2>Omega</h2>
            <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
          </div>
        </div>
        <div class="slide">
          <img src="slidepic/watch3.jpg" alt="">
          <div class="info">
            <h2>Patek Philipe</h2>
            <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
          </div>
        </div>
        <div class="slide">
          <img src="slidepic/watch4.jpg" alt="">
          <div class="info">
            <h2>Our Collection</h2>
            <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
          </div>
        </div>
        <div class="slide">
          <img src="slidepic/watch5.jpg" alt="">
          <div class="info">
            <h2>Citizen</h2>
            <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
          </div>
        </div>
        <div class="navigation">
          <div class="btn active"></div>
          <div class="btn"></div>
          <div class="btn"></div>
          <div class="btn"></div>
          <div class="btn"></div>
        </div>
      </div>
    </div>

    <h1 class="title">Products</h1>
    <div class="container">
    <div class="row">
    <% 
		Dim searchKeyword, strSQL
    strSQL = "SELECT * FROM SANPHAM ORDER BY ma_sp OFFSET ? ROWS FETCH NEXT ? ROWS ONLY"
				' tim kiem
		searchKeyword = Request.QueryString("keyword")
		Set cmdPrep = Server.CreateObject("ADODB.Command")
		cmdPrep.ActiveConnection = connDB
		cmdPrep.CommandType = 1
		cmdPrep.Prepared = True                                            
		if Not isnull(searchKeyword) and searchKeyword <>"" then
			strSQL = "SELECT * FROM SANPHAM WHERE ten_sp LIKE '%" & searchKeyword & "%' OR loai LIKE '%" & searchKeyword & "%' ORDER BY ma_sp OFFSET ? ROWS FETCH NEXT ? ROWS ONLY"
		End If
		cmdPrep.CommandText = strSQL
		cmdPrep.parameters.Append cmdPrep.createParameter("offset", 3, 1, , offset)
		cmdPrep.parameters.Append cmdPrep.createParameter("limit", 3, 1, , limit)
										
		Set Result = cmdPrep.execute
		Do While Not Result.EOF
		%>
    <div class="col-sm-3">
        <div class="product" id="product">
          <div class="product-card">
            <h2 class="name"><%=Result("ten_sp")%></h2>
            <span class="price">$<%=Result("gia_ban")%></span>
            <a class="popup-btn">Quick View</a>
            <img src="<%=Result("hinh_anh_sp")%>" class="product-img" alt="">
          </div>
          <div class="popup-view">
            <div class="popup-card">
              <a style="cursor:pointer;" ><i class="fas fa-times" id="close-btn"></i></a>
              <div class="product-img">
                <img src="<%=Result("hinh_anh_sp")%>" alt="">
              </div>
              <div class="info">
                <h2><%=Result("ten_sp")%><br>
                  <span><%=Result("loai")%></span><br>
                  <span>Color: <%=Result("mau_sp")%></span>
                </h2>
                <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
                <span class="price">$<%=Result("gia_ban")%></span>
                <a href="addCart.asp?ma_sp=<%=Result("ma_sp")%>" class="add-cart-btn">Add to Cart</a>
              </div>
            </div>
          </div>
        </div>
    </div>
    <%
			Result.MoveNext
			Loop
		%>
  </div>
  </div>

  <div class="pagination">
    <% if (pages>1) then 
        for i= 1 to pages
    %>
    <a class="btn <%=checkPage(Clng(i)=Clng(page),"active")%>" href="index.asp?page=<%=i%>#product"><%=i%></a>
    <%
        next
        end if
    %>
  </div>

  <footer>
    <div class="row">
      <div class="col-md-4">
        <form class="contactform">
          <h2>Send Message</h2>
          <div class="inputbox">
            <input type="text" required="required">
            <span>Email:</span>
          </div>
          <div class="inputbox">
            <textarea name="" id="" cols="30" rows="10" required="required"></textarea>
            <span>Type your message:</span>
          </div>
          <div class="inputbox">
            <input type="submit" value="Send">
          </div>
        </form>
      </div>
      <div class="col-md-4">
        <div class="social">
          <h2>Contact Us</h2>
          <a href="https://www.facebook.com/bach.luong.1044186" target="_blank"><i class="fa-brands fa-facebook"></i></a>
         <a href="#"><i class="fa-brands fa-twitter"></i></a>
         <a href=""><i class="fa-brands fa-instagram"></i></a>
        </div>
      </div>
      <div class="col-md-4">
        <h2 style="color: white;">Our location</h2>
        <div class="map">
          <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3724.7334696246703!2d105.84074577375598!3d21.00331848865479!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3135ac773026b415%3A0x499b8b613889f78a!2zVHLGsOG7nW5nIMSQ4bqhaSBI4buNYyBYw6J5IEThu7FuZyBIw6AgTuG7mWkgLSBIVUNF!5e0!3m2!1svi!2s!4v1687256612223!5m2!1svi!2s" width="600" height="450" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
        </div>
      </div>
      </div>
    </div>
  </footer>
  

    <script src="style/index.js"></script>
    <script type="text/javascript">
      var popupViews = document.querySelectorAll(".popup-view");
      var popupBtns = document.querySelectorAll('.popup-btn');
      var closeBtns = document.querySelectorAll("#close-btn");
  
      //javascript for quick view button
      var popup = function(popupClick){
        popupViews[popupClick].classList.add('active');
      }
      popupBtns.forEach((popupBtn, i) => {
        popupBtn.addEventListener("click", () => {
          popup(i);
        });
      });
      //javascript for close button
      closeBtns.forEach((closeBtn) => {
        closeBtn.addEventListener("click", () => {
          popupViews.forEach((popupView) => {
            popupView.classList.remove('active');
          });
        });
      });
      </script>
</body>
</html>