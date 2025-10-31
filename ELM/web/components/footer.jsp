  
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<footer class="footer">
            <div class="footer-container">
                <!-- Logo + mô tả -->
                <div class="footer-about">
                    <div class="footer-logo">
                        <div class="logo-icon">E</div>
                        <span class="logo-text">E Learning</span>
                    </div>
                    <p>
                        Nền tảng học tập trực tuyến hàng đầu Việt Nam,
                        giúp bạn phát triển kỹ năng và thăng tiến trong sự nghiệp.
                    </p>
                    <div class="footer-socials">
                        <a href="#"><i class="bi bi-facebook"></i></a>
                        <a href="#"><i class="bi bi-twitter"></i></a>
                        <a href="#"><i class="bi bi-youtube"></i></a>
                        <a href="#"><i class="bi bi-linkedin"></i></a>
                    </div>
                </div>

                <!-- Liên kết nhanh -->
                <div class="footer-links">
                    <h4>LIÊN KẾT NHANH</h4>
                    <ul>
                        <li><a href="${pageContext.request.contextPath}/home_Guest">Trang chủ</a></li>
                        <li><a href="#">Khóa học</a></li>
                        <li><a href="#">Bài viết</a></li>
                        <li><a href="#">Về chúng tôi</a></li>
                        <li><a href="#">Liên hệ</a></li>
                    </ul>
                </div>

                <!-- Hỗ trợ -->
                <div class="footer-support">
                    <h4>HỖ TRỢ</h4>
                    <ul>
                        <li><a href="#">Trung tâm trợ giúp</a></li>
                        <li><a href="#">FAQ</a></li>
                        <li><a href="#">Điều khoản sử dụng</a></li>
                        <li><a href="#">Chính sách bảo mật</a></li>
                    </ul>
                </div>
            </div>

            <div class="footer-bottom">
                <p>© 2025 E Learning. Tất cả quyền được bảo lưu.</p>
                <p>Được phát triển với <span class="heart">❤</span> tại Việt Nam</p>
            </div>
        </footer>