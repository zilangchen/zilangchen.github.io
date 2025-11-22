# 开发记录

本文档记录了项目的开发和修改历史。

## <Cursor-AI 2025-11-23 03:47:05>

### 修改目的

创建项目开发记录文件，用于追踪后续的所有代码修改和功能开发。

### 修改内容摘要

- 创建 `development_record.md` 文件
- 创建 `objective.md` 文件
- 对仓库进行首次全面分析

### 影响范围

无代码修改，仅为文档创建

### 技术细节

- 按照用户规范要求创建开发记录文档
- 记录项目初始状态分析

## <Cursor-AI 2025-11-23 04:16:30>

### 修改目的

同步最新文件更改到 GitHub 仓库

### 修改内容摘要

- 初始化 Git 仓库并配置远程仓库
- 添加所有文件更改到暂存区
- 创建提交记录（commit d797d3e）
- 添加开发记录和目标文档到仓库
- 添加研究论文 PDF 文件
- 更新简历文件
- 重命名项目文档为英文名称
- 清理旧版修改文件

### 影响范围

- 10 个文件更改
- 新增 6 个文件
- 重命名 3 个文件
- 删除 1 个文件

### 技术细节

- Git 提交已成功创建（d797d3e）
- 提交信息：docs: 更新项目文档和文件整理
- 推送时遇到网络连接问题，需要后续处理

## <Cursor-AI 2025-11-23 04:19:50>

### 修改目的

根据最新的"陈梓浪CV 1118.docx"文件更新网站CV部分

### 修改内容摘要

- 读取Word文档内容，提取完整的CV信息
- 更新 `_pages/cv.md` - CV页面，包含所有研究经历、技能、获奖等详细信息
- 更新 `_pages/about.md` - 主页信息，同步CV内容
- 更新 `_config.yml` - 配置文件中的邮箱地址（zilangchen2026@163.com）
- 添加CMU Research Workshop信息
- 更新研究经历描述，包括：
  - 机器人臂运动控制项目更详细的描述
  - 软体机器人项目更新为"Real-Time Camera-Free Deformation Reconstruction"，添加ICRA 2026投稿状态
  - 智能家居终端项目更详细的描述
  - 葡萄酒质量预测项目添加IPMLP 2025接受信息和DOI
  - 集球机器人项目更详细的描述
- 更新出版物信息，包括DOI和审稿状态
- 更新技能分类为更详细的结构
- 更新获奖信息的时间和格式

### 影响范围

- `_pages/cv.md` - CV页面完全更新
- `_pages/about.md` - 主页CV部分同步更新
- `_config.yml` - 作者邮箱地址更新

### 技术细节

- 使用python-docx库读取Word文档内容
- 提取CV的各个部分：教育、研究经历、技能、获奖、出版物等
- 将Word格式转换为Markdown格式
- 保持网站格式一致性，确保所有CV信息同步更新

## <Cursor-AI 2025-11-23 04:23:27>

### 修改目的

保留两个邮箱：私人邮箱用于日常联系，学术邮箱用于申请

### 修改内容摘要

- 更新 `_pages/cv.md` - 添加Contact部分，同时展示两个邮箱并标注用途
- 更新 `_pages/about.md` - 更新联系信息，同时展示两个邮箱
- 更新 `_config.yml` - 将主要邮箱设置回私人邮箱（zilang.chen@outlook.com）

### 影响范围

- `_pages/cv.md` - 添加了Contact部分
- `_pages/about.md` - 更新联系信息
- `_config.yml` - 更新主要邮箱设置

### 技术细节

- 在CV和about页面同时展示两个邮箱：zilang.chen@outlook.com (Personal) 和 zilangchen2026@163.com (Academic Applications)
- 配置文件中的email字段保留私人邮箱作为主要联系方式
- 确保两个邮箱都在页面中可见，方便不同用途的联系

## <Cursor-AI 2025-11-23 04:30:33>

### 修改目的

根据PDF文章内容更新portfolio中关于soft_robot的项目，并重新命名以反映真实内容

### 修改内容摘要

- 读取PDF文件内容（Real_Time_Camera_Free_Deformation_Reconstruction_via_Flexible_Sensor_Array_and_Cage_based_deformation_mode.pdf）
- 创建新的portfolio文件：`2025-07-15-deformation-reconstruction.html`
- 删除旧的portfolio文件：`2025-07-15-soft-robot-fault-detection.html`
- 重命名图片文件夹：从 `images/portfolio/soft-robot` 到 `images/portfolio/deformation-reconstruction`
- 重命名图片文件：`inference (1).png` 到 `inference.png`（去除空格）
- 更新portfolio内容，包括：
  - 项目标题和描述
  - 技术方法详细介绍（传感器设计、4D Gaussian Splatting、Cage-based变形框架）
  - 性能结果（30 FPS实时渲染，<5%位移误差，<4.7°角度误差）
  - 关键创新点
  - 应用场景
  - 发表状态（ICRA 2026投稿中）
- 添加PDF文件链接到files目录
- 更新图片路径和gallery配置

### 影响范围

- `_portfolio/2025-07-15-deformation-reconstruction.html` - 新建portfolio页面
- `_portfolio/2025-07-15-soft-robot-fault-detection.html` - 删除旧文件
- `images/portfolio/deformation-reconstruction/` - 重命名文件夹，包含5张图片
- `files/Real_Time_Camera_Free_Deformation_Reconstruction_via_Flexible_Sensor_Array_and_Cage_based_deformation_mode.pdf` - 添加PDF文件

### 技术细节

- 使用python-docx和pdfplumber库读取PDF内容
- 根据PDF摘要和CV信息创建完整的portfolio描述
- 项目重命名为"deformation-reconstruction"以更准确地反映项目内容（Real-Time Camera-Free Deformation Reconstruction）
- 更新所有图片路径，确保与新的文件夹名称匹配
- Portfolio包含详细的技术方法、性能指标、创新点和应用场景

## <Cursor-AI 2025-11-23 04:32:29>

### 修改目的

更新首页和publications页面内容，使其反映最新的论文信息和状态

### 修改内容摘要

- 更新 `_publications/2025-06-15-wine-quality-ensemble.md`：
  - 从preprint类别改为conferences类别（已接受IPMLP 2025）
  - 更新venue为"ACM IPMLP 2025"
  - 更新paperurl为DOI链接
  - 更新citation信息，包含DOI
  - 更新标题为完整标题"A Unified, Leak-Free Comparative Study"
- 创建新的publication条目 `_publications/2026-05-31-deformation-reconstruction.md`：
  - ICRA 2026论文（审稿中）
  - 包含完整的摘要、贡献、性能结果和应用场景
  - 链接到PDF文件
  - 作者信息：Shou, L.; Chen, Z.; Xu, W.; Luo, Y.; Cheng, T.
- 更新 `_pages/about.md`：
  - 优化Profile部分，添加更详细的研究兴趣描述
  - 明确说明专业名称：Intelligent Manufacturing Engineering
  - 添加具体研究方向的描述

### 影响范围

- `_publications/2025-06-15-wine-quality-ensemble.md` - 更新论文状态和信息
- `_publications/2026-05-31-deformation-reconstruction.md` - 新建论文条目
- `_pages/about.md` - 优化首页Profile部分

### 技术细节

- Wine Quality论文已从preprint更新为conference paper（category: conferences）
- 新添加的ICRA 2026论文使用conferences类别，状态为Under Review
- Publications页面会自动显示这两个论文条目，按类别分组
- 首页Publications部分显示手动添加的引用格式，与publications页面自动生成的列表互补

## <Cursor-AI 2025-11-23 04:33:59>

### 修改目的

提交所有更新到GitHub仓库

### 修改内容摘要

- 提交所有更改到Git仓库（commit fe8ecad）
- 推送到GitHub成功

### 影响范围

- 17个文件更改
- 407行新增，83行删除
- 包含CV更新、Portfolio更新、Publications更新、图片文件等

### 技术细节

- Git提交信息：feat: 更新CV、Portfolio和Publications内容
- 提交ID：fe8ecad
- 推送状态：成功推送到 origin/master
- 提交包含：
  - CV和About页面更新
  - Portfolio项目重命名和更新
  - Publications论文状态更新和新论文添加
  - PDF文件和图片资源
  - 开发记录更新
