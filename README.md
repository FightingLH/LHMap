# LHMap 博客

依赖 **GitHub** 的多页面静态博客，可部署在 [GitHub Pages](https://pages.github.com/) 上。

## 结构

- **首页** `index.html`：文章列表
- **归档** `archive.html`：按时间归档
- **关于** `about.html`：关于本站
- **文章** `posts/*.html`：单篇文章页面

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

## 新增文章

1. 在 `posts/` 下新建 HTML 文件（可复制 `posts/post-1.html` 改内容）。
2. 在 `index.html` 的 `<ul class="post-list">` 里增加一条链接。
3. 在 `archive.html` 对应月份下增加一条链接。

## 许可

可自由修改与使用。
