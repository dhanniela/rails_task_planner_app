module ApplicationHelper
    def on_login_or_signup_page?
        current_page?(new_user_session_path) || current_page?(new_user_registration_path)
    end
end
