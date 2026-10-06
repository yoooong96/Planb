package util;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

public final class JsonResponse {

	private static final Gson GSON = new GsonBuilder().setDateFormat("yyyy.MM.dd HH:mm").create();

	private JsonResponse() {
		// 공통 메서드만 사용하므로 객체 생성 방지
	}

	public static void writeFailure(HttpServletResponse response, int status, String message) throws IOException {

		response.setStatus(status);

		Map<String, Object> result = new HashMap<>();
		result.put("success", false);
		result.put("message", message);

		writeJson(response, result);
	}

	public static void writeJson(HttpServletResponse response, Map<String, Object> result) throws IOException {

		response.setContentType("application/json;charset=UTF-8");

		response.getWriter().write(GSON.toJson(result));
	}
}