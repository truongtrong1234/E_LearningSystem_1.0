<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
    String ctx = request.getContextPath();
%>

<header class="header">
    <a class="logo" href="<%=ctx%>/home_Guest">
        <span class="s">Secret</span><span class="c">Coder</span>
    </a>

    <div class="search-bar">
      <form action="${pageContext.request.contextPath}/searchCourse" method="get">
        <i class="fa fa-search search-icon"></i>
        <input type="text" name="keyword" placeholder="Search for anything" value="${param.keyword}">
        <!-- Ẩn category nếu người dùng đã click filter trước đó -->
    <c:if test="${not empty param.cats}">
        <input type="hidden" name="cats" value="${param.cats}">
    </c:if>
        <button type="submit"><i class="bi bi-arrow-return-left"></i></button>
      </form>
    </div>

    <nav class="nav-links">
        <a href="<%=ctx%>/login.jsp">Login</a>
        <a href="<%=ctx%>/register.jsp">Register</a>
    </nav>
</header>
