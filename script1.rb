require "selenium-webdriver"
require "json"

Selenium::WebDriver::Firefox::Service.driver_path = "./geckodriver"

urls = [
	"https://www.ted.com/talks/helen_czerski_the_fascinating_physics_of_everyday_life/transcript?language=pt-br#t-81674",
	"https://www.ted.com/talks/kevin_kelly_how_ai_can_bring_on_a_second_industrial_revolution/transcript?language=pt-br",
	"https://www.ted.com/talks/sarah_parcak_help_discover_ancient_ruins_before_it_s_too_late/transcript?language=pt-br",
	"https://www.ted.com/talks/sylvain_duranton_how_humans_and_ai_can_work_together_to_create_better_businesses/transcript?language=pt-br",
	"https://www.ted.com/talks/chieko_asakawa_how_new_technology_helps_blind_people_explore_the_world/transcript?language=pt-br",
	"https://www.ted.com/talks/pierre_barreau_how_ai_could_compose_a_personalized_soundtrack_to_your_life/transcript?language=pt-br",
	"https://www.ted.com/talks/tom_gruber_how_ai_can_enhance_our_memory_work_and_social_lives/transcript?language=pt-br"
]
wait = Selenium::WebDriver::Wait.new({timeout: 10})
driver = Selenium::WebDriver.for :firefox


urls.size.times do |i|
	driver.navigate.to urls[i]

	obj = {
		author: "",
		body: wait.until{ driver.find_elements({css: "#content [dir = 'ltr']"}) }
		.map{|e| e.text.to_s}.join("\n"),
		title: "",
		type: "video",
		url: driver.current_url
	}

	File.open("doc#{i + 1}.json", "w"){|w| w.syswrite JSON.generate obj }
end