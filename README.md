# LHMap 小店

依赖 **GitHub** 的静态卖货网站，可部署在 [GitHub Pages](https://pages.github.com/) 上。纯 HTML/CSS/JS，无后端；购物车用浏览器本地存储，结算时复制订单信息后通过微信/邮件等方式发给我们即可。

## 结构

- **首页** `index.html`：店铺介绍 + 精选推荐
- **商品** `products.html`：全部商品列表
- **商品详情** `product.html?id=1`：单商品页，可加入购物车
- **购物车** `cart.html`：查看/修改数量/删除
- **结算** `checkout.html`：填写收货信息，提交后复制订单信息
- **关于** `about.html`：关于我们
- **商品数据** `js/products.js`：可在此增删改商品
- **购物车逻辑** `js/store.js`：localStorage 读写

## 本地预览

在项目根目录用任意静态服务器打开，例如：

```bash
# Python 3
python3 -m http.server 8000

# 或 npx
npx serve .
```

浏览器访问 `http://localhost:8000`。

## 部署到 GitHub Pages

1. 将本仓库推送到你的 GitHub。
2. 仓库 **Settings → Pages**：
   - **Source** 选 **Deploy from a branch**。
   - **Branch** 选 `master`（或 `main`），目录选 **/ (root)**。
3. 保存后等待几分钟，站点地址为 `https://<用户名>.github.io/<仓库名>/`（例如 `https://fightinglh.github.io/LHMap/`）。

## 新增/修改商品

在 `js/products.js` 里编辑 `window.PRODUCTS` 数组，每项包含：`id`、`name`、`price`、`desc`、`category`。保存后刷新商品页即可。

## 许可

可自由修改与使用。
