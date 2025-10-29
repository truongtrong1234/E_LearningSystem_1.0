<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<header class="main-header">
  <div class="header-container">

    <a class="logo" href="${pageContext.request.contextPath}/home_learner.jsp">
      <span class="s">Secret</span><span class="c">Coder</span>
    </a>

    <div class="search-bar">
      <form action="${pageContext.request.contextPath}/searchCourse" method="get">
        <i class="fa fa-search search-icon"></i>
        <input type="text" name="keyword" placeholder="Search for anything" value="${param.keyword}">
        <button type="submit"><i class="bi bi-arrow-return-left"></i></button>
      </form>
    </div>

    <nav class="nav-links">
      <a href="${pageContext.request.contextPath}/course">Instructor</a>
      <a href="${pageContext.request.contextPath}/myLearning">My Learning</a>
    </nav>

    <div class="header-icons">
      <button class="icon-btn"><i class="bi bi-heart"></i></button>
      <button class="icon-btn"><i class="bi bi-cart3"></i></button>
      <button class="icon-btn"><i class="bi bi-bell"></i></button>

      <a href="${pageContext.request.contextPath}/myProfile.jsp" class="avatar">
        <c:choose>
          <c:when test="${not empty sessionScope.account.picture}">
            <img src="${sessionScope.account.picture}" alt="avatar" class="avatar-img"/>
          </c:when>
          <c:otherwise>${fn:substring(sessionScope.account.name,0,1)}</c:otherwise>
        </c:choose>
      </a>
    </div>
  </div>
</header>


