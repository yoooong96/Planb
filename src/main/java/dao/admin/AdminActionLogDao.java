package dao.admin;

import dto.admin.AdminActionLogDto;

public interface AdminActionLogDao {

	int insertAdminActionLog(AdminActionLogDto adminActionLogDto);

	AdminActionLogDto selectAdminActionLog(long actionId);

	int deleteAdminActionLog(long actionId);
}