# SampleCode

SDIMageAdd :

目的：优化切圆角的性能问题

解决方案：CoreGraphic画圆角图片，覆盖在需要切圆角的图片上。同时将圆角图片保存，相同尺寸，相同圆角半径 需求的图片，可以直接从缓存获取。


代码注释：提供了一个UIImage的分类，分类里提供了画圆角图片的方法。 缓存策略使用YYCache缓存（内存，磁盘）。
         最初考虑到使用SDWebCahce缓存，与项目同步，但是，将圆角图片保存后，再读取 ，有异常。 猜测应该是sd做了一些处理。 后期可以查看代码。
         
