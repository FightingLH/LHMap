/** 商品数据（可在本文件内增删改） */
/** 每个商品的 image 为固定图片地址（picsum 按 seed 固定），可替换为你自己的图 */
window.PRODUCTS = [
  { id: '1', name: '经典 T 恤', price: 89, desc: '纯棉短袖，多色可选', category: '服饰', image: 'https://picsum.photos/seed/lhmap-1/600/600' },
  { id: '2', name: '帆布双肩包', price: 159, desc: '大容量通勤背包', category: '包袋', image: 'https://picsum.photos/seed/lhmap-2/600/600' },
  { id: '3', name: '无线耳机', price: 299, desc: '降噪蓝牙 5.0', category: '数码', image: 'https://picsum.photos/seed/lhmap-3/600/600' },
  { id: '4', name: '保温杯 500ml', price: 79, desc: '不锈钢内胆，保冷保热', category: '生活', image: 'https://picsum.photos/seed/lhmap-4/600/600' },
  { id: '5', name: '机械键盘', price: 399, desc: '青轴，RGB 背光', category: '数码', image: 'https://picsum.photos/seed/lhmap-5/600/600' },
  { id: '6', name: '运动跑鞋', price: 429, desc: '轻量透气，缓震鞋底', category: '服饰', image: 'https://picsum.photos/seed/lhmap-6/600/600' },
];

function getProductById(id) {
  return window.PRODUCTS.find(function (p) { return p.id === id; });
}

/**
 * 商品图片：优先用商品自带的 image，否则按 id 生成 picsum 地址
 */
function getProductImageUrl(id, size) {
  var p = getProductById(id);
  if (p && p.image) return p.image;
  var s = size == null ? 600 : Math.max(100, parseInt(size, 10) || 600);
  var seed = 'lhmap-' + encodeURIComponent(String(id || 'unknown'));
  return 'https://picsum.photos/seed/' + seed + '/' + s + '/' + s;
}

window.getProductImageUrl = getProductImageUrl;
