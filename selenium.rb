require "selenium-webdriver"

Selenium::WebDriver::Firefox::Service.driver_path = "./geckodriver"

url = "https://en.wikipedia.org/wiki/ASCII"
driver = Selenium::WebDriver.for :firefox
wait = Selenium::WebDriver::Wait.new({timeout: 10})

driver.navigate.to url

elements = wait.until{ driver.find_elements({css: ".mw-parser-output p"}) }
text = ""
elements.each{|e| text += e.text}
File.open("./text.txt", "w"){|w| w.syswrite text}