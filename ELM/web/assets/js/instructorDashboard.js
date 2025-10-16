/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

document.addEventListener('DOMContentLoaded', function() {
    // 1. Chọn tất cả các link tab
    const tabLinks = document.querySelectorAll('.custom-tab-link');
    
    // 2. Chọn tất cả các khối nội dung
    const contentBlocks = document.querySelectorAll('.tab-content-block');

    tabLinks.forEach(link => {
        link.addEventListener('click', function(e) {
            e.preventDefault();
            
            // Lấy ID của khối nội dung cần hiển thị từ thuộc tính data-tab
            const targetId = this.getAttribute('data-tab'); 

            // BƯỚC 1: Ẩn tất cả nội dung và loại bỏ trạng thái active của tab
            contentBlocks.forEach(block => {
                block.style.display = 'none'; 
            });
            tabLinks.forEach(tab => {
                tab.classList.remove('active'); 
            });

            // BƯỚC 2: Hiển thị khối nội dung mục tiêu và kích hoạt tab hiện tại
            const targetContent = document.getElementById(targetId);
            if (targetContent) {
                targetContent.style.display = 'block'; 
            }
            this.classList.add('active'); 
        });
    });
});