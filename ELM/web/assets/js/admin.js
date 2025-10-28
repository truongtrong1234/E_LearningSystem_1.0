document.addEventListener('DOMContentLoaded', function() {
  // delete account
  document.querySelectorAll('.btn-delete-account').forEach(btn => {
    btn.addEventListener('click', function() {
      const id = this.dataset.id;
      if (!confirm('Xoá tài khoản #' + id + ' ?')) return;
      fetch(window.location.pathname + '?', {
        method: 'POST',
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: new URLSearchParams({ action: 'deleteAccount', id })
      }).then(r => r.text()).then(txt => {
        if (txt === 'ok') {
          const row = document.getElementById('user-row-' + id);
          if (row) row.remove();
        } else alert('Lỗi khi xoá');
      });
    });
  });

  // delete course
  document.querySelectorAll('.btn-delete-course').forEach(btn => {
    btn.addEventListener('click', function() {
      const id = this.dataset.id;
      if (!confirm('Xoá course #' + id + ' ?')) return;
      fetch(window.location.pathname + '?', {
        method: 'POST',
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: new URLSearchParams({ action: 'deleteCourse', id })
      }).then(r => r.text()).then(txt => {
        if (txt === 'ok') {
          const row = document.getElementById('course-row-' + id);
          if (row) row.remove();
        } else alert('Lỗi khi xoá course');
      });
    });
  });

  // delete report
  document.querySelectorAll('.btn-delete-report').forEach(btn => {
    btn.addEventListener('click', function() {
      const id = this.dataset.id;
      if (!confirm('Xoá report #' + id + ' ?')) return;
      fetch(window.location.pathname + '?', {
        method: 'POST',
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: new URLSearchParams({ action: 'deleteReport', id })
      }).then(r => r.text()).then(txt => {
        if (txt === 'ok') {
          const row = document.getElementById('report-row-' + id);
          if (row) row.remove();
        } else alert('Lỗi khi xoá report');
      });
    });
  });

});
