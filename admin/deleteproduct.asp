<!-- #include file="../connect.asp" -->
<%
    On Error Resume Next
    ma_sp = Request.QueryString("ma_sp")

    if (isnull(ma_sp) OR trim(ma_sp)="" ) then
        Response.redirect("product.asp")
        Response.End
    end if

    Set cmdPrep = Server.CreateObject("ADODB.Command")
    connDB.Open()
    cmdPrep.ActiveConnection = connDB
    cmdPrep.CommandType = 1
    cmdPrep.CommandText = "DELETE FROM SANPHAM WHERE ma_sp=?"
    cmdPrep.parameters.Append cmdPrep.createParameter("ma_sp",3,1, ,ma_sp)

    cmdPrep.execute
    connDB.Close()
    If Err.Number = 0 Then
    Session("Success") = "Deleted"    
    Else
        Session("Error") = Err.Description
    End If
    Response.Redirect("product.asp")
    On Error Goto 0    

    
%>