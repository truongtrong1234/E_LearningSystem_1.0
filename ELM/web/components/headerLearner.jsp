<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!-- HEADER -->
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

    <div class="header-icons">
        <button class="icon-btn" title="Wishlist"><i class="bi bi-heart"></i></button>
        <button class="icon-btn" title="Cart"><i class="bi bi-cart3"></i></button>
        <button class="icon-btn" title="Notifications"><i class="bi bi-bell"></i></button>
        <a href="${pageContext.request.contextPath}/myProfile.jsp" class="avatar" title="Profile">U</a>
    </div>
</header>
