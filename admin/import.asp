<!-- #include file="../connect.asp" -->
<%
  If (isnull(Session("email_ql")) OR TRIM(Session("email_ql")) = "") Then
        Response.redirect("loginadmin.asp")
  End If
    function Ceil(Number)
        Ceil = Int(Number)
        if Ceil<>Number Then
            Ceil = Ceil + 1
        end if
    end function

    function checkPage(cond, ret) 
        if cond=true then
            Response.write ret
        else
            Response.write ""
        end if
    end function

    page = Request.QueryString("page")
    limit = 4

    if (trim(page) = "") or (isnull(page)) then
        page = 1
    end if

    offset = (Clng(page) * Clng(limit)) - Clng(limit)

    strSQL = "SELECT COUNT(mahoadon_nhap) AS count FROM HOADONNHAP"
    connDB.Open()
    Set CountResult = connDB.execute(strSQL)

    totalRows = CLng(CountResult("count"))

    Set CountResult = Nothing

    pages = Ceil(totalRows/limit)
    
    Dim range
    If (pages<=5) Then
        range = pages
    Else
        range = 5
    End if
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"/>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css">
  <title>Import</title>

  <!-- Google Font: Source Sans Pro -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
  <!-- Font Awesome Icons -->
  <link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">
  <!-- IonIcons -->
  <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="dist/css/adminlte.min.css">
  <link rel="preconnect" href="https://fonts.bunny.net">
  <link href="https://fonts.bunny.net/css?family=figtree:400,600&display=swap" rel="stylesheet" />
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
  <style>
    *{
      font-family:Figtree, sans-serif;
    }
    #alert_id{
        font-size: 15px;
        padding: 10px 15px;
        margin-bottom: 10px;
        transition: 1s;
    }
  </style>
</head>
<!--
`body` tag options:

  Apply one or more of the following classes to to the body tag
  to get the desired effect

  * sidebar-collapse
  * sidebar-mini
-->
<body class="hold-transition sidebar-mini">
<div class="wrapper">
  <!-- Navbar -->
  <nav class="main-header navbar navbar-expand navbar-white navbar-light">
    <!-- Left navbar links -->
    <ul class="navbar-nav">
      <li class="nav-item">
        <a class="nav-link" data-widget="pushmenu" href="#" role="button"><i class="fas fa-bars"></i></a>
      </li>
    </ul>

    <!-- Right navbar links -->
    <ul class="navbar-nav ml-auto">
      <!-- Navbar Search -->
      <li>
        <%
        Dim success
        success = Session("Success")
        If Not isnull(success) Then
        Response.Write("<div id='alert_id' class='badge text-bg-success'>" & success & "</div>")
        Session.Contents.Remove("Success")
        End If
        %>

        <%
        Dim error
        error = Session("Error")
        If Not isnull(error) Then
        Response.Write("<div id='alert_id' class='badge text-bg-error'>" & error & "</div>")
        Session.Contents.Remove("Error")
        End If
        %>
      </li>
      <li class="nav-item">
        <a class="nav-link" data-widget="navbar-search" href="#" role="button">
          <i class="fas fa-search"></i>
        </a>
        <div class="navbar-search-block">
          <form class="form-inline">
            <div class="input-group input-group-sm">
              <input class="form-control form-control-navbar" type="search" placeholder="Search by ID" aria-label="Search" name="keyword">
              <div class="input-group-append">
                <button class="btn btn-navbar" type="submit">
                  <i class="fas fa-search"></i>
                </button>
                <button class="btn btn-navbar" type="button" data-widget="navbar-search">
                  <i class="fas fa-times"></i>
                </button>
              </div>
            </div>
          </form>
        </div>
      </li>

      
      <li class="nav-item">
        <a class="nav-link" data-widget="fullscreen" href="#" role="button">
          <i class="fas fa-expand-arrows-alt"></i>
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link" data-widget="control-sidebar" data-slide="true" href="#" role="button">
          <i class="fas fa-th-large"></i>
        </a>
      </li>

    </ul>
  </nav>
  <!-- /.navbar -->

  <!-- Main Sidebar Container -->
  <aside class="main-sidebar sidebar-dark-primary elevation-4">
    <!-- Brand Logo -->
    <a href="../index.asp" class="brand-link">
      <img src="dist/img/AdminLTELogo.png" alt="AdminLTE Logo" class="brand-image img-circle elevation-3" style="opacity: .8">
      <span class="brand-text font-weight-light">Index</span>
    </a>

    <!-- Sidebar -->
    <div class="sidebar">
      <!-- Sidebar user panel (optional) -->
      <div class="user-panel mt-3 pb-3 mb-3 d-flex">
        <div class="image">
          <img src="dist/img/user2-160x160.jpg" class="img-circle elevation-2" alt="User Image">
        </div>
        <div class="info">
          <% Dim currentTime
            currentTime = Now
          %>
          <% If Hour(currentTime) >= 6 And Hour(currentTime) < 12 Then %>
              <a href="#" class="d-block">Good morning, <%=Session("ten_ql")%></a>
          <% ElseIf Hour(currentTime) >= 12 And Hour(currentTime) < 18 Then %>
              <a href="#" class="d-block">Good afternoon, <%=Session("ten_ql")%></a>
          <% Else %>
              <a href="#" class="d-block">Good evening, <%=Session("ten_ql")%></a>
          <% End If %>
        </div>
      </div>

      <!-- Sidebar Menu -->
      <nav class="mt-2">
        <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
          <!-- Add icons to the links using the .nav-icon class
               with font-awesome or any other icon font library -->
          <li class="nav-item menu-open">
            <a href="#" class="nav-link active">
              <i class="nav-icon fas fa-tachometer-alt"></i>
              <p>
                Dashboard
                <i class="right fas fa-angle-left"></i>
              </p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
                <a href="product.asp" class="nav-link ">
                  <i class="far fa-circle nav-icon"></i>
                  <p>Product</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="customer.asp" class="nav-link ">
                  <i class="far fa-circle nav-icon"></i>
                  <p>Customer</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="supplier.asp" class="nav-link ">
                  <i class="far fa-circle nav-icon"></i>
                  <p>Supplier</p>
                </a>
              </li>
            </ul>
          </li>
          <li class="nav-item menu-open">
            <a href="#" class="nav-link active">
              <i class="nav-icon fas fa-tachometer-alt"></i>
              <p>
                Bill
                <i class="right fas fa-angle-left"></i>
              </p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
                <a href="import.asp" class="nav-link active">
                  <i class="fa-regular fa-circle-dot nav-icon"></i>
                  <p>Import</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="export.asp" class="nav-link ">
                  <i class="far fa-circle nav-icon"></i>
                  <p>Export</p>
                </a>
              </li>
            </ul>
          </li>
          <li style="text-align: center; margin-top: 50px;"><button class="btn btn-primary" ><a href="logoutadmin.asp" style="text-decoration: none;">Log out</a></button></li>
        </ul>
      </nav>
      <!-- /.sidebar-menu -->
    </div>
    <!-- /.sidebar -->
  </aside>

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1 class="m-0">Import</h1>
          </div><!-- /.col -->
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <button class="btn btn-primary" ><a href="addimport.asp"><i class="fa-solid fa-plus" style="color: white;"></i></a></button>
            </ol>
          </div><!-- /.col -->
        </div><!-- /.row -->
      </div><!-- /.container-fluid -->
    </div>
    <!-- /.content-header -->

    <!-- Main content -->
    <div class="content">
      <div class="container-fluid">
        <div class="row">
          <div class="col-lg-12">
            <div class="card">
              
              
            </div>
            <!-- /.card -->

            <div class="card">
              
              <div class="card-body table-responsive p-0">
                <table class="table table-striped table-valign-middle" style="text-align:center;">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Quantity</th>
                        <th>Product ID</th>
                        <th>Supplier ID</th>
                        <th><a href="?sort=createddate" style="text-decoration: none;">Created Date</a></th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                    Dim searchKeyword, strSQL, sortParameter, sortState
                    sortState = "ASC"
                    sortParameter = Request.QueryString("sort")
                    
                    If Not IsNull(sortParameter) And LCase(sortParameter) = "createddate" Then
                        If Session("SortState") = "ASC" Then
                            sortState = "DESC"
                        Else
                            sortState = "ASC"
                        End If
                        Session("SortState") = sortState
                    Else
                        sortState = "ASC"
                        Session.Contents.Remove("SortState")
                    End If
                    
                    ' Tạo câu truy vấn SQL
                    strSQL = "SELECT * FROM HOADONNHAP"
                    If sortState = "ASC" Then
                        strSQL = strSQL & " ORDER BY ngay_nhap ASC"
                    ElseIf sortState = "DESC" Then
                        strSQL = strSQL & " ORDER BY ngay_nhap DESC"
                    End If
                    
                    ' Tìm kiếm
                    searchKeyword = Request.QueryString("keyword")
                    If Not IsNull(searchKeyword) And searchKeyword <> "" Then
                        strSQL = strSQL & " WHERE mahoadon_nhap LIKE '%" & searchKeyword & "%'"
                    End If
                    
                    ' Thực hiện truy vấn
                    strSQL = strSQL & " OFFSET ? ROWS FETCH NEXT ? ROWS ONLY"
                    Set cmdPrep = Server.CreateObject("ADODB.Command")
                    cmdPrep.ActiveConnection = connDB
                    cmdPrep.CommandType = 1
                    cmdPrep.CommandText = strSQL
                    cmdPrep.Parameters.Append cmdPrep.CreateParameter("offset", 3, 1, , offset)
                    cmdPrep.Parameters.Append cmdPrep.CreateParameter("limit", 3, 1, , limit)
                    
                    Set Result = cmdPrep.Execute
                    Do While Not Result.EOF
                    %>
                    <tr>
                        <td><%=Result("mahoadon_nhap")%></td>
                        <td><%=Result("soluong_nhap")%></td>
                        <td><%=Result("ma_sp")%></td>
                        <td><%=Result("ma_nhacc")%></td>
                        <td><%=Result("ngay_nhap")%></td>
                        <td>
                            <% If Result("trang_thai") = 0 Then %>
                            <p class="badge text-bg-danger">Inactive</p>
                            <% Else %>
                            <p class="badge text-bg-success">Active</p>
                            <% End If %>
                        </td>
                        <td>
                            <% If Result("trang_thai") = 0 Then %>
                              <a href="active.asp?mahoadon_nhap=<%=Result("mahoadon_nhap")%>" class="btn btn-success">Active</a>
                            <% Else %>
                              <a href="active.asp?mahoadon_nhap=<%=Result("mahoadon_nhap")%>" class="btn btn-danger">Inactive</a>
                            <% End If %>
                        </td>
                    </tr>
                    <%
                        Result.MoveNext
                    Loop
                    %>
                </tbody>
            </table>

              </div>

            <nav aria-label="Page Navigation">
    <ul class="pagination justify-content-center my-5">
        <% 
            If pages > 1 Then
                If Clng(page) >= 2 Then
        %>
                    <li class="page-item"><a class="page-link" href="import.asp?page=<%=Clng(page)-1%>"><i class="fa-solid fa-backward"></i></a></li>
        <%
                End If
                For i = 1 To range
        %>
                    <li class="page-item <%=checkPage(Clng(i) = Clng(page), "active")%>"><a class="page-link" href="import.asp?page=<%=i%>"><%=i%></a></li>
        <%
                Next
                If Clng(page) < pages Then
        %>
                    <li class="page-item"><a class="page-link" href="import.asp?page=<%=Clng(page)+1%>"><i class="fa-solid fa-forward"></i></a></li>
        <%
                End If
            End If
        %>
    </ul>
</nav>

            </div>
            <!-- /.card -->
          </div>
        </div>
        <!-- /.row -->
      </div>
      <!-- /.container-fluid -->
    </div>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->

  <!-- Control Sidebar -->
  <aside class="control-sidebar control-sidebar-dark">
    <!-- Control sidebar content goes here -->
  </aside>
  <!-- /.control-sidebar -->

  
</div>
<!-- ./wrapper -->

<!-- REQUIRED SCRIPTS -->

<!-- jQuery -->
<script src="plugins/jquery/jquery.min.js"></script>
<!-- Bootstrap -->
<script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- AdminLTE -->
<script src="dist/js/adminlte.js"></script>

<!-- OPTIONAL SCRIPTS -->
<script src="plugins/chart.js/Chart.min.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="dist/js/demo.js"></script>
<!-- AdminLTE dashboard demo (This is only for demo purposes) -->
<script src="dist/js/pages/dashboard3.js"></script>
<script>
  var alertElement = document.getElementById("alert_id");
  setTimeout(function() {
  alertElement.style.opacity = 0;
  setTimeout(function() {
  alertElement.style.display = "none";
  }, 1000);
  }, 2000);
</script>
<script>
    const sortButton = document.getElementById('sort-createddate');
    
    sortButton.addEventListener('click', () => {
    const currentUrl = new URL(window.location.href);
    currentUrl.searchParams.set('sort', 'createddate');
    const newUrl = currentUrl.href;

    // Chuyển hướng đến URL mới
    window.location.href = newUrl;
    });
</script>
</body>
</html>
