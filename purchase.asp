<!-- #include file="connect.asp" -->
<%
Function InsertCTHoadonban(connDB, mahoadon_ban, ma_sp, soluong_ban)
    Dim cmdPrep2
    Set cmdPrep2 = Server.CreateObject("ADODB.Command")
    cmdPrep2.ActiveConnection = connDB
    cmdPrep2.CommandType = 1
    cmdPrep2.Prepared = True
    cmdPrep2.CommandText = "INSERT INTO CTHOADONBAN (mahoadon_ban, ma_sp, soluong_ban) VALUES (?, ?, ?)"
    cmdPrep2.Parameters.Append cmdPrep2.CreateParameter("mahoadon_ban", 3, 1, , mahoadon_ban)
    cmdPrep2.Parameters.Append cmdPrep2.CreateParameter("ma_sp", 3, 1, , ma_sp)
    cmdPrep2.Parameters.Append cmdPrep2.CreateParameter("soluong_ban", 3, 1, , soluong_ban)
    cmdPrep2.Execute
End Function
Dim mycarts
If (NOT IsEmpty(Session("mycarts"))) Then
    Set mycarts = Session("mycarts")

            Dim cmdPrep
            Set cmdPrep = Server.CreateObject("ADODB.Command")
            connDB.Open()                
            cmdPrep.ActiveConnection = connDB
            cmdPrep.CommandType = 1
            cmdPrep.Prepared = True

            Dim currentDate
            currentDate = Now()
            Dim formattedDate
            formattedDate = Year(currentDate) & "-" & Right("0" & Month(currentDate), 2) & "-" & Right("0" & Day(currentDate), 2) & " " & Right("0" & Hour(currentDate), 2) & ":" & Right("0" & Minute(currentDate), 2) & ":" & Right("0" & Second(currentDate), 2)

            cmdPrep.CommandText = "INSERT INTO HOADONBAN (ngay_ban, ma_kh) VALUES (?, ?)"
            cmdPrep.Parameters.Append cmdPrep.CreateParameter("ngay_ban", 7, 1, , formattedDate)
            cmdPrep.Parameters.Append cmdPrep.CreateParameter("ma_kh", 3, 1, , Session("ma_kh"))
            cmdPrep.Execute



            Dim cmdPrep1
            Set cmdPrep1 = Server.CreateObject("ADODB.Command")
            cmdPrep1.ActiveConnection = connDB
            cmdPrep1.CommandType = 1
            cmdPrep1.Prepared = True
            cmdPrep1.CommandText = "SELECT * FROM HOADONBAN WHERE ngay_ban = ?"
            cmdPrep1.Parameters.Append cmdPrep.CreateParameter("ngay_ban", 7, 1, , formattedDate)
            Set Result = cmdPrep1.Execute
            mahoadon_ban = Result("mahoadon_ban")

            Dim quantityArray
            quantityArray = Request.Form("quantity")
            quantityArrays = Split(quantityArray, ",")
            Dim count
            count = 0

            Dim cmdPrep2
            Set cmdPrep2 = Server.CreateObject("ADODB.Command")
            cmdPrep2.ActiveConnection = connDB
            cmdPrep2.CommandType = 1
            cmdPrep2.Prepared = True
            For Each tmp In mycarts.Keys
                mycarts.Item(tmp) = Clng(quantityArrays(count))
                count = count + 1
                
                InsertCTHoadonban connDB, mahoadon_ban, tmp, mycarts.Item(tmp)
            Next

            Session.Contents.Remove("mycarts")
            Response.Redirect "index.asp"
END if
              
%>