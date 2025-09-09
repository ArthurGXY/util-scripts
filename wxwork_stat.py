#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
计算「标准工作时长总和 - 实际工作时长总和」，剔除请假天。
支持命令行参数 -f/--file 指定 Excel 文件。
"""

import argparse
import pandas as pd

# 默认文件名
DEFAULT_FILE = "上下班打卡_日报_20250701-20250723.xlsx"
SHEET_NAME = "概况统计与打卡明细"

def parse_args():
    parser = argparse.ArgumentParser(description="统计打卡时长差值（剔除请假天）")
    parser.add_argument(
        "-f", "--file",
        type=str,
        default=DEFAULT_FILE,
        help=f"Excel 文件路径（默认：{DEFAULT_FILE}）"
    )
    return parser.parse_args()

def main(file_path: str):
    # 1. 读 Excel（跳过前三行合并表头）
    df = pd.read_excel(file_path, sheet_name=SHEET_NAME, header=3)

    # 2. 列索引
    COL_STD   = 11   # L 列 —— 标准工作时长(小时)
    COL_ACT   = 12   # M 列 —— 实际工作时长(小时)
    COL_LEAVE = 13   # N 列 —— 假勤申请

    # 3. 过滤请假行
    leave_col = df.iloc[:, COL_LEAVE].astype(str).str.strip()
    mask = leave_col.isin(["nan", "NaN", "None", "--", ""])
    df_filtered = df.loc[mask, :]

    # 4. 数值转换
    sum_std = pd.to_numeric(df_filtered.iloc[:, COL_STD], errors='coerce').sum()
    sum_act = pd.to_numeric(df_filtered.iloc[:, COL_ACT], errors='coerce').sum()
    diff = sum_std - sum_act

    # 5. 输出
    print(f"文件输入：{file_path}")
    print(f"标准工作时长总和: {sum_std:.2f} 小时")
    print(f"实际工作时长总和: {sum_act:.2f} 小时")
    print(f"标准 - (实际 + 假勤): {diff:.2f} 小时")

if __name__ == "__main__":
    args = parse_args()
    main(args.file)
