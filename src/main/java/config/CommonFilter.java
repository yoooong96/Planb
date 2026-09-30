	package config;
	
	import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//모든 URL 패턴(/*)에 필터 적용
@WebFilter(
	urlPatterns = "/*"
)

	
	public class CommonFilter implements Filter {
	
		@Override
		public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
			HttpServletRequest req = (HttpServletRequest)request;
			HttpServletResponse res = (HttpServletResponse)response;
			
			req.setCharacterEncoding("utf-8");
			res.setCharacterEncoding("utf-8");
			
			chain.doFilter(req,res);
		}
	}
