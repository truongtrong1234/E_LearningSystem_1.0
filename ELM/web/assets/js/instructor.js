/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt 
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js 
 */

document.addEventListener('DOMContentLoaded', function() {
    // Chọn tất cả các link tab
    const tabLinks = document.querySelectorAll('.custom-tab-link');
    // Chọn tất cả các khối nội dung
    const contentBlocks = document.querySelectorAll('.tab-content-block');

    // Kiểm tra nếu có ?page=... trong URL
    const urlParams = new URLSearchParams(window.location.search);
    const pageParam = urlParams.get('page');

    // Ẩn tất cả các nội dung trước
    contentBlocks.forEach(block => {
        block.style.display = 'none';
    });

    // Nếu có page=(course/quiz/material), hiển thị đúng tab
    if (pageParam) {
        const activeContent = document.getElementById(`${pageParam}-content`);
        const activeTab = document.querySelector(`.custom-tab-link[data-tab="${pageParam}-content"]`);

        if (activeContent) {
            activeContent.style.display = 'block';
            if (activeTab) activeTab.classList.add('active');
            // Cuộn đến phần đó
            activeContent.scrollIntoView({ behavior: 'smooth' });
        }
    } else {
        // Nếu không có page, mặc định hiện tab đầu tiên
        if (contentBlocks.length > 0) contentBlocks[0].style.display = 'block';
        if (tabLinks.length > 0) tabLinks[0].classList.add('active');
    }

    // Giữ nguyên logic chuyển tab khi click
    tabLinks.forEach(link => {
        link.addEventListener('click', function(e) {
            e.preventDefault();

            // Lấy ID của khối nội dung cần hiển thị từ thuộc tính data-tab
            const targetId = this.getAttribute('data-tab');

            // Ẩn tất cả nội dung và loại bỏ trạng thái active của tab
            contentBlocks.forEach(block => {
                block.style.display = 'none';
            });
            tabLinks.forEach(tab => {
                tab.classList.remove('active');
            });

            // Hiển thị khối nội dung mục tiêu và kích hoạt tab hiện tại
            const targetContent = document.getElementById(targetId);
            if (targetContent) {
                targetContent.style.display = 'block';
                targetContent.scrollIntoView({ behavior: 'smooth' });
            }
            this.classList.add('active');
        });
    });
});
