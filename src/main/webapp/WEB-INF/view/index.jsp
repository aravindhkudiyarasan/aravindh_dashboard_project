<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<head>

  <link rel="stylesheet" href="/admin/plugins/fontawesome-free/css/all.min.css">
  
  <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
  
  <link rel="stylesheet" href="/admin/css/index.css">
  
  <link rel="stylesheet" href="/admin/plugins/overlayScrollbars/css/OverlayScrollbars.min.css">
  
  <link rel="stylesheet" href="/admin/plugins/datatables-bs4/css/dataTables.bootstrap4.min.css">
   
  <link rel="stylesheet" href="/admin/plugins/datatables-responsive/css/responsive.bootstrap4.min.css">

</head>
    <section class="content">
      <div class="card">
              <div class="card-body">
                <table id="searchtable" class="table table-bordered table-striped">
                  <thead>
                  <tr>
                    <th>ID</th>
                    <th>Server Name</th>
                    <th>Image Id</th>
                    <th>Container Id</th>
                    <th>Memory</th>
                    <th>UpTime</th>
                    <th>Status</th>
                  </tr>
                  </thead>
                  <tbody>
                  <c:forEach var="tempdata" items="${tabledata}">
                  <tr>
                    <td>${tempdata.id}</td>
                    <td>${tempdata.servername}</td>
                    <td>${tempdata.imageid}</td>
                    <td>${tempdata.containerid}</td>
                    <td>${tempdata.memory}</td>
                    <td>${tempdata.uptime}</td>
                    <td>${tempdata.date}</td>
                  </tr>
                  </c:forEach>
                  </tbody>
                </table>
              </div>
              <!-- /.card-body -->
            </div>
    </section>
    
<script src="/admin/plugins/jquery/jquery.min.js"></script>

<script src="/admin/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>

<script src="/admin/js/index.js"></script>

<script src="/admin/plugins/bs-custom-file-input/bs-custom-file-input.min.js"></script>

<script src="/admin/plugins/overlayScrollbars/js/jquery.overlayScrollbars.min.js"></script>

<script src="/admin/plugins/datatables/jquery.dataTables.min.js"></script>

<script src="/admin/plugins/datatables-bs4/js/dataTables.bootstrap4.min.js"></script>

<link rel="stylesheet" href="/admin/plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css">

<script src="/admin/plugins/datatables-responsive/js/dataTables.responsive.min.js"></script>

<script src="/admin/plugins/datatables-responsive/js/responsive.bootstrap4.min.js"></script>

<script src="/admin/plugins/moment/moment.min.js"></script>

<script src="/admin/plugins/tempusdominus-bootstrap-4/js/tempusdominus-bootstrap-4.min.js"></script> 


<script>
  $(function () {
    $("#searchtable").DataTable({
      "responsive": true,
      "autoWidth": false,
    });
  });
</script>