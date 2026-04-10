#import "../lib.typ": *

#show: cn-resume.with(
  size: 10pt,
  accent-color: default-accent-color,
  header-center: true,
)[
  = 李明

  #info(
    color: default-accent-color,
    (icon: fa-phone, content: "(+86) 133-3333-3333"),
    (icon: fa-building-columns, content: "北京大学"),
    (icon: fa-graduation-cap, content: "计算机科学与技术"),
    (
      icon: fa-envelope,
      content: "liming@example.com",
      link: "mailto:liming@example.com",
    ),
    (
      icon: fa-github,
      content: "github.com/liming-dev",
      link: "https://github.com/liming-dev",
    ),
  )
][
  #h(2em)

  计算机专业学生，专注于全栈开发和云计算技术。具有扎实的编程基础，热衷于开源项目贡献。
]


== #fa-graduation-cap 教育背景

#sidebar(with-line: true, side-width: 12%)[
  2024.06

  2020.09
][
  *北京大学* · 信息科学技术学院 · 计算机科学与技术

  GPA: 3.8 / 4.0 · Rank: 5%
]


== #fa-wrench 专业技能

#sidebar(with-line: false, side-width: 12%)[
  *操作系统*

  *掌握*

  *熟悉*

  *了解*
][
  #fa-linux Linux, #h(0.5em) #fa-windows Windows

  React, JavaScript, Python

  Vue, TypeScript, Node.js

  Webpack, Java
]


== #fa-award 获奖情况

#item(
  [*互联网+ 大学生创新创业大赛*],
  [*省级金奖*],
  date[2022 年 10 月],
)

#item(
  [*ACM-ICPC 区域赛*],
  [*铜奖*],
  date[2021 年 12 月],
)


== #fa-code 项目经历

#item(
  link("https://github.com/liming-dev/cloud-platform", [*轻量级容器云平台*]),
  [*实验室项目*],
  date[2022 年 03 月 – 2022 年 12 月],
)

#tech[Golang, Docker, Kubernetes]

基于 Kubernetes 的容器管理平台，提供 Web 界面的容器编排服务

- 设计实现了基于 RBAC 的多租户权限管理系统
- 开发了容器资源动态伸缩和负载均衡模块
- 使用 Prometheus 和 Grafana 构建监控告警系统


== #fa-building-columns 校园经历

#item(
  [*计算机学院学生科创中心主席*],
  [],
  date[2022 年 09 月 – 2023 年 06 月],
)
