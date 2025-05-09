package jp.co.hoge.controller;

import java.util.List;

import jakarta.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import jp.co.hoge.dto.EventDTO;
import jp.co.hoge.service.EventService;

@Controller
public class HomeController {

	@Autowired
	private EventService eventService;

	@Autowired
	private ObjectMapper objectMapper; // JacksonのObjectMapperを使用

	// ホーム画面表示
	@GetMapping("/home")
	public String showHomePage(HttpSession session, Model model) throws JsonProcessingException {
		String username = (String) session.getAttribute("username");
		if (username == null) {
			return "redirect:/login";
		}

		List<EventDTO> events = eventService.getAllEvents();

		String eventsJson = objectMapper.writeValueAsString(events)
				.replace("\r", "")
				.replace("\n", "\\n");

		model.addAttribute("username", username);
		model.addAttribute("eventsJson", eventsJson);

		return "/home/home";
	}
}