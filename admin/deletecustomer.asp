<!-- #include file="../connect.asp" -->
<%
    On Error Resume Next
    ma_kh = Request.QueryString("ma_kh")

    if (isnull(ma_kh) OR trim(ma_kh)="" ) then
        Response.redirect("customer.asp")
        Response.End
    end if

    Set cmdPrep = Server.CreateObject("ADODB.Command")
    connDB.Open()
    cmdPrep.ActiveConnection = connDB
    cmdPrep.CommandType = 1
    cmdPrep.CommandText = "DELETE FROM KHACHHANG WHERE ma_kh=?"
    cmdPrep.parameters.Append cmdPrep.createParameter("ma_kh",3,1, ,ma_kh)

    cmdPrep.execute
    connDB.Close()
    If Err.Number = 0 Then
    Session("Success") = "Deleted"    
    Else
        Session("Error") = Err.Description
    End If
    Response.Redirect("customer.asp")
    On Error Goto 0    

    
%>