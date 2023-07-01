<table class="table table-striped table-valign-middle">
                        <thead>
                        <tr>
                          <th>Mã CT</th>
                          <th>MÃ HD</th>
                          <th>Mã SP</th>     
                          <th>Số Lượng</th>
                        </tr>
                        </thead>
                        <tbody>
                          <%
                            Dim strSQL1
                            strSQL1 = "SELECT * FROM CTHOADONBAN"
                            If Request.ServerVariables("REQUEST_METHOD") = "GET" Then
                                mahoadon_ban = Request.QueryString("mahoadon_ban")
                                If IsNull(mahoadon_ban) Or Trim(mahoadon_ban) = "" Then 
                                    mahoadon_ban = 0 
                                End If
                                If CInt(mahoadon_ban) <> 0 Then
                                    strSQL1 = strSQL1 & " WHERE mahoadon_ban = " & mahoadon_ban
                                End If
                            End If

                            Set cmdPrep = Server.CreateObject("ADODB.Command")
                            connDB.Open()
                            cmdPrep.ActiveConnection = connDB
                            cmdPrep.CommandType = 1
                            cmdPrep.CommandText = strSQL1

                            Set Result = cmdPrep.Execute

                            Do Until Result.EOF
                                macthoadon_ban = Result("macthoadon_ban")
                                ma_sp = Result("ma_sp")
                                soluong_ban = Result("soluong_ban")
                          %>
                          <tr>
                            <td><%=Result("macthoadon_ban")%></td>
                            <td><%=Result("mahoadon_ban")%></td>
                            <td><%=Result("ma_sp")%></td>
                            <td><%=Result("soluong_ban")%></td>
                          </tr> 
                          <%
                            Result.MoveNext
                            Loop
                          %>
                          </tbody>
                      </table>