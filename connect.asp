<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
'code here
Dim connDB
set connDB = Server.CreateObject("ADODB.Connection")
Dim strConnection
strConnection = "Provider=SQLOLEDB.1;Data Source=YEUVOBAN\SQLEXPRESS;Database=DO_AN_WEB;User Id=sa;Password=1234"
connDB.ConnectionString = strConnection
%>