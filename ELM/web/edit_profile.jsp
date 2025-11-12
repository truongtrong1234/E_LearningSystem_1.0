<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
    <head>
        <title>Edit Profile </title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/headerLearner.css?v3">
        <style>
            :root {
                --brand: #ff6600;
                --ink: #222;
                --bg: #f5f6f8;
                --card: #fff;
                --radius: 16px;
                --shadow: 0 8px 24px rgba(0,0,0,0.08);
            }

            * {
                box-sizing: border-box;
            }

            body {
                margin: 0;
                font-family: "Inter", "Segoe UI", Arial, sans-serif;
                background: var(--bg);
                color: var(--ink);
            }

            .navbar {
                background: var(--card);
                padding: 10px 24px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.05);
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .logo {
                font-weight: 800;
                font-size: 22px;
            }

            .logo .s {
                color: var(--brand);
            }
            .logo .c {
                color: var(--ink);
            }

            .sheet-wrap {
                min-height: calc(100vh - 60px);
                display: grid;
                place-items: center;
                padding: 32px;
            }

            .sheet {
                width: 460px;
                background: var(--card);
                border-radius: var(--radius);
                box-shadow: var(--shadow);
                padding: 32px;
            }

            h2 {
                text-align: center;
                margin-bottom: 24px;
                font-size: 22px;
            }

            label {
                display: block;
                margin: 12px 0 6px;
                font-weight: 600;
            }

            input[type="text"],
            input[type="date"],
            input[type="file"],
            select,
            textarea {
                width: 100%;
                padding: 10px 12px;
                border-radius: 8px;
                border: 1px solid #ccc;
                font-size: 14px;
                transition: all .2s ease;
            }

            input:focus,
            textarea:focus,
            select:focus {
                border-color: var(--brand);
                outline: none;
                box-shadow: 0 0 0 2px rgba(255,102,0,0.15);
            }

            textarea {
                resize: none;       /* ❌ Không cho kéo thay đổi kích thước */
                height: 42px;       /* ✅ Cố định giống input */
                line-height: 1.4;
            }

            .btn {
                width: 100%;
                padding: 12px 18px;
                margin-top: 22px;
                font-weight: 600;
                font-size: 15px;
                border-radius: 999px;
                border: none;
                background: var(--brand);
                color: #fff;
                cursor: pointer;
                transition: background .2s;
            }

            .btn:hover {
                background: #e65a00;
            }

            img.avatar-preview {
                width: 90px;
                height: 90px;
                border-radius: 50%;
                object-fit: cover;
                margin-top: 10px;
                border: 2px solid #eee;
                box-shadow: 0 3px 10px rgba(0,0,0,0.1);
            }

            .back-link {
                display: block;
                text-align: center;
                margin-top: 20px;
                color: var(--brand);
                font-weight: 600;
                text-decoration: none;
            }

            .back-link:hover {
                text-decoration: underline;
            }
        </style>
    </head>

    <body>
        <!-- HEADER -->
        <jsp:include page="/components/headerLearner.jsp" />

        <div class="sheet-wrap">
            <div class="sheet">
                <h2>Chỉnh sửa hồ sơ</h2>

                <form action="${pageContext.request.contextPath}/editProfile" method="post" enctype="multipart/form-data">
                    <label>Họ và tên:</label>
                    <input type="text" name="name" value="${account.name}" required>

                    <label>Giới tính:</label>
                    <select name="gender" required>
                        <option value="">-- Chọn giới tính --</option>
                        <option value="Nam" ${account.gender == 'Nam' ? 'selected' : ''}>Nam</option>
                        <option value="Nữ" ${account.gender == 'Nữ' ? 'selected' : ''}>Nữ</option>
                        <option value="Khác" ${account.gender == 'Khác' ? 'selected' : ''}>Khác</option>
                    </select>

                    <label>Ngày sinh:</label>
                    <input type="date" name="dateOfBirth" value="${account.dateOfBirth}">

                    <label>Số điện thoại:</label>
                    <input type="text" name="phone" value="${account.phone}">

                    <label>Địa chỉ:</label>
                    <textarea name="address">${account.address}</textarea>

                    <label>Nơi công tác:</label>
                    <input type="text" name="workplace" value="${account.workplace}">

                    <label>Ảnh đại diện:</label>
                    <input type="file" name="avatar">
                    <c:if test="${not empty account.picture}">
                        <img src="${account.picture}" alt="avatar" class="avatar-preview">
                    </c:if>

                    <button type="submit" class="btn">💾 Lưu thay đổi</button>
                </form>

                <a class="back-link" href="${pageContext.request.contextPath}/myProfile.jsp">← Quay lại hồ sơ</a>
            </div>
        </div>
    </body>
</html>
