<!-- #include file="../connect.asp" -->
<%
    If (Request.ServerVariables("REQUEST_METHOD") = "GET") THEN        
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
                email_kh = Result("email_kh")
                password_kh = Result("password_kh")
                diachi_kh = Result("diachi_kh")   
            End If

   
            Result.Close()
        End If
    Else
        ma_kh = Request.QueryString("ma_kh")
        ten_kh = Request.form("ten_kh")
        tuoi_kh = Request.form("tuoi_kh")
        gioi_tinh = Request.form("gioi_tinh")
        sdt_kh = Request.form("sdt_kh")
        email_kh = Request.form("email_kh")
        password_kh = Request.form("password_kh")
        diachi_kh = Request.form("diachi_kh")
        

        if (isnull (ma_kh) OR trim(ma_kh) = "") then ma_kh=0 end if

        if (cint(ma_kh)=0) then
            if (NOT isnull(ten_kh) and ten_kh <>"" and NOT isnull(tuoi_kh) and tuoi_kh <>"" and NOT isnull(gioi_tinh) and gioi_tinh <>"" and NOT isnull(sdt_kh) and sdt_kh <>"" and NOT isnull(email_kh) and email_kh <>"" and NOT isnull(password_kh) and password_kh <>"" and NOT isnull(diachi_kh) and diachi_kh <>"") then
                Set cmdPrep = Server.CreateObject("ADODB.Command")
                connDB.Open()                
                cmdPrep.ActiveConnection = connDB
                cmdPrep.CommandType = 1
                cmdPrep.Prepared = True
                cmdPrep.CommandText = "INSERT INTO KHACHHANG(ten_kh,tuoi_kh,gioi_tinh,sdt_kh,email_kh,password_kh,diachi_kh) VALUES(?,?,?,?,?,?,?)"
                cmdPrep.parameters.Append cmdPrep.createParameter("ten_kh",202,1,255,ten_kh)
                cmdPrep.parameters.Append cmdPrep.createParameter("tuoi_kh",202,1,255,tuoi_kh)
                cmdPrep.parameters.Append cmdPrep.createParameter("gioi_tinh",202,1,255,gioi_tinh)
                cmdPrep.parameters.Append cmdPrep.createParameter("sdt_kh",202,1,255,sdt_kh)
                cmdPrep.parameters.Append cmdPrep.createParameter("email_kh",202,1,255,email_kh)
                cmdPrep.parameters.Append cmdPrep.createParameter("password_kh",202,1,255,password_kh)
                cmdPrep.parameters.Append cmdPrep.createParameter("diachi_kh",202,1,255,diachi_kh)

                cmdPrep.execute               
                
                If Err.Number = 0 Then 
                
                    Session("Success") = "New customer added!"                    
                    Response.redirect("customer.asp")  
                Else  
                    handleError(Err.Description)
                End If
                On Error GoTo 0
            else
                Session("Error") = "You have to input enough info"                
            end if
   else
            if (NOT isnull(ten_kh) and ten_kh <>"" and NOT isnull(tuoi_kh) and tuoi_kh <>"" and NOT isnull(gioi_tinh) and gioi_tinh <>"" and NOT isnull(sdt_kh) and sdt_kh <>"" and NOT isnull(email_kh) and email_kh <>"" and NOT isnull(password_kh) and password_kh <>"" and NOT isnull(diachi_kh) and diachi_kh <>"") then
                Set cmdPrep = Server.CreateObject("ADODB.Command")
                connDB.Open()                
                cmdPrep.ActiveConnection = connDB
                cmdPrep.CommandType = 1
                cmdPrep.Prepared = True
                cmdPrep.CommandText = "UPDATE KHACHHANG SET ten_kh=?,tuoi_kh=?,gioi_tinh=?,sdt_kh=?,email_kh=?,password_kh=?,diachi_kh=? WHERE ma_kh=?"
                cmdPrep.parameters.Append cmdPrep.createParameter("ten_kh",202,1,255,ten_kh)
                cmdPrep.parameters.Append cmdPrep.createParameter("tuoi_kh",202,1,255,tuoi_kh)
                cmdPrep.parameters.Append cmdPrep.createParameter("gioi_tinh",202,1,255,gioi_tinh)
                cmdPrep.parameters.Append cmdPrep.createParameter("sdt_kh",202,1,255,sdt_kh)
                cmdPrep.parameters.Append cmdPrep.createParameter("email_kh",202,1,255,email_kh)
                cmdPrep.parameters.Append cmdPrep.createParameter("password_kh",202,1,255,password_kh)
                cmdPrep.parameters.Append cmdPrep.createParameter("diachi_kh",202,1,255,diachi_kh)
                cmdPrep.parameters.Append cmdPrep.createParameter("ma_kh",3,1, ,ma_kh)

                cmdPrep.execute
                If Err.Number=0 Then
                    Session("Success") = "The customer was edited!"
                    Response.redirect("customer.asp")
                Else
                    handleError(Err.Description)
                End If
                On Error Goto 0
            else
                Session("Error") = "You have to input enough info"
            end if
        end if
    End If    
%>

<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width,initial-scale=1">
        <link rel="stylesheet" href="../style/addedit.css">
        <title>Add/Edit Customer</title>
    </head>
    <body>
        
        <div id="modal-container" >
        <div class="modal" id="modal-main">
          <div id="modal-header">  
              <h3>Add/Edit Customer</h3>
              <button id="btn-modal-close"><i class="fa-solid fa-xmark"></i></button>
          </div>
          <div id="modal-body">
            <form method="post">
              <div class="inputbox">
              
                <input type="text" id="ten_kh" name="ten_kh" required value="<%=ten_kh%>">
                <span>Name</span>
              </div>
              <div class="inputbox">
                
                <input type="number" id="tuoi_kh" name="tuoi_kh" required value="<%=tuoi_kh%>">
                <span>Age</span>
              </div>
              <div class="inputbox">
                <select name="gioi_tinh" id="gioi_tinh">
                  <option value="" <% If gioi_tinh = "" Then Response.Write("selected") %>>Chọn giới tính</option>
                  <option value="Male" <% If gioi_tinh = "Male" Then Response.Write("selected") %>>Male</option>
                  <option value="Female" <% If gioi_tinh = "Female" Then Response.Write("selected") %>>Female</option>
                </select>                
                <span>Gender</span>
              </div>
              <div class="inputbox">
                
                <input type="email" id="email_kh" name="email_kh" required value="<%=email_kh%>">
                <span>Email</span>
              </div>
              <div class="inputbox">
                
                <input type="text" id="sdt_kh" name="sdt_kh" required value="<%=sdt_kh%>">
                <span>Phone</span>
              </div>          
              <div class="inputbox">

                <input type="text" id="password_kh" name="password_kh" required value="<%=password_kh%>">
                <span>Password</span>
              </div>
              <div class="inputbox">

                <input type="text"  id="diachi_kh" name="diachi_kh"  required value="<%=diachi_kh%>">
                <span>Address</span>
              </div>
              <button type="submit" class="btn-submit">
              		<%
                        if (ma_kh=0) then
                            Response.write("Create")
                        else
                            Response.write("Save")
                        end if
                    %>
              </button>
              <button class="btn-submit" style="background: #eb5160;"><a href="customer.asp" style="text-decoration: none; color: white">Cancel</a></button>
            </form>
          </div>
        </div>
      </div>
    </div>
    </body>
</html>