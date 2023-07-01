<!-- #include file="../connect.asp" -->
<%
    On Error Resume Next
    mahoadon_ban = Request.QueryString("mahoadon_ban")

    if (isnull(mahoadon_ban) or trim(mahoadon_ban) = "") then
        Response.Redirect("export.asp")
        Response.End
    end if

    Set cmdPrep = Server.CreateObject("ADODB.Command")
    connDB.Open()
    cmdPrep.ActiveConnection = connDB
    cmdPrep.CommandType = 1
    cmdPrep.CommandText = "UPDATE HOADONBAN SET trang_thai = IIF(trang_thai = 0, 1, 0) WHERE mahoadon_ban = ?"
    cmdPrep.Parameters.Append cmdPrep.CreateParameter("mahoadon_ban", 3, 1, , mahoadon_ban)

    cmdPrep.Execute
    connDB.Close()

    If Err.Number = 0 Then
    Session("Success") = "Changed Status"    
    Else
        Session("Error") = Err.Description
    End If
    Response.Redirect("export.asp")
    On Error Goto 0
%>
