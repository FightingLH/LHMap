/** 登录状态：localStorage 键名（静态站无后端，仅前端演示） */
var AUTH_KEY = 'lhmap_user';

/** 获取当前登录用户，无则返回 null */
function getLoginUser() {
  try {
    var raw = localStorage.getItem(AUTH_KEY);
    return raw ? JSON.parse(raw) : null;
  } catch (e) {
    return null;
  }
}

/** 保存登录用户 { name: string } */
function setLoginUser(user) {
  localStorage.setItem(AUTH_KEY, JSON.stringify(user));
}

/** 退出登录 */
function clearLoginUser() {
  localStorage.removeItem(AUTH_KEY);
}

/** 更新页面上登录/退出区域的显示 */
function updateLoginUI() {
  var user = getLoginUser();
  var loginArea = document.getElementById('loginArea');
  var logoutArea = document.getElementById('logoutArea');
  var welcomeUser = document.getElementById('welcomeUser');
  var logoutBtn = document.getElementById('logoutBtn');
  if (!loginArea || !logoutArea) return;
  if (user && user.name) {
    loginArea.style.display = 'none';
    logoutArea.style.display = 'inline';
    if (welcomeUser) welcomeUser.textContent = '欢迎，' + user.name;
    if (logoutBtn) {
      logoutBtn.onclick = function (e) {
        e.preventDefault();
        clearLoginUser();
        updateLoginUI();
        if (window.location.pathname.indexOf('login.html') === -1) {
          window.location.reload();
        } else {
          window.location.href = 'index.html';
        }
      };
    }
  } else {
    loginArea.style.display = 'inline';
    logoutArea.style.display = 'none';
  }
}
