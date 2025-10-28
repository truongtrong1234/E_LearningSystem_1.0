<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%
    model.Account account = (model.Account) session.getAttribute("account");
    String avatarUrl = null;
    String initial = "U";
    if (account != null) {
        avatarUrl = account.getPicture();
        String name = account.getName();
        if (name != null && !name.isEmpty()) {
            initial = name.substring(0,1).toUpperCase();
        }
    }
%>

<header class="header">
    <a class="logo" href="${pageContext.request.contextPath}/home_learner.jsp">
        <span class="s">Secret</span><span class="c">Coder</span>
    </a>

    <div class="search-bar">
        <i class="bi bi-search"></i>
        <input type="text" placeholder="Search for anything">
        <button title="Search"><i class="bi bi-arrow-return-left"></i></button>
    </div>

    <nav class="nav-links">
        <a href="${pageContext.request.contextPath}/course">Instructor</a>
    </nav>
    <nav class="nav-links">
        <a href="${pageContext.request.contextPath}/myLearning">My Learning</a>
    </nav>

    <div class="header-icons">
        <button class="icon-btn" title="Wishlist"><i class="bi bi-heart"></i></button>
        <button class="icon-btn" title="Cart"><i class="bi bi-cart3"></i></button>
        <button class="icon-btn" title="Notifications"><i class="bi bi-bell"></i></button>

   <a href="${pageContext.request.contextPath}/myProfile.jsp" class="avatar" title="Profile">
    <c:choose>
        <c:when test="${not empty sessionScope.account.picture}">
            <img src="${sessionScope.account.picture}" alt="avatar" class="avatar-img"/>
        </c:when>
        <c:otherwise>
            ${fn:substring(sessionScope.account.name,0,1)} <!-- ký tự đầu tên -->
        </c:otherwise>
    </c:choose>
</a>

    </div>
</header>

