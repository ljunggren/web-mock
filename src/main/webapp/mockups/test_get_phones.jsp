<html>
<body>
<!-- XHTML or JSP -->
<%String lid = request.getParameter("lid"); %>
<% if (lid == null | lid == "") { %>
    <div class="error">Request param lid missing</div>
<% } else { %>
  <lid><%=lid%></lid>
  <%@ include file="getPhones.xml" %>
<% } %>
</body>
</html>