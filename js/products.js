/** 商品数据（可在本文件内增删改） */
window.PRODUCTS = [
  { id: '1', name: '经典 T 恤', price: 89, desc: '纯棉短袖，多色可选', category: '服饰' },
  { id: '2', name: '帆布双肩包', price: 159, desc: '大容量通勤背包', category: '包袋' },
  { id: '3', name: '无线耳机', price: 299, desc: '降噪蓝牙 5.0', category: '数码' },
  { id: '4', name: '保温杯 500ml', price: 79, desc: '不锈钢内胆，保冷保热', category: '生活' },
  { id: '5', name: '机械键盘', price: 399, desc: '青轴，RGB 背光', category: '数码' },
  { id: '6', name: '运动跑鞋', price: 429, desc: '轻量透气，缓震鞋底', category: '服饰' },
];

function getProductById(id) {
  return window.PRODUCTS.find(function (p) { return p.id === id; });
}

/**
 * 商品图片：按商品 id 固定“随机图”
 * 使用 picsum.photos 的 seed 机制，保证每个商品图片稳定，不会每次刷新都变
 */
function getProductImageUrl(id, size) {
  var s = size == null ? 600 : Math.max(100, parseInt(size, 10) || 600);
  var seed = 'lhmap-' + encodeURIComponent(String(id || 'unknown'));
  return 'https://picsum.photos/seed/' + seed + '/' + s + '/' + s;
}

window.getProductImageUrl = getProductImageUrl;
