<!-- #include file="connect.asp" -->
<%
    If (Request.ServerVariables("REQUEST_METHOD") = "post") THEN        
        ma_kh = Request.QueryString("ma_kh")
        If (isnull(ma_kh) OR trim(ma_kh) = "") then 
            ma_kh=0 
        End if
        If (cint(ma_kh)<>0) Then
            Set cmdPrep = Server.CreateObject("ADODB.Command")
            connDB.Open()
            cmdPrep.ActiveConnection = connDB
            cmdPrep.CommandType = 1
            cmdPrep.CommandText = "SELECT * FROM KHACHHANG WHERE ma_kh=?"
            
            cmdPrep.Parameters(0)=ma_kh
            Set Result = cmdPrep.execute 

            If not Result.EOF then
                ten_kh = Result("ten_kh")
                tuoi_kh = Result("tuoi_kh")
                gioi_tinh = Result("gioi_tinh")
                sdt_kh = Result("sdt_kh")
                password_kh = Result("password_kh")
                email_kh = Result("email_kh")
                diachi_kh= Result("diachi_kh")
            End If

   
            Result.Close()
        End If
    Else
        ma_kh = Request.QueryString("ma_kh")
        ten_kh = Request.form("ten_kh")
        tuoi_kh = Request.form("tuoi_kh")
        gioi_tinh = Request.form("gioi_tinh")
        sdt_kh = Request.form("sdt_kh")
        password_kh = Request.form("password_kh")
        email_kh = Request.form("email_kh")
        diachi_kh= Request.form("diachi_kh")

        if (isnull (ma_kh) OR trim(ma_kh) = "") then ma_kh=0 end if

        if (cint(ma_kh)=0) then
            if (NOT isnull(ten_kh) and ten_kh <>"" and NOT isnull(tuoi_kh) and tuoi_kh <>"" and NOT isnull(gioi_tinh) and gioi_tinh <>"" and NOT isnull(sdt_kh) and sdt_kh <>"" and NOT isnull(password_kh) and password_kh <>"" and NOT isnull(email_kh) and email_kh <>"" and NOT isnull(diachi_kh) and diachi_kh <>"" ) then
                Set cmdPrep = Server.CreateObject("ADODB.Command")
                connDB.Open()                
                cmdPrep.ActiveConnection = connDB
                cmdPrep.CommandType = 1
                cmdPrep.Prepared = True
                cmdPrep.CommandText = "INSERT INTO KHACHHANG(ten_kh,tuoi_kh,gioi_tinh,sdt_kh,password_kh,email_kh,diachi_kh) VALUES(?,?,?,?,?,?,?)"
                cmdPrep.parameters.Append cmdPrep.createParameter("ten_kh",202,1,255,ten_kh)
                cmdPrep.parameters.Append cmdPrep.createParameter("tuoi_kh",202,1,255,tuoi_kh)
                cmdPrep.parameters.Append cmdPrep.createParameter("gioi_tinh",202,1,255,gioi_tinh)
                cmdPrep.parameters.Append cmdPrep.createParameter("sdt_kh",202,1,255,sdt_kh)
                cmdPrep.parameters.Append cmdPrep.createParameter("password_kh",202,1,255,password_kh)
                cmdPrep.parameters.Append cmdPrep.createParameter("email_kh",202,1,255,email_kh)
                cmdPrep.parameters.Append cmdPrep.createParameter("diachi_kh",202,1,255,diachi_kh)

                cmdPrep.execute               
                
                If Err.Number = 0 Then 
                
                    Session("Success") = "Đăng ký thành công"                    
                    Response.redirect("login.asp")  
                Else  
                    handleError(Err.Description)
                End If
                On Error GoTo 0
            else
                Session("Error") = "Đăng ký thất bại"                
            end if
        end if
    End If    
%>
<%
Dim email_kh, password
email_kh = Request.Form("email_kh")
password = Request.Form("password_kh")
If (NOT isnull(email_kh) AND NOT isnull(password_kh) AND TRIM(email_kh)<>"" AND TRIM(password_kh)<>"" ) Then
    ' true
    Dim sql
    sql = "select * from KHACHHANG where email_kh= ? and password_kh= ?"
    Dim cmdPrep
    set cmdPrep = Server.CreateObject("ADODB.Command")
    connDB.Open()
    cmdPrep.ActiveConnection = connDB
    cmdPrep.CommandType=1
    cmdPrep.Prepared=true
    cmdPrep.CommandText = sql
    cmdPrep.Parameters(0)=email_kh
    cmdPrep.Parameters(1)=password_kh
    Dim result
    set result = cmdPrep.execute()
    'kiem tra ket qua result o day
    If not result.EOF Then
        ' dang nhap thanh cong
        Session("ma_kh")=Result("ma_kh")
        Session("ten_kh")=Result("ten_kh")
        Session("email_kh")=Result("email_kh")
        Session("Success")="Login Successfully"
        Response.redirect("index.asp")
    Else
        ' dang nhap ko thanh cong
        Session("Error") = "Wrong email or password"
    End if
    result.Close()
    connDB.Close()
Else
    ' false
    Session("Error")="Please input email and password."
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
    <link rel="stylesheet" href="style/login.css">
    <title>Login</title>
</head>
<body>
      <div class="container">
         <header>Login Customer</header>
         <form method="post" action="login.asp">
            <div class="input-field">
               <input type="text" required name="email_kh">
               <label>Email or Username</label>
            </div>
            <div class="input-field">
               <input class="pswrd" type="password" required name="password_kh">
               <span class="show"><i class="fa-solid fa-eye"></i></span>
               <label>Password</label>
            </div>
            <div class="button">
               <div class="inner"></div>
               <button type="submit" name="submit">LOGIN</button>
            </div>
         </form>
         <div class="signup" type="button" data-bs-toggle="modal" data-bs-target="#myModal">
            Not a member? <a href="#">Sign up now</a><br>
            Are you an admin <a href="admin/loginadmin.asp">Login</a>
         </div>
      </div>

      <div class="modal" id="myModal">
        <div class="modal-dialog">
          <div class="modal-content">
      
            <!-- Modal Header -->
            <div class="modal-header">
              <h4 class="modal-title">Sign Up</h4>
              <button type="button" class="btn-close" data-bs-dismiss="modal" style="color: white"></button>
            </div>
      
            <!-- Modal body -->
            <div class="modal-body">
              
                <form method="post">
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="">Name</label><br/>
                            <input type="text" name="ten_kh" class="form-control" placeholder="Enter name" required/>
                        </div>
                        <div class="form-group">
                            <label for="">Age</label><br/>
                            <input type="number" name="tuoi_kh" class="form-control" placeholder="Enter Age" required/>
                        </div>
                        <div class="form-group">
                            <label for="">Phone</label><br/>
                            <input type="number" name="sdt_kh" class="form-control" placeholder="Enter Phone" required/>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="">Gender</label><br/>
                            <select class="form-select" name="gioi_tinh" class="form-control">
                                <option>Choose</option>
                                <option>Male</option>
                                <option>Female</option>
                              </select>
                        </div>
                        <div class="form-group">
                            <label for="">Email</label><br/>
                            <input type="email" name="email_kh" class="form-control" placeholder="Enter Email" required>
                        </div>
                        <div class="form-group">
                            <label for="">Password</label><br/>
                            <input type="text" name="password_kh" class="form-control" placeholder="Enter Password" required>
                        </div>
                    </div>
                    <div class="col col-md-12">
                        <label for="">Address</label><br/>
                        <input type="text" name="diachi_kh" placeholder="Enter Address" required class="form-control">
                    </div>
                    <button type="submit" class="col-md-3 btn btn-primary" style="margin: 10px auto;">Sign up</button>
                </div>
                </form>
      
            <!-- Modal footer -->
            <div class="modal-footer">
              <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
            </div>
      
          </div>
        </div>
      </div>

    <script>
         var input = document.querySelector('.pswrd');
         var show = document.querySelector('.show');
         show.addEventListener('click', active);
         function active(){
           if(input.type === "password"){
             input.type = "text";
             show.style.color = "#1DA1F2";
             show.textContent = "HIDE";
           }else{
             input.type = "password";
             show.textContent = "SHOW";
             show.style.color = "#111";
           }
         }
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>