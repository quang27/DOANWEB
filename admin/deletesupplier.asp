<!-- #include file="../connect.asp" -->
<%
    On Error Resume Next
    ma_nhacc = Request.QueryString("ma_nhacc")

    if (isnull(ma_nhacc) OR trim(ma_nhacc)="" ) then
        Response.redirect("supplier.asp")
        Response.End
    end if

    Set cmdPrep = Server.CreateObject("ADODB.Command")
    connDB.Open()
    cmdPrep.ActiveConnection = connDB
    cmdPrep.CommandType = 1
    cmdPrep.CommandText = "DELETE FROM NHACUNGCAP WHERE ma_nhacc=?"
    cmdPrep.parameters.Append cmdPrep.createParameter("ma_nhacc",3,1, ,ma_nhacc)

    cmdPrep.execute
    connDB.Close()
    If Err.Number = 0 Then
    Session("Success") = "Deleted"    
    Else
        Session("Error") = Err.Description
    End If
    Response.Redirect("supplier.asp")
    On Error Goto 0    

    
%>