'''
 # @ Author: Yixiang Zhang
 # @ Create Time: 2022-08-13 15:09:45
 # @ Modified by: Yixiang Zhang
 # @ Modified time: 2022-08-13 15:10:04
 # @ Description:
 Studying the tutorial1 from the following link.
 https://www.youtube.com/watch?v=ZZ4B0QUHuNc&list=PLtqF5YXg7GLmCvTswG32NqQypOuYkPRUE
 '''


import pandas as pd
import streamlit as st
import yfinance as yf


# streamlit.write() uses markdown flavor
st.write("""
# Simple Stock Price App

Shown are the stock **closing price** and **volume** of Google!         
         
""")

# choose the symbol for the stock
tickerSymbol = "GOOGL"

# getting data from yfinance library
tickerData = yf.Ticker(tickerSymbol)

# 
tickerDf = tickerData.history(period = "1d",
                              start = "2010-5-31",
                              end = "2020-5-31",)


# line chart for closing price and volume
st.line_chart(tickerDf.Close)
st.line_chart(tickerDf.Volume)
