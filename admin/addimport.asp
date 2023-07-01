<!-- #include file="../connect.asp" -->
<%
    If (Request.ServerVariables("REQUEST_METHOD") = "GET") THEN        
        mahoadon_nhap = Request.QueryString("mahoadon_nhap")
        If (isnull(mahoadon_nhap) OR trim(mahoadon_nhap) = "") then 
            mahoadon_nhap=0 
        End if
        If (cint(mahoadon_nhap)<>0) Then
            Set cmdPrep = Server.CreateObject("ADODB.Command")
            connDB.Open()
            cmdPrep.ActiveConnection = connDB
            cmdPrep.CommandType = 1
            cmdPrep.CommandText = "SELECT * FROM HOADONNHAP WHERE mahoadon_nhap=?"
            
            cmdPrep.Parameters(0)=mahoadon_nhap
            Set Result = cmdPrep.execute 

            If not Result.EOF then
                soluong_nhap = Result("soluong_nhap")
                ma_sp = Result("ma_sp")
                ma_nhacc = Result("ma_nhacc")
                 
            End If

   
            Result.Close()
        End If
    Else
        mahoadon_nhap = Request.QueryString("mahoadon_nhap")
        soluong_nhap = Request.form("soluong_nhap")
        ma_sp = Request.form("ma_sp")
        ma_nhacc = Request.form("ma_nhacc")
         ngay_nhap = Request.form("ngay_nhap")
        
        

        if (isnull (mahoadon_nhap) OR trim(mahoadon_nhap) = "") then mahoadon_nhap=0 end if

        if (cint(mahoadon_nhap)=0) then
            if (NOT isnull(soluong_nhap) and soluong_nhap <>"" and NOT isnull(ma_sp) and ma_sp <>"" and NOT isnull(ma_nhacc) and ma_nhacc <>"") then
                Set cmdPrep = Server.CreateObject("ADODB.Command")
                connDB.Open()                
                cmdPrep.ActiveConnection = connDB
                cmdPrep.CommandType = 1
                cmdPrep.Prepared = True
                cmdPrep.CommandText = "INSERT INTO HOADONNHAP(soluong_nhap,ma_sp,ma_nhacc,ngay_nhap) VALUES(?,?,?,GETDATE())"
                cmdPrep.parameters.Append cmdPrep.createParameter("soluong_nhap",202,1,255,soluong_nhap)
                cmdPrep.parameters.Append cmdPrep.createParameter("ma_sp",202,1,255,ma_sp)
                cmdPrep.parameters.Append cmdPrep.createParameter("ma_nhacc",202,1,255,ma_nhacc)
               

                cmdPrep.execute               
                
                If Err.Number = 0 Then 
                
                        Dim updateCmd
                        Set updateCmd = Server.CreateObject("ADODB.Command")
                        updateCmd.ActiveConnection = connDB
                        updateCmd.CommandType = 1 ' adCmdText
                        updateCmd.CommandText = "UPDATE SANPHAM SET soluong_ton = soluong_ton + ? WHERE ma_sp = ?"
                        updateCmd.Parameters.Append updateCmd.CreateParameter("soluong_nhap", 3, 1, , soluong_nhap)
                        updateCmd.Parameters.Append updateCmd.CreateParameter("ma_sp", 3, 1, , ma_sp)
                        updateCmd.Execute
                        Set updateCmd = Nothing 
                    If Err.Number = 0 Then
                        Session("Success") = "New import bill added!"
                        Response.redirect("import.asp")
                    Else
                        handleError(Err.Description)
                    End If  
                Else  
                    handleError(Err.Description)
                End If
                On Error GoTo 0
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
        <title>Add Import</title>
    </head>
    <body>
        
        <div id="modal-container" >
        <div class="modal" id="modal-main">
          <div id="modal-header">  
              <h3>Add Import</h3>
              <button id="btn-modal-close"><i class="fa-solid fa-xmark"></i></button>
          </div>
          <div id="modal-body">
            <form method="post">
              <div class="inputbox">
              
                <input type="text" id="soluong_nhap" name="soluong_nhap" required>
                <span>Quantity</span>
              </div>
              <div class="inputbox">
                
                <input type="number" id="ma_sp" name="ma_sp" required >
                <span>Product ID</span>
              </div>
              <div class="inputbox">
                
                <input type="text" id="ma_nhacc" name="ma_nhacc"  required >
                <span>Supplier ID</span>
              </div>
              <button type="submit" class="btn-submit">
              		Create
              </button>
              <button class="btn-submit" style="background: #eb5160;"><a href="import.asp" style="text-decoration: none; color: white">Cancel</a></button>

            </form>
          </div>
        </div>
      </div>
    </div>
    </body>
</html>