# 抽签游戏 (Draw Lots Game)

## 功能描述

抽签游戏是一个基于概率的简单游戏，玩家每天有一次抽签机会，可以抽到"Lucky"或"Unlucky"两种结果。

## 游戏特性

### 🎯 核心功能
- **每日抽签**: 每天限制1次抽签机会
- **概率系统**: Lucky 80% 概率，Unlucky 20% 概率
- **动画效果**: 抽签筒摇晃动画，结果渐显动画
- **视觉反馈**: 抽签后显示抽签棒，结果概率显示

### 🎨 界面设计
- **渐变背景**: 浅蓝色到白色的渐变背景
- **抽签筒**: 红色圆柱形抽签筒，带有阴影效果
- **动画**: 抽签时的摇晃动画和结果显示动画
- **响应式**: 适配不同屏幕尺寸

### 🔧 技术实现
- **状态管理**: 使用GetX进行状态管理
- **动画**: 使用AnimatedContainer和AnimatedOpacity
- **响应式设计**: 使用flutter_screenutil适配屏幕
- **概率算法**: 基于Random类的概率计算

## 使用方法

1. **开始抽签**: 点击"Start"按钮开始抽签
2. **观看动画**: 抽签筒会进行摇晃动画
3. **查看结果**: 显示抽签结果和对应概率
4. **重置游戏**: 点击"Reset"按钮重新开始

## 文件结构

```
lib/pages/game_mix_draw_lots/
├── game_mix_draw_lots_view.dart    # 视图文件
├── game_mix_draw_lots_logic.dart   # 逻辑控制器
└── game_mix_draw_lots_binding.dart # 依赖注入绑定
```

## 状态变量

- `drawResult`: 抽签结果 (Lucky/Unlucky)
- `remainingTimes`: 剩余抽签次数
- `isDrawing`: 是否正在抽签
- `drawTubeState`: 抽签筒状态
- `animationValue`: 动画值
- `showResult`: 是否显示结果

## 主要方法

- `startDraw()`: 开始抽签
- `_performDraw()`: 执行抽签逻辑
- `resetGame()`: 重置游戏
- `_resetDailyDraws()`: 重置每日抽签次数

## 设计图对应

根据设计图实现了以下元素：
- ✅ 标题 "抽签游戏"
- ✅ 两个红色抽签筒
- ✅ 剩余次数显示
- ✅ 抽签结果显示 (Lucky 80%)
- ✅ 开始按钮
- ✅ 渐变背景
- ✅ 底部导航栏

## 扩展功能

可以考虑添加的功能：
- 抽签历史记录
- 多种抽签类型
- 自定义概率设置
- 抽签音效
- 分享功能
