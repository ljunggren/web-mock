<html>
<body>
<!-- XHTML or JSP -->
<%String aid = request.getParameter("aid"); %>
<% if (aid == null | aid == "") { %>
    <div class="error">Request param aid missing</div>
<% } else { %>
  <aid><%=aid%></aid>
  <%@ include file="getPhone.xml" %>
<% } %>
</body>
</html>