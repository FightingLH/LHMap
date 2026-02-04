/** 购物车：localStorage 键名 */
var CART_KEY = 'lhmap_cart';

/** 读取购物车 [{ id, qty }, ...] */
function getCart() {
  try {
    var raw = localStorage.getItem(CART_KEY);
    return raw ? JSON.parse(raw) : [];
  } catch (e) {
    return [];
  }
}

/** 写入购物车 */
function setCart(items) {
  localStorage.setItem(CART_KEY, JSON.stringify(items));
}

/** 加一件到购物车（已存在则数量 +1） */
function addToCart(productId, qty) {
  qty = qty == null ? 1 : Math.max(1, parseInt(qty, 10) || 1);
  var cart = getCart();
  var i = cart.findIndex(function (x) { return x.id === productId; });
  if (i >= 0) cart[i].qty += qty;
  else cart.push({ id: productId, qty: qty });
  setCart(cart);
}

/** 设置某商品数量（0 则移除） */
function setCartQty(productId, qty) {
  qty = parseInt(qty, 10) || 0;
  var cart = getCart().filter(function (x) { return x.id !== productId; });
  if (qty > 0) cart.push({ id: productId, qty: qty });
  setCart(cart);
}

/** 从购物车移除 */
function removeFromCart(productId) {
  setCart(getCart().filter(function (x) { return x.id !== productId; }));
}

/** 购物车总件数 */
function getCartCount() {
  return getCart().reduce(function (sum, x) { return sum + x.qty; }, 0);
}

/** 更新页面上所有 .js-cart-count 的显示 */
function updateCartCount() {
  var n = getCartCount();
  [].forEach.call(document.querySelectorAll('.js-cart-count'), function (el) {
    el.textContent = n;
  });
}
