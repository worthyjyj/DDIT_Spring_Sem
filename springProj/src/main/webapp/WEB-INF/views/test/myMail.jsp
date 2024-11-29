<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- 세션 id.. -->
<% String id=(String)session.getAttribute("id");%>

<body>

     <!-- Begin Page Content -->
     <div class="container-fluid">

         <!-- Page Heading -->
         <h1 class="h3 mb-2 text-gray-800"><%=id%>님 메일함</h1>
         <p class="mb-4">WELCOME...!</p>

         <!-- DataTales Example -->
         <div class="card shadow mb-4">
             <div class="card-header py-3">
                 <h6 class="m-0 font-weight-bold text-primary">안읽은 메일 4개</h6>
             </div>
             <div class="card-body">
                 <div class="table-responsive">
                     <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                         <thead>
                             <tr>
                                 <th>보낸사람</th>
                                 <th>메일제목</th>
                                 <th>메일내용</th>
                                 <th>발송일시</th>
                             </tr>
                         </thead>
                         <tfoot>
                             <tr>
                                 <th>보낸사람</th>
                                 <th>메일제목</th>
                                 <th>메일내용</th>
                                 <th>발송일시</th>
                             </tr>
                         </tfoot>
                         <tbody>
                             <tr>
                                 <td>Tiger Nixon</td>
                                 <td>System Architect</td>
                                 <td>Edinburgh</td>
                                 <td>61</td>
                             </tr>
                             <tr>
                                 <td>Garrett Winters</td>
                                 <td>Accountant</td>
                                 <td>Tokyo</td>
                                 <td>63</td>
                             </tr>
                             <tr>
                                 <td>Ashton Cox</td>
                                 <td>Junior Technical Author</td>
                                 <td>San Francisco</td>
                                 <td>66</td>
                             </tr>
                             <tr>
                                 <td>Cedric Kelly</td>
                                 <td>Senior Javascript Developer</td>
                                 <td>Edinburgh</td>
                                 <td>22</td>
                             </tr>
                             <tr>
                                 <td>Airi Satou</td>
                                 <td>Accountant</td>
                                 <td>Tokyo</td>
                                 <td>33</td>
                             </tr>
                             <tr>
                                 <td>Brielle Williamson</td>
                                 <td>Integration Specialist</td>
                                 <td>New York</td>
                                 <td>61</td>
                             </tr>
                             <tr>
                                 <td>Herrod Chandler</td>
                                 <td>Sales Assistant</td>
                                 <td>San Francisco</td>
                                 <td>59</td>
                             </tr>
                             <tr>
                                 <td>Rhona Davidson</td>
                                 <td>Integration Specialist</td>
                                 <td>Tokyo</td>
                                 <td>55</td>
                             </tr>
                             <tr>
                                 <td>Colleen Hurst</td>
                                 <td>Javascript Developer</td>
                                 <td>San Francisco</td>
                                 <td>39</td>
                             </tr>
                             <tr>
                                 <td>Sonya Frost</td>
                                 <td>Software Engineer</td>
                                 <td>Edinburgh</td>
                                 <td>23</td>
                             </tr>
                             <tr>
                                 <td>Jena Gaines</td>
                                 <td>Office Manager</td>
                                 <td>London</td>
                                 <td>30</td>
                             </tr>
                             <tr>
                                 <td>Quinn Flynn</td>
                                 <td>Support Lead</td>
                                 <td>Edinburgh</td>
                                 <td>22</td>
                             </tr>
                             <tr>
                                 <td>Charde Marshall</td>
                                 <td>Regional Director</td>
                                 <td>San Francisco</td>
                                 <td>36</td>
                             </tr>
                             <tr>
                                 <td>Haley Kennedy</td>
                                 <td>Senior Marketing Designer</td>
                                 <td>London</td>
                                 <td>43</td>
                             </tr>
                             <tr>
                                 <td>Tatyana Fitzpatrick</td>
                                 <td>Regional Director</td>
                                 <td>London</td>
                                 <td>19</td>
                             </tr>
                             <tr>
                                 <td>Michael Silva</td>
                                 <td>Marketing Designer</td>
                                 <td>London</td>
                                 <td>66</td>
                             </tr>
                             <tr>
                                 <td>Paul Byrd</td>
                                 <td>Chief Financial Officer (CFO)</td>
                                 <td>New York</td>
                                 <td>64</td>
                             </tr>
                            
                         </tbody>
                     </table>
                 </div>
             </div>
         </div>

     </div>


    <!-- Scroll to Top Button-->
    <a class="scroll-to-top rounded" href="#page-top">
        <i class="fas fa-angle-up"></i>
    </a>

    <!-- Bootstrap core JavaScript-->
    <script src="/resources/sbadmin2/vendor/jquery/jquery.min.js"></script>
    <script src="/resources/sbadmin2/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="/resources/sbadmin2/vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="/resources/sbadmin2/js/sb-admin-2.min.js"></script>

    <!-- Page level plugins -->
    <script src="/resources/sbadmin2/vendor/datatables/jquery.dataTables.min.js"></script>
    <script src="/resources/sbadmin2/vendor/datatables/dataTables.bootstrap4.min.js"></script>

    <!-- Page level custom scripts -->
    <script src="/resources/sbadmin2/js/demo/datatables-demo.js"></script>

</body>

</html>

<script>
$(function() {
	
	id = <%=id%>;
	
	console.log("id >> ", id);
})

</script>
