<!-- #include file="../connect.asp" -->
<%
    On Error Resume Next
    mahoadon_nhap = Request.QueryString("mahoadon_nhap")

    if (isnull(mahoadon_nhap) or trim(mahoadon_nhap) = "") then
        Response.Redirect("import.asp")
        Response.End
    end if

    Set cmdPrep = Server.CreateObject("ADODB.Command")
    connDB.Open()
    cmdPrep.ActiveConnection = connDB
    cmdPrep.CommandType = 1
    cmdPrep.CommandText = "UPDATE HOADONNHAP SET trang_thai = IIF(trang_thai = 0, 1, 0) WHERE mahoadon_nhap = ?"
    cmdPrep.Parameters.Append cmdPrep.CreateParameter("mahoadon_nhap", 3, 1, , mahoadon_nhap)

    cmdPrep.Execute
    connDB.Close()

    If Err.Number = 0 Then
    Session("Success") = "Changed Status"    
    Else
        Session("Error") = Err.Description
    End If
    Response.Redirect("import.asp")
    On Error Goto 0
%>
