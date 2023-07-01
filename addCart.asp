<!--#include file="connect.asp"-->
<%
    'Lay ve ma_sp
    Dim ma_sp
    ma_sp = Request.QueryString("ma_sp")
    ' Do Something...
    If (NOT IsNull(ma_sp) and ma_sp <> "") Then
        Dim cmdPrep, Result
        Set cmdPrep = Server.CreateObject("ADODB.Command")
            connDB.Open()
            cmdPrep.ActiveConnection = connDB
            cmdPrep.CommandType = 1
            cmdPrep.CommandText = "SELECT * FROM SANPHAM WHERE ma_sp=?"
            cmdPrep.Parameters(0)=ma_sp
            Set Result = cmdPrep.execute 

            If not Result.EOF then
                'ID exits
                'check session exists
                Dim currentCarts, arrays, cc, mycarts, List
                If (NOT IsEmpty(Session("mycarts"))) Then
                    ' true
                    Set currentCarts = Session("mycarts")                                                    
                    if currentCarts.Exists(ma_sp) = true then
                        'Response.Write("Key exists.")
                        Dim value
                        value = Clng(currentCarts.Item(ma_sp))+1
                        currentCarts.Item(ma_sp) = value                        
                    else
                       ' Response.Write("Key does not exist.")
                        currentCarts.Add ma_sp, 1
                    end if 
                    'saving new session value
                    Set Session("mycarts") = currentCarts
                    ' For Each List In currentCarts.Keys  
                    '     Response.write List& " = " & currentCarts.Item(List)  & "<br>"                        
                    ' Next              
                   'Response.Write("The Session is exists.")                                      
                Else
                    Dim quantity
                    quantity = 1                    
                    Set mycarts = Server.CreateObject("Scripting.Dictionary")
                    mycarts.Add ma_sp, quantity
                    'creating a session for my cart
                    Set Session("mycarts") = mycarts
                    Set mycarts = Nothing
                    Response.Write("Session created!")
                End if
                Session("Success") = "The Product has bean added to your cart."
            Else
                Session("Error") = "The Product is not exists, please try again."
            End If

            ' Set Result = Nothing
            Result.Close()
            connDB.Close()

           Response.redirect("index.asp#product")            
    End if
    'Dim mycarts
   'lay ve danh sach ID trong gio hang
    'Su dung dictionary object de luu tru id product kem theo so luong
    '1. De an tam: hay kiem tra truoc xem id product co ton tai trong table product hay khong
    '- Neu ton tai thi:
    '   - Kiem tra neu session carts da ton tai thi: Kiem tra id product da ton tai trong carts hay chua, neu da ton tai thi quantity++; Neu chua thi add
    '   - Neu session chua ton tai thi tao dictionary add id va quantity vao sau do tao session
    '- Neu ip product khong con ton tai trong table product thi thong bao.
    'Dim carts
    'Set mycarts = Server.CreateObject("Scripting.Dictionary")
    'carts.Add ma_sp, quantity
  ' mycart = Session("s_Carts")
   ' If IsArray(mycart) then
    ' Response.Write(LBound(mycart)&":--->"&UBound(mycart))
    'Tao ra gio hang moi de tiep tuc mua
   ' Dim newCart
    'Redim newCart(UBound(mycart)+1)
    'copy du lieu sang gio hang co kich thuoc tang them 1
   ' for i=LBound(mycart) to UBound(mycart)
    'newCart(i) = mycart(i)
   ' Next
    'chon them 1 san pham va bo sung vao gio hang
    'newCart(UBound(mycart)+1)=ma_sp
    'luu gio hang moi vao session
   ' Session("s_Carts") = newCart
    'Response.redirect("products.asp")
%>