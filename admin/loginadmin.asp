<!-- #include file="../connect.asp" -->
<%
Dim email_ql, password_ql
email_ql = Request.Form("email_ql")
password_ql = Request.Form("password_ql")
If (NOT isnull(email_ql) AND NOT isnull(password_ql) AND TRIM(email_ql)<>"" AND TRIM(password_ql)<>"" ) Then
    ' true
    Dim sql
    sql = "select * from QUANLY where email_ql= ? and password_ql= ?"
    Dim cmdPrep
    set cmdPrep = Server.CreateObject("ADODB.Command")
    connDB.Open()
    cmdPrep.ActiveConnection = connDB
    cmdPrep.CommandType=1
    cmdPrep.Prepared=true
    cmdPrep.CommandText = sql
    cmdPrep.Parameters(0)=email_ql
    cmdPrep.Parameters(1)=password_ql
    Dim result
    set result = cmdPrep.execute()
    'kiem tra ket qua result o day
    If not result.EOF Then
        ' dang nhap thanh cong
        Session("email_ql")=result("email_ql")
        Session("ten_ql")=result("ten_ql")
        Session("Success")="Login Successfully"
        Response.redirect("product.asp")
    Else
        ' dang nhap ko thanh cong
        Session("Error") = "Wrong email or password_ql"
    End if
    result.Close()
    connDB.Close()
Else
    ' false
    Session("Error")="Please input email and password_ql."
End if
%>

<!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta charset="utf-8">
    <title>Responsive Login Page</title>
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.14.0/css/all.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js" charset="utf-8"></script>
    <link rel="preconnect" href="https://fonts.bunny.net">
    <link href="https://fonts.bunny.net/css?family=figtree:400,600&display=swap" rel="stylesheet" />
    <link rel="stylesheet" href="../style/loginadmin.css">
  </head>
  <body>

    <!--form area start-->
    <div class="form">
      <!--login form start-->
      <form class="login-form" action="" method="post">
        <i class="fas fa-user-circle"></i>
        <input class="user-input" type="text" name="email_ql" id="email_ql" placeholder="Username" required>
        <input class="user-input" type="password" name="password_ql" id="password_ql" placeholder="Password" required>
        <!-- <div class="options-01">
          <label class="remember-me"><input type="checkbox" name="">Remember me</label>
          <a href="#">Forgot your password?</a>
        </div> -->
        <input class="btn" type="submit" name="" value="LOGIN">
      </form>
      <!--login form end-->
    </div>
    <!--form area end-->

  </body>
</html>